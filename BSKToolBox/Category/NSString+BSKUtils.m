//
//  NSString+BSKUtils.m
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/15.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import "NSString+BSKUtils.h"

@interface BSKNSStringUtilsConfig()
@property (copy, nonatomic) NSString * bucketName;
@end

@implementation BSKNSStringUtilsConfig

+(instancetype)shareConfig{
    static BSKNSStringUtilsConfig * cfg = nil;
    if (!cfg) {
       cfg = [[BSKNSStringUtilsConfig alloc] init];
        cfg.bucketName = nil;
    }
    return cfg;
}

-(void)setCIBucketName:(NSString *)bucketName{
    self.bucketName = bucketName;
}

@end

@implementation NSString (BSKUtils)

-(BOOL)bsk_isEmptyString{
    
    return [self isEqualToString:@""];
}
-(BOOL)bsk_isStartWith:(NSString*__nonnull)str;
{
    return [self hasPrefix:str];
}
-(BOOL)bsk_isEndWith:(NSString*__nonnull)str{
    return [self hasSuffix:str];
}


-(NSURL*__nullable)bsk_UrlFromeString{
    return [NSURL URLWithString:self];
}
-(NSURL*__nullable)bsk_HttpsUrlFromeHttpString{
    
    NSString * httpsStr = [self stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
    return [NSURL URLWithString:httpsStr];
}


-(NSURL*__nonnull)bsk_CIImageHttpsUrlWithSize:(CGSize)size{
    return [self bsk_CIImageHttpsUrlWithWidth:size.width Height:size.height];
}

-(NSURL*__nonnull)bsk_CIImageHttpsUrlWithWidth:(CGFloat)width Height:(CGFloat)height{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSMutableString * mstr = [[self stringByReplacingOccurrencesOfString:@"http://"
                                                              withString:@"https://"] mutableCopy];
    
    if ([BSKNSStringUtilsConfig shareConfig].bucketName) {
        NSString * str = [NSString stringWithFormat:@"://%@.file.myqcloud.com",[BSKNSStringUtilsConfig shareConfig].bucketName];
        NSString * str2 = [NSString stringWithFormat:@"://%@.cosgz.myqcloud.com",[BSKNSStringUtilsConfig shareConfig].bucketName];
        NSString * CIStr = [NSString stringWithFormat:@"://%@.image.myqcloud.com",[BSKNSStringUtilsConfig shareConfig].bucketName];
        
        NSRange range = [mstr rangeOfString:str];
        if (range.location != NSNotFound) {
            [mstr replaceCharactersInRange:range withString:CIStr];
        }
        
        range = [self rangeOfString:str2];
        if (range.location != NSNotFound) {
            [mstr replaceCharactersInRange:range withString:CIStr];
        }
        
    }else{
        NSRange range = [mstr rangeOfString:@".file.myqcloud.com"];
        if (range.location != NSNotFound) {
            [mstr replaceCharactersInRange:range withString:@".image.myqcloud.com"];
        }
        
        range = [self rangeOfString:@".cosgz.myqcloud.com"];
        if (range.location != NSNotFound) {
            [mstr replaceCharactersInRange:range withString:@".image.myqcloud.com"];
        }
        
    }
    [mstr appendFormat:@"?imageView2/3/w/%lf/h/%lf",width*scale,height*scale];
    
    return [NSURL URLWithString:mstr];
}

-(NSMutableAttributedString *)bsk_addDeleteLine{
    return [[NSMutableAttributedString alloc]initWithString:self
                                                 attributes:
            @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSBaselineOffsetAttributeName:@(0)}];
}



@end

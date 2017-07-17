//
//  NSString+BSKUtils.m
//  BSKToolsBoxDemo
//
//  Created by 刘万林 on 2017/7/15.
//  Copyright © 2017年 BlueSky335. All rights reserved.
//

#import "NSString+BSKUtils.h"

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


-(NSURL*__nonnull)bsk_UrlFromeHttpString{
    return [NSURL URLWithString:self];
}
-(NSURL*__nonnull)bsk_HttpsUrlFromeHttpString{
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
    
    NSRange range = [mstr rangeOfString:@"://town-1253237305.file.myqcloud.com"];
    
    if (range.location != NSNotFound) {
        [mstr replaceCharactersInRange:range withString:@"://town-1253237305.image.myqcloud.com"];
    }
    
    range = [self rangeOfString:@"town-1253237305.cosgz.myqcloud.com"];
    
    if (range.location != NSNotFound) {
        [mstr replaceCharactersInRange:range withString:@"town-1253237305.image.myqcloud.com"];
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

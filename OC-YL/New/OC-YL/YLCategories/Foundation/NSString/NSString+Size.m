//
//  NSString+Size.m
//  OC-YL
//
//  Created by melon on 2018/2/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
- (CGSize)yl_sizeForFont:(UIFont *)font;
{
    return [self yl_sizeForFont:font maxSize:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
}
- (CGSize)yl_sizeForFont:(UIFont *)font maxSize:(CGSize)size
{
    return [self yl_sizeForFont:font maxSize:size mode:NSLineBreakByWordWrapping];
}
- (CGFloat)yl_widthForFont:(UIFont *)font
{
    CGSize size = [self yl_sizeForFont:font maxSize:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}
- (CGFloat)yl_heightForFont:(UIFont *)font maxWidth:(CGFloat)width
{
    CGSize size = [self yl_sizeForFont:font maxSize:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}
- (CGSize)yl_sizeForFont:(UIFont *)font maxSize:(CGSize)size mode:(NSLineBreakMode)lineBreakMode
{
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    if (lineBreakMode != NSLineBreakByWordWrapping) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = lineBreakMode;
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
    return rect.size;
}

@end

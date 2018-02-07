//
//  NSString+YLDrawing.m
//  OC-YL
//
//  Created by melon on 2018/2/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "NSString+YLDrawing.h"

@implementation NSString (YLDrawing)
- (CGSize)yl_sizeForFont:(UIFont *)font maxSize:(CGSize)size mode:(NSLineBreakMode)lineBreakMode
{
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
        result = rect.size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
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
@end

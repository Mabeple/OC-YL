//
//  UIImageView+CornerRadius.m
//  DailyCategory
//
//  Created by melon on 2017/8/25.
//  Copyright © 2017年 cy. All rights reserved.
//

#import "UIImageView+CornerRadius.h"
#import <objc/runtime.h>
static NSString *const _cornerRadiusKey = @"cornerRadiusKey";
@implementation UIImageView (CornerRadius)

- (CGFloat)yl_cornerRadius
{
    NSNumber *yl_cornerRadius = objc_getAssociatedObject(self, (__bridge const void *)(_cornerRadiusKey));
    return yl_cornerRadius.floatValue;
}

- (void)setYl_cornerRadius:(CGFloat)yl_cornerRadius
{
    objc_setAssociatedObject(self, (__bridge const void *)(_cornerRadiusKey), @(yl_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self clipCircle:yl_cornerRadius];
}

- (void)clipCircle:(CGFloat)cornerRadius
{
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    UIBezierPath *backgroundRect = [UIBezierPath bezierPathWithRect:self.bounds];
    [[UIColor whiteColor] setFill];
    [backgroundRect fill];
    [bezierPath addClip];
    UIImage *image = self.image;
    [self.image drawInRect:self.bounds];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
//- (void)yl_cornerRadius:(CGFloat)cornerRadius
//{
//    CGSize size = self.bounds.size;
//    CGFloat scale = [UIScreen mainScreen].scale;
//    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
//    UIBezierPath *backgroundRect = [UIBezierPath bezierPathWithRect:self.bounds];
//    [[UIColor whiteColor] setFill];
//    [backgroundRect fill];
//    [bezierPath addClip];
//    [self.image drawInRect:self.bounds];
//    self.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//}
@end

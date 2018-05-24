//
//  UIView+CornerRadius.m
//  OC-YL
//
//  Created by cy on 2018/5/24.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIView+CornerRadius.h"
#import <objc/runtime.h>
static char YLCornerRadiusKey;
@implementation UIView (CornerRadius)
- (void)setYl_cornerRadius:(CGFloat)yl_cornerRadius
{
    objc_setAssociatedObject(self, &YLCornerRadiusKey, @(yl_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self yl_roundedCornerWithRadius:yl_cornerRadius];
}

- (CGFloat)yl_cornerRadius
{
    return [objc_getAssociatedObject(self, &YLCornerRadiusKey) doubleValue];
}
- (void)yl_roundedCornerWithRadius:(CGFloat)radius
{
    [self yl_roundedCornerWithRadius:radius corners:UIRectCornerAllCorners];
}
- (void)yl_roundedCornerWithRadius:(CGFloat)radius corners:(UIRectCorner)corners
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}
@end

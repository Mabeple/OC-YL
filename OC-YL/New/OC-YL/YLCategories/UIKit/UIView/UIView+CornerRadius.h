//
//  UIView+CornerRadius.h
//  OC-YL
//
//  Created by cy on 2018/5/24.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)

@property (nonatomic, assign) CGFloat yl_cornerRadius;/** cornerRadius  */


/**
 * roundedCorner with allRectCorner
 @param radius radius
 */
- (void)yl_roundedCornerWithRadius:(CGFloat)radius;

/**
 roundedCorner

 @param radius radius
 @param corners RectCorner
 */
- (void)yl_roundedCornerWithRadius:(CGFloat)radius corners:(UIRectCorner)corners;
@end

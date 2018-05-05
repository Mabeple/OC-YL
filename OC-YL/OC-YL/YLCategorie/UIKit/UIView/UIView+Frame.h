//
//  UIView+YLFrame.h
//  DailyCategory
//
//  Created by melon on 2017/8/25.
//  Copyright © 2017年 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic, assign) CGFloat yl_x;
@property (nonatomic, assign) CGFloat yl_y;

@property (nonatomic, assign) CGFloat yl_width;
@property (nonatomic, assign) CGFloat yl_height;

@property (nonatomic, assign) CGFloat yl_centerX;
@property (nonatomic, assign) CGFloat yl_centerY;


@property (nonatomic, assign) CGFloat yl_left;
@property (nonatomic, assign) CGFloat yl_right;
@property (nonatomic, assign) CGFloat yl_top;
@property (nonatomic, assign) CGFloat yl_bottom;


@property (nonatomic, assign) CGSize yl_size;
@end

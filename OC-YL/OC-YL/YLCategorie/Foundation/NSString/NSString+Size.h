//
//  NSString+Size.h
//  OC-YL
//
//  Created by melon on 2018/2/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (Size)
- (CGSize)yl_sizeForFont:(UIFont *)font maxSize:(CGSize)size;
- (CGSize)yl_sizeForFont:(UIFont *)font maxSize:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;
- (CGFloat)yl_widthForFont:(UIFont *)font;
- (CGFloat)yl_heightForFont:(UIFont *)font maxWidth:(CGFloat)width;
@end
NS_ASSUME_NONNULL_END

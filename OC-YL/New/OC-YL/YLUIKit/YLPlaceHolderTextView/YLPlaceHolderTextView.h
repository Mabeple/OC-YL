//
//  YLPlaceHolderTextView.h
//  OC-YL
//
//  Created by cy on 2018/5/24.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface YLPlaceHolderTextView : UITextView
@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end

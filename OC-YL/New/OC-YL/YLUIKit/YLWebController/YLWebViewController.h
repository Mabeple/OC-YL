//
//  YLWebViewController.h
//  weicou
//
//  Created by couba001 on 2017/6/16.
//  Copyright © 2017年 couba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLWebViewController : UIViewController
@property (nonatomic, copy) NSString *htmlStr;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *localFile;
@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, assign) NSInteger campaign_category;
@property (nonatomic, assign) NSInteger campaign_id;
@end

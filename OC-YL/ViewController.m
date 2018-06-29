//
//  ViewController.m
//  OC-YL
//
//  Created by melon on 2018/2/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "ViewController.h"
#import "YLImport.h"
#import "YLPlaceHolderTextView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *textf;
@property (weak, nonatomic) IBOutlet YLPlaceHolderTextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self jk_version];
//    DLog(@"%@",[@"dqwd" yl_md5]);
//    DLog(@"%f",[@"dqwd" yl_sizeForFont:[UIFont systemFontOfSize:15]].height);
//    DLog(@"%@",[aa yl_propertyKeys]);
//    DLog(@"%@",[aa jk_propertyKeys]);
//    self.textf.yl_maxLength = 5;
//    self.textView.yl_maxLength = 3;
////    self.btn.yl_cornerRadius = 5;
////    self.btn.layer.cornerRadius = 5;
//    [self.btn yl_shadowWithColor:[UIColor blackColor] offset:CGSizeMake(3, 3) opacity:0.3 radius:3];
//
////    [self.btn yl_shadowWithCornerRadius:5 color:[UIColor blackColor] offset:CGSizeMake(3, 5) opacity:0.3 radius:3];
////    - (void)yl_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier;
////
////    + (NSURL *)yl_appURLForIdentifier:(NSInteger)identifier;
////
////
////    + (void)yl_openAppReviewURLForIdentifier:(NSInteger)identifier;
////
////    + (BOOL)yl_containsITunesURLString:(NSString*)URLString;
////    + (NSInteger)yl_IDFromITunesURL:(NSString*)URLString;
//    [self.btn yl_touchUpInside:^{
//        [self yl_presentStoreKitItemWithIdentifier:1252929009];
//    }];

}

- (IBAction)fewfewf:(UIButton *)sender {
    
    [sender yl_showIndicator];
    NSLog(@"10.0");
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.btn yl_hideIndicator];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

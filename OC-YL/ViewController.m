//
//  ViewController.m
//  OC-YL
//
//  Created by melon on 2018/2/7.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[@"123" yl_md5]);
    NSString *str = @"幅度为范文芳违反违反为范围违反";
    CGSize size = [str yl_sizeForFont:[UIFont systemFontOfSize:20] maxSize:CGSizeMake(100, 200)];
    
    NSLog(@"%@",NSStringFromCGSize(size));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  自定义TextView
//
//  Created by HCL黄 on 16/11/4.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

#import "ViewController.h"
#import "HHTextView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet HHTextView *textViewXIB;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 代码创建
    HHTextView *textView = [[HHTextView alloc] init];
    textView.frame = CGRectMake(20, 64, 200, 100);
    textView.placehoder = @"我是代码创建的";
    textView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:textView];
    
    
    // xib创建
    self.textViewXIB.placehoder = @"我是xib创建的";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end

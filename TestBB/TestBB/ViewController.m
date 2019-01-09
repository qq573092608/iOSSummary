//
//  ViewController.m
//  TestBB
//
//  Created by 黄小刚 on 2019/1/9.
//  Copyright © 2019年 黄小刚. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /*这种方法使用的是私有api有可能过不了审核*/
    /*
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject * workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    
    BOOL isopen = [workspace performSelector:@selector(openApplicationWithBundleID:) withObject:@"com.hxg.eduShcool"];
   */
    
    
    NSURL *url = [NSURL URLWithString:@"testAA://more"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        
        
    }else{
        NSLog(@"没有安装应用");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

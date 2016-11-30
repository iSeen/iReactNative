//
//  ViewController.m
//  iReactNative
//
//  Created by ZhangNing on 2016/11/30.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import "ViewController.h"
#import "RCTRootView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initRNView];
}

-(void)initRNView {
    NSURL *jsCodeLocation;
    jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"iReactNative"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    //注意，这里是 @"iReactNative"
    rootView.frame = CGRectMake(0, 64, 300, 300);
    [self.view addSubview:rootView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

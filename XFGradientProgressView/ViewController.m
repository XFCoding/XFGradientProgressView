//
//  ViewController.m
//  XFGradientProgressView
//
//  Created by XFCoding on 2020/5/12.
//  Copyright © 2020 XFCoding. All rights reserved.
//

#import "ViewController.h"
#import "XFGradientProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XFGradientProgressView *arcProgress = [[XFGradientProgressView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width/2) startColor:nil endColor:nil backProgressColor:nil];
     arcProgress.center = self.view.center;
     [self.view addSubview:arcProgress];
     [arcProgress StartAnimationToProgress:1 durationTime:0];
}


@end

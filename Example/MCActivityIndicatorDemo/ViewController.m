//
//  ViewController.m
//  MCActivityIndicatorDemo
//
//  Created by Chao Ma on 02/10/2017.
//  Copyright © 2017 iMegatron's Lab. All rights reserved.
//

#import "ViewController.h"
#import "CMActivityIndicatorView.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CMActivityIndicatorView *indicator = [[CMActivityIndicatorView alloc] init];
    //indicator.ringRadius = 50;
    [self.view addSubview: indicator];
    [indicator mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(indicator.superview);
    }];
    [indicator startAnimating];
    
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [indicator stopAnimating];
    });
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

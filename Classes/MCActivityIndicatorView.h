//
//  MCActivityIndicatorView.h
//  MCActivityIndicatorDemo
//
//  Created by Chao Ma on 02/10/2017.
//  Copyright © 2017 iMegatron's Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCActivityIndicatorView : UIView

@property (nonatomic, strong) UIColor *ringColor; // Default is [UIColor darkGrayColor]
@property (nonatomic, assign) CGFloat ringRadius; // Default is 10.0
@property (nonatomic, assign) CGFloat ringThickness; // Default is 4.0

#pragma mark - Start and stop
- (void)startAnimating;
- (void)stopAnimating;

@end

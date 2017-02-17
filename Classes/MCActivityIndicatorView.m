//
//  MCActivityIndicatorView.m
//  MCActivityIndicatorDemo
//
//  Created by Chao Ma on 02/10/2017.
//  Copyright © 2017 iMegatron's Lab. All rights reserved.
//

#import "MCActivityIndicatorView.h"

#define DefaultRingColor ([UIColor darkGrayColor])

static const CGFloat DefaultRingRadius = 10.0;
static const CGFloat DefaultRingThickness = 4.0;
static const NSTimeInterval AnimationDuration = 0.5;

@interface MCActivityIndicatorView ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation MCActivityIndicatorView

- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    // Default values
    self.ringColor = DefaultRingColor;
    self.ringRadius = DefaultRingRadius;
    self.ringThickness = DefaultRingThickness;
    
    // Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    return self;
}

// Setup circle layer
- (void)setupCircleLayer {
    // The size of the circle
    self.circleLayer = [[CAShapeLayer alloc] init];
    self.circleLayer.frame = CGRectMake(0, 0, self.ringRadius * 2, self.ringRadius * 2);
    [self.layer addSublayer:self.circleLayer];
    
    // Make a bezier path
    const CGPoint center = CGPointMake(0, 0);
    const CGFloat angleOffset = -M_PI_2;
    const CGFloat startAngle = 0.0 + angleOffset;
    const CGFloat endAngle = M_PI * 2 + angleOffset;
    self.circleLayer.path = [UIBezierPath bezierPathWithArcCenter:center
                                                           radius:self.ringRadius
                                                       startAngle:startAngle
                                                         endAngle:endAngle
                                                        clockwise:YES].CGPath;
    // Setup the layer
    self.circleLayer.fillColor   = [UIColor clearColor].CGColor;
    self.circleLayer.strokeColor = self.ringColor.CGColor;
    self.circleLayer.lineWidth   = self.ringThickness;
    self.circleLayer.lineCap     = kCALineCapRound;
    self.circleLayer.hidden      = YES;
}

#pragma mark - Start and stop
- (void)startAnimating {
    self.isAnimating = YES;

    // Setup circle layer
    [self setupCircleLayer];
    
    self.circleLayer.hidden = NO;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.removedOnCompletion = YES;
    animGroup.duration = AnimationDuration * 2;
    animGroup.repeatCount = HUGE;
    animGroup.fillMode = kCAFillModeForwards;
    
    animGroup.animations = @[[self strokeStartAnimation], [self strokeEndAnimation]];
    [self.circleLayer addAnimation:animGroup forKey:@"groupAnimation"];
}

- (void)stopAnimating {
    self.isAnimating = NO;

    [self.circleLayer removeAllAnimations];
    self.circleLayer.hidden = YES;
}

#pragma mark - Animations
- (CABasicAnimation *)strokeStartAnimation {
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = [NSNumber numberWithDouble:0.0];
    strokeStartAnimation.toValue = [NSNumber numberWithDouble:1.0];
    strokeStartAnimation.duration = AnimationDuration * 2;
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeStartAnimation.repeatCount = 1;
    strokeStartAnimation.fillMode = kCAFillModeForwards;
    return strokeStartAnimation;
}

- (CABasicAnimation *)strokeEndAnimation {
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = [NSNumber numberWithDouble:0.0];
    strokeEndAnimation.toValue = [NSNumber numberWithDouble:1.0];
    strokeEndAnimation.duration = AnimationDuration;
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeEndAnimation.repeatCount = 1;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    return strokeEndAnimation;
}

#pragma mark - Notifications
- (void)applicationDidEnterBackground:(NSNotification *)notification {
    if (self.isAnimating) {
        [self stopAnimating];
        self.isAnimating = YES;
    }
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    if (self.isAnimating) {
        [self startAnimating];
    }
}

@end

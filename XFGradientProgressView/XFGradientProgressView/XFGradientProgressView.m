//
//  XFGradientProgressView.m
//  XFGradientProgressView
//
//  Created by XFCoding on 2020/5/12.
//  Copyright © 2020 XFCoding. All rights reserved.
//

#import "XFGradientProgressView.h"
#import "UIColor+Extension.h"

#define COLOR_HEX(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define COLOR_RGB(r,g,b)         [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kArcCenter (CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2))
#define kArcRadius (self.bounds.size.width/2.0)
#define kStartAngle (3*M_PI_4)
#define kEndAngle (M_PI_4)
#define kArcWidth (5.0f)



@interface XFGradientProgressView ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *progressBackLayer;
//渐变的起始颜色和结束颜色
@property (nonatomic, copy) UIColor *startColor;
@property (nonatomic, copy) UIColor *endColor;
//进度条背景颜色
@property (nonatomic, copy) UIColor *backProgressColor;

@end

@implementation XFGradientProgressView

- (instancetype)initWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor backProgressColor:(UIColor *)backProgressColor{
    if (self = [super initWithFrame:frame]) {
        self.startColor = startColor;
        self.endColor = endColor;
        self.backProgressColor = backProgressColor;
        [self createProgressBar];
    }
    return self;
}

/**
 生成贝塞尔曲线并设置为shapeLayer的路径
 */
- (void)createProgressBar {
    [self.layer addSublayer:self.progressBackLayer];
    [self.layer addSublayer:self.progressLayer];
    
    UIBezierPath *bPath = [UIBezierPath bezierPathWithArcCenter:kArcCenter radius:kArcRadius startAngle:kStartAngle endAngle:kEndAngle clockwise:YES];
    self.progressLayer.path = bPath.CGPath;
    self.progressBackLayer.path = bPath.CGPath;

    
    [self createGradientLayer];
}

/**
 设置色彩渐变图层
 */
- (void)createGradientLayer {
    CALayer *layer = [CALayer layer];
    layer.frame = self.bounds;
    
    if (!self.startColor || !self.endColor) {
        self.startColor = COLOR_HEX(0xfb6400);
        self.endColor = COLOR_HEX(0xfc9c00);
        
    }
   UIColor *mediumColor = [UIColor transitionColorWithStartColor:self.startColor endColor:self.endColor position:0.5];
    
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(-kArcWidth/2, -kArcWidth/2, self.bounds.size.width/2+kArcWidth/2, self.bounds.size.height+kArcWidth/2);
    leftLayer.colors = @[ (id)_startColor.CGColor,(id)mediumColor.CGColor];
    leftLayer.locations = @[@0,@1];
    leftLayer.startPoint = CGPointMake(0, 1);
    leftLayer.endPoint = CGPointMake(1, 0);
    
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.bounds.size.width/2, -kArcWidth/2, self.bounds.size.width/2+kArcWidth/2, self.bounds.size.height+kArcWidth/2);
    rightLayer.colors = @[ (id)mediumColor.CGColor,(id)_endColor.CGColor];
    rightLayer.locations = @[@0,@1];
    rightLayer.startPoint = CGPointMake(0, 0);
    rightLayer.endPoint = CGPointMake(1, 1);
    
    //设置蒙层
    layer.mask = self.progressLayer;
    [layer addSublayer:leftLayer];
    [layer addSublayer:rightLayer];
    [self.layer addSublayer:layer];
}

- (void)StartAnimationToProgress:(CGFloat)progress durationTime:(CGFloat)durationTime{
    CGFloat endAngle = kStartAngle + progress*M_PI*3/2;
    UIBezierPath *bPath = [UIBezierPath bezierPathWithArcCenter:kArcCenter radius:kArcRadius startAngle:kStartAngle endAngle:endAngle clockwise:YES];
    self.progressLayer.path = bPath.CGPath;
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    keyAnimation.values = @[@0.0,@1.0];
    keyAnimation.duration = (durationTime > 0) ? durationTime : 1.0;
    [self.progressLayer addAnimation:keyAnimation forKey:nil];
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _progressLayer.lineWidth = kArcWidth;
        _progressLayer.lineCap = kCALineCapRound;
    }
    return _progressLayer;
}

- (CAShapeLayer *)progressBackLayer {
    if (!_progressBackLayer) {
        _progressBackLayer = [CAShapeLayer layer];
        _progressBackLayer.fillColor = [UIColor clearColor].CGColor;
        _progressBackLayer.lineWidth = kArcWidth;
        _progressBackLayer.lineCap = kCALineCapRound;
        _progressBackLayer.strokeColor = _backProgressColor?_backProgressColor.CGColor : [UIColor grayColor].CGColor;
        
    }
    return _progressBackLayer;
}















@end

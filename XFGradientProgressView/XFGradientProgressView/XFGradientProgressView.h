//
//  XFGradientProgressView.h
//  XFGradientProgressView
//
//  Created by XFCoding on 2020/5/12.
//  Copyright © 2020 XFCoding. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XFGradientProgressView : UIView

/// 初始化进度条
/// @param frame ~
/// @param startColor 起始颜色
/// @param endColor 结束颜色
/// @param backProgressColor 进度条背景颜色
- (instancetype)initWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor backProgressColor:(UIColor *)backProgressColor;



//设置最终进度(0.0~1.0)和动画时间，动画时间默认1.0s
- (void)StartAnimationToProgress:(CGFloat)progress durationTime:(CGFloat)durationTime;






@end


//
//  UIView+Circle.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/24.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "UIView+Circle.h"



@implementation UIView (Circle)

- (void)circle {
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    CAShapeLayer *maskLayer= [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

@end

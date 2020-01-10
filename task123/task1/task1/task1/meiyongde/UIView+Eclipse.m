//
//  UIView+Eclipse.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/25.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "UIView+Eclipse.h"



@implementation UIView (Eclipse)

- (void)eclipse {
    CGFloat rad = self.bounds.size.width/2;
    CGPoint viewCenter = CGPointMake(rad, self.frame.size.height / 2.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:viewCenter radius:rad startAngle:M_PI/6 endAngle:M_PI*11/6 clockwise:YES];
    CGFloat sqrt3 = sqrt(3);
    CGFloat newcenterX = viewCenter.x + rad * sqrt3;
    CGFloat newcenterY = viewCenter.y;
    [path addArcWithCenter:CGPointMake(newcenterX,newcenterY) radius:rad startAngle:M_PI*7/6 endAngle:M_PI*5/6 clockwise:NO];
    [path closePath];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
    
    CAShapeLayer *stroke = [[CAShapeLayer alloc]init];
    stroke.frame = self.bounds;
    stroke.path = path.CGPath;
    stroke.lineWidth = 2.0f;
    stroke.fillColor = nil;
    stroke.strokeColor = [UIColor colorWithWhite:1 alpha:0.2].CGColor;
    [self.layer addSublayer: stroke];
    
}


@end

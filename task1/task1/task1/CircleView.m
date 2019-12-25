//
//  CircleView.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/25.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "CircleView.h"


@implementation CircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)circle {
    self.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    CAShapeLayer *maskLayer= [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = self.path.CGPath;
    self.layer.mask = maskLayer;
}

- (void)stroke {
    CAShapeLayer *stroke = [[CAShapeLayer alloc]init];
    stroke.frame = self.bounds;
    stroke.path = self.path.CGPath;
    stroke.lineWidth = 2.0f;
    stroke.fillColor = nil;
    stroke.strokeColor = [UIColor colorWithWhite:1 alpha:0.2].CGColor;
    [self.layer addSublayer: stroke];
}

@end

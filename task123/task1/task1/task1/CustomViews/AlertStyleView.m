//
//  AlertStyleView.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/27.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "AlertStyleView.h"

@implementation AlertStyleView

- (void)setAlertStyle {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:3];
    CAShapeLayer *maskLayer= [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;

}

@end

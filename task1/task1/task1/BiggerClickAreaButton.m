//
//  BiggerClickAreaButton.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/18.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "BiggerClickAreaButton.h"

@implementation BiggerClickAreaButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于80*80，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(80.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(80.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end

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
    /**
     MARK:@ydhz 发散扩大响应区域👍
     TODO:@txy 思考以下实现，是否有更简单的计算方式
     */
    CGRect bounds = self.bounds;
    //若原热区小于80*80，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(80.0 , bounds.size.width);
    bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, widthDelta, widthDelta);
    return CGRectContainsPoint(bounds, point);
}

@end

//
//  CircleView.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/24.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect {
    /*UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)];
    [[UIColor colorWithRed:0.5 green:0.5 blue:0.9 alpha:1.0] setStroke];
    [path setLineWidth:10];
    [path stroke];*/
    
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
     CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*画圆*/
    CGContextSetRGBFillColor(context, 1, 1, 1, 0.25);//设置填充颜色 颜色这里随机设置的，后面会根据文字来计算颜色
    
    //填充圆，无边框
    CGContextAddArc(context, self.frame.size.width/2.0, self.frame.size.width/2.0, self.frame.size.width/2.0, 0, 2*M_PI, 0);
    //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

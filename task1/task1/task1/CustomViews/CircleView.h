//
//  CircleView.h
//  task1
//
//  Created by tanxiaoyan on 2019/12/25.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleView : UIView

@property (strong, nonatomic) UIBezierPath *path;

- (void)circle;
- (void)stroke;

@end

NS_ASSUME_NONNULL_END

//
//  BaseAnimator.h
//  task1
//
//  Created by tanxiaoyan on 2019/12/17.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) NSTimeInterval  transitionDuration;
@property (nonatomic, weak, readonly) UIViewController  *fromViewController;
@property (nonatomic, weak, readonly) UIViewController  *toViewController;
@property (nonatomic, weak, readonly) UIView            *containerView;

- (void)animateTransitionEvent;
- (void)completeTransition;
@end

NS_ASSUME_NONNULL_END

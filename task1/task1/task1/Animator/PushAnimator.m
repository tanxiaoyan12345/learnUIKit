//
//  pushAnimator.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/17.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "PushAnimator.h"

@implementation PushAnimator
- (void)animateTransitionEvent {
    [self.containerView addSubview:self.toViewController.view];
    self.toViewController.view.alpha   = 0.f;
    [UIView animateWithDuration:self.transitionDuration
                          delay:0.0f
         usingSpringWithDamping:1 initialSpringVelocity:0.f options:0 animations:^{

             self.fromViewController.view.alpha = 0.f;
             self.toViewController.view.alpha   = 1.f;
             
         } completion:^(BOOL finished) {
             
             
             [self completeTransition];
         }];
}
@end

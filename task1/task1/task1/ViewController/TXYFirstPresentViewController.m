//
//  TXYFirstPresentViewController.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/26.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "TXYFirstPresentViewController.h"

@implementation TXYFirstPresentViewController

#pragma mark - UIViewControllerTransitioningDelegate
/*
 * 来告诉控制器，谁是动画主管(UIPresentationController)，因为此类继承了UIPresentationController，就返回了self
 */
- (UIPresentationController* )presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return self;
}

#pragma mark - 重写UIPresentationController个别方法
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
    if (self) {
        // The presented view controller must have a modalPresentationStyle
        // of UIModalPresentationCustom for a custom presentation controller
        // to be used.
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    
    return self;
}

- (void)presentationTransitionWillBegin {
 
}

// 在呈现过渡结束时被调用的，并且该方法提供一个布尔变量来判断过渡效果是否完成
- (void)presentationTransitionDidEnd:(BOOL)completed {

}

// 消失过渡即将开始的时候被调用的
- (void)dismissalTransitionWillBegin {
}

// 消失过渡完成之后调用，此时应该将视图移除，防止强引用
- (void)dismissalTransitionDidEnd:(BOOL)completed{
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
}

//  This method is invoked whenever the presentedViewController's
//  preferredContentSize property changes.  It is also invoked just before the
//  presentation transition begins (prior to -presentationTransitionWillBegin).
//  建议就这样重写就行，这个应该是控制器内容大小变化时，就会调用这个方法， 比如适配横竖屏幕时，翻转屏幕时
//  可以使用UIContentContainer的方法来调整任何子视图控制器的大小或位置。
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController)
        [self.containerView setNeedsLayout];
}

@end

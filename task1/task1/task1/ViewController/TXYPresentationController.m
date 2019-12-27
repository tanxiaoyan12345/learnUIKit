//
//  TXYPresentationController.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/26.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "TXYPresentationController.h"

@interface TXYPresentationController () <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) UIView *dimmingView;


@end

@implementation TXYPresentationController

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

// 呈现过渡即将开始的时候被调用的
// 可以在此方法创建和设置自定义动画所需的view
- (void)presentationTransitionWillBegin {
    // 背景遮罩
    UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    dimmingView.backgroundColor = [UIColor blackColor];
    dimmingView.opaque = NO; //是否透明
    dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
    self.dimmingView = dimmingView;
    
    [self.containerView addSubview:dimmingView]; // 添加到动画容器View中。
    
    // 获取presentingViewController 的转换协调器，应该动画期间的一个类？上下文？之类的，负责动画的一个东西
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    // 动画期间，背景View的动画方式
    self.dimmingView.alpha = 0.f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.4f;
    } completion:NULL];
}

- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:NO completion:NULL];
}

// 在呈现过渡结束时被调用的，并且该方法提供一个布尔变量来判断过渡效果是否完成
- (void)presentationTransitionDidEnd:(BOOL)completed {
    // 在取消动画的情况下，可能为NO，这种情况下，应该取消视图的引用，防止视图没有释放
    if (!completed) {
        self.dimmingView = nil;
    }
}

// 消失过渡即将开始的时候被调用的
- (void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}

// 消失过渡完成之后调用，此时应该将视图移除，防止强引用
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == YES)
    {
        [self.dimmingView removeFromSuperview];
        self.dimmingView = nil;
    }
}

//- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
//{
//    if (container == self.presentedViewController)
//        return ((UIViewController*)container).preferredContentSize;
//    else
//        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
//}

//在我们的自定义呈现中，被呈现的 view 并没有完全完全填充整个屏幕，
//被呈现的 view 的过渡动画之后的最终位置，是由 UIPresentationViewController 来负责定义的。
//我们重载 frameOfPresentedViewInContainerView 方法来定义这个最终位置
/*
- (CGRect)frameOfPresentedViewInContainerView
{

//    CGRect presentedViewControllerFrame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, [UIScreen mainScreen].bounds.size.height/2-125, 300, 250);
//    return presentedViewControllerFrame;
}*/

//  This method is similar to the -viewWillLayoutSubviews method in
//  UIViewController.  It allows the presentation controller to alter the
//  layout of any custom views it manages.
//
- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    self.dimmingView.frame = self.containerView.bounds;
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

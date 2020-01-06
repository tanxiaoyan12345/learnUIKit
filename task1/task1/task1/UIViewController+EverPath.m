//
//  UIViewController+EverPath.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/31.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "UIViewController+EverPath.h"
#import "MyViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (EverPath)

+ (void)load
{
//#ifdef DEBUG
//#if kPrintPathLog == 1
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [UIViewController class];
        Method m1 = class_getInstanceMethod(cls, @selector(viewWillAppear:));
        Method m2 = class_getInstanceMethod(cls, @selector(ViewDidLoad_EverPath));
        method_exchangeImplementations(m1, m2);
    });
//#endif
//#endif
}
- (void)ViewDidLoad_EverPath
{
    [self ViewDidLoad_EverPath];
//   UIViewController *controller = self;
//    [Message show:NSStringFromClass([controller class])];
    if([self isKindOfClass:[MyViewController class]]){
        UIView *toast = [[UIView alloc] initWithFrame:CGRectMake(100, 500, 200, 80)];
        toast.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        UILabel *label = [[UILabel alloc] initWithFrame:toast.bounds];
        label.text = NSStringFromClass(self.class);
        [toast addSubview:label];
        [self.view addSubview:toast];
        printf("Ever_VC_Path:%s---%p\n",NSStringFromClass(self.class).UTF8String, self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [toast removeFromSuperview];
        });
    }
    
}
@end

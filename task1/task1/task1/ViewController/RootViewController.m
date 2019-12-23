//
//  RootViewController.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/16.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"
#import "PushAnimator.h"
@interface RootViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) UIButton *myButton;

@end

@implementation RootViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBarHidden = YES;
    [self initViews];
    self.navigationController.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)viewWillAppear:(BOOL)animated {
    /**
     MARK:@ydhz delegate的设置时机需要思考，参考viewWillAppear的调用时机
     */
    /**
     当view即将被显示时调用,此时superview 为nil，也就是说这个是controller还不知道superview是谁。
    这个阶段会加载一些高开销的操作，例如：键盘弹出、特殊的过程动画（比方说修改状态栏、导航条颜色等等）这些。
     */
    [super viewWillAppear:animated];
 //   self.navigationController.delegate = self;
//  这样实现效果不是很好
//  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//  这样实现效果不是很好
// [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)initViews{
    self.title = @"首页";
    self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
/**
 MARK:@ydhz UIButtonTypeRoundedRect is deprecated!
 */
    //尝试使用UIButtonTypeRoundRect失败

    self.myButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-50,[UIScreen mainScreen].bounds.size.height/2-25,100,50);
    self.myButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.myButton setTitle:@"Hit me!" forState:UIControlStateNormal];
    [self.myButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //设置边框的颜色
    [self.myButton.layer setBorderColor:[UIColor grayColor].CGColor];
    //设置边框的粗细
    [self.myButton.layer setBorderWidth:2.0];
    //圆角大小
    self.myButton.layer.cornerRadius = 3;
    self.myButton.layer.masksToBounds = YES;
     
    
    [self.myButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myButton];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 动画代理UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        
        return [[PushAnimator alloc] init];
    }
    return nil;
}


#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController  didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是首页，是首页本身就隐藏导航栏
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    NSLog(@"%s",isShowHomePage?"YES":"NO");
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}


/*- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己，是自己就隐藏导航栏
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}*/

#pragma mark - action

- (void)buttonEvent:(UIButton *)button {
    
    [self.navigationController pushViewController:[SecondViewController new]
                                         animated:YES];
}



@end

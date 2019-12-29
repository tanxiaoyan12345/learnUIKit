//
//  TXYTask2FirstViewController.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/24.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "TXYTask2FirstViewController.h"
#import "TXYAlertViewController.h"
#import "UIColor+Hexadecimal.h"
#import "CircleView.h"
#import "EclipseView.h"
#import "TXYPresentationController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface TXYTask2FirstViewController ()

@property (strong, nonatomic) UIImage *backGroundImage;
@property (strong, nonatomic) CircleView *closeButton;
@property (strong, nonatomic) UIButton *tipOff;
@property (strong, nonatomic) EclipseView *leftHead;
@property (strong, nonatomic) CircleView *rightHead;
@property (strong, nonatomic) UIImage *leftHeadImage;
@property (strong, nonatomic) UIImage *rightHeadImage;
@property (strong, nonatomic) UIButton *openNickNameButton;
@property (strong, nonatomic) UILabel *callEnd;
@property (strong, nonatomic) UILabel *openNickNameLabel;
@property (strong, nonatomic) UILabel *reMind;
@property (strong, nonatomic) UIView *headImageView;

@end

@implementation TXYTask2FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBackground];
    [self initButtons];
    [self initheadimages];
    [self initLabels];
}

- (void)initBackground {
    self.backGroundImage = [UIImage imageNamed:@"1.jpg"];
    self.view.layer.contents = (__bridge id)self.backGroundImage.CGImage;
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame =self.view.frame;
    [self.view addSubview:effectview];
}

- (void)initButtons {
    self.closeButton = [[CircleView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-30, 550, 60, 60)];
    [self.closeButton circle];
    self.closeButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    UIImage *closeImage = [UIImage imageNamed:@"icon_close_white@3x.png"];
    UIImageView *closeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
    closeImageView.image = closeImage;
    [self.closeButton addSubview:closeImageView];
    [self.view addSubview:self.closeButton];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTempView)];
    self.closeButton.userInteractionEnabled = YES;
    [self.closeButton addGestureRecognizer:tap];
    
    self.tipOff = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tipOff.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100,50,80,50);
    [self.tipOff setTitle:@"举报" forState:UIControlStateNormal];
    [self.tipOff setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tipOff addTarget:self action:@selector(tipOffEvent) forControlEvents:UIControlEventTouchUpInside];
    self.tipOff.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tipOff];
    
    self.openNickNameButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-120, [UIScreen mainScreen].bounds.size.height/2-22, 240, 44)];
    self.openNickNameButton.layer.cornerRadius = 22;
    self.openNickNameButton.backgroundColor = [UIColor colorWithHexString:@"#FE2C55"];
//这样做文字会虚？？？
//    [self.openNickNameButton setTitle:@"向对方公开昵称" forState:UIControlStateNormal];
//    [self.openNickNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.openNickNameButton.titleLabel.font = [UIFont systemFontOfSize:18];
//emmmm,两种都虚
    self.openNickNameLabel = [[UILabel alloc] initWithFrame:self.openNickNameButton.bounds];
    self.openNickNameLabel.text = @"向对方公开昵称";
    self.openNickNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.openNickNameLabel.textAlignment = NSTextAlignmentCenter;
    self.openNickNameLabel.textColor = [UIColor whiteColor];
    [self.openNickNameButton addSubview:self.openNickNameLabel];
    [self.openNickNameButton addTarget:self action:@selector(openNickNameEvent:) forControlEvents:UIControlEventTouchUpInside];
//最初这样的目的是考虑组透明
    //self.openNickNameButton.layer.shouldRasterize = YES;
    [self.view addSubview:self.openNickNameButton];
    
    
}
- (void)initheadimages {
    self.headImageView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-77, [UIScreen mainScreen].bounds.size.height/2-200, 154, 80)];
    [self.view addSubview:self.headImageView];
    
    self.leftHead = [[EclipseView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [self.leftHead eclipse];
    [self.leftHead stroke];
    [self.headImageView addSubview:self.leftHead];
    self.leftHeadImage = [UIImage imageNamed:@"2.jpg"];
    self.leftHead.layer.contents = (__bridge id)self.leftHeadImage.CGImage;
    self.leftHead.layer.contentsGravity = kCAGravityResize;
    self.leftHead.layer.contentsScale = self.leftHeadImage.scale;
    
    self.rightHead = [[CircleView alloc] initWithFrame:CGRectMake(74, 0, 80, 80)];
    [self.rightHead circle];
    [self.rightHead stroke];
    [self.headImageView addSubview:self.rightHead];
    self.rightHeadImage = [UIImage imageNamed:@"3.jpg"];
    self.rightHead.layer.contents = (__bridge id)self.rightHeadImage.CGImage;
    self.leftHead.layer.contentsGravity = kCAGravityResize;
    self.leftHead.layer.contentsScale = self.leftHeadImage.scale;
}

- (void)initLabels {
    self.callEnd = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-80, [UIScreen mainScreen].bounds.size.height/2-80, 160, 50)];
    self.callEnd.text = @"连线结束 00:00";
    self.callEnd.textAlignment = NSTextAlignmentCenter;
    self.callEnd.font =[UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.callEnd.textColor = [UIColor whiteColor];
    [self.view addSubview:self.callEnd];
    self.reMind = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-125, [UIScreen mainScreen].bounds.size.height/2+30, 250, 50)];
    self.reMind.text = @"双方均公开后，可互相查看个人信息";
    self.reMind.textAlignment = NSTextAlignmentCenter;
    self.reMind.font =[UIFont systemFontOfSize:14];
    self.reMind.textColor = [UIColor whiteColor];
    [self.view addSubview:self.reMind];
}

- (void)closeTempView {
     [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)tipOffEvent {
//    TXYAlertViewController *alert = [[TXYAlertViewController alloc] init];
//    alert.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
//    alert.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self presentViewController:alert animated:true completion:nil];
    TXYAlertViewController *toVC = [[TXYAlertViewController alloc] init];
    TXYPresentationController *presentationC = [[TXYPresentationController alloc] initWithPresentedViewController:toVC presentingViewController:self];
    toVC.transitioningDelegate = presentationC;
    [self presentViewController:toVC animated:YES completion:nil];
}

- (void)openNickNameEvent:(UIButton *)sender {
    [self shakingAnimation];
    AudioServicesPlaySystemSound(1012);
    [self actionFixMultiClick_enabled:sender];
}

- (void)actionFixMultiClick_enabled:(UIButton *)sender {
    sender.enabled = NO;
    sender.alpha = 0.5;
}

- (void)shakingAnimation {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@((-5) / 180.0 * M_PI), @((5) / 180.0 * M_PI), @((-5) / 180.0 * M_PI)];
    anim.duration = 0.25;
    //anim.delegate = self;
    [self.openNickNameButton.layer addAnimation:anim forKey:nil];
}


@end

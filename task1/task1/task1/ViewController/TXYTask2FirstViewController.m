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

@interface TXYTask2FirstViewController ()

@property (strong, nonatomic) UIImage *backGroundImage;
@property (strong, nonatomic) CircleView *closeButton;
@property (strong, nonatomic) UIButton *tipOff;
@property (strong, nonatomic) EclipseView *leftHead;
@property (strong, nonatomic) CircleView *rightHead;
@property (strong, nonatomic) UIImage *leftHeadImage;
@property (strong, nonatomic) UIImage *rightHeadImage;
@property (strong, nonatomic) UIButton *openNickNameButton;
@property (strong, nonatomic) CALayer *animationLayer;
@property (strong, nonatomic) CALayer *calleEnd;

@end

@implementation TXYTask2FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBackground];
    [self initButtons];
    [self initheadimages];

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
    [self.openNickNameButton setTitle:@"向对方公开昵称" forState:UIControlStateNormal];
    [self.openNickNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.openNickNameButton addTarget:self action:@selector(openNickNameEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.openNickNameButton.layer.shouldRasterize = YES;
    [self.view addSubview:self.openNickNameButton];
    
    
}
- (void)initheadimages {
    self.leftHead = [[EclipseView alloc] initWithFrame:CGRectMake(130, 220, 80, 80)];
    [self.leftHead eclipse];
    [self.leftHead stroke];
    [self.view addSubview:self.leftHead];
    self.leftHeadImage = [UIImage imageNamed:@"2.jpg"];
    self.leftHead.layer.contents = (__bridge id)self.leftHeadImage.CGImage;
    self.leftHead.layer.contentsGravity = kCAGravityResize;
    self.leftHead.layer.contentsScale = self.leftHeadImage.scale;
    
    self.rightHead = [[CircleView alloc] initWithFrame:CGRectMake(205, 220, 80, 80)];
    [self.rightHead circle];
    [self.rightHead stroke];
    [self.view addSubview:self.rightHead];
    self.rightHeadImage = [UIImage imageNamed:@"3.jpg"];
    self.rightHead.layer.contents = (__bridge id)self.rightHeadImage.CGImage;
    self.leftHead.layer.contentsGravity = kCAGravityResize;
    self.leftHead.layer.contentsScale = self.leftHeadImage.scale;
}


- (void)closeTempView {
     [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)tipOffEvent {
    TXYAlertViewController *alert = [[TXYAlertViewController alloc] init];
    alert.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    alert.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:alert animated:true completion:nil];
    
}

- (void)openNickNameEvent:(UIButton *)sender {
    [self shakingAnimation];
    [self actionFixMultiClick_enabled:sender];
}

- (void)actionFixMultiClick_enabled:(UIButton *)sender {
    sender.enabled = NO;
    sender.alpha = 0.5;
}

#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)
- (void)shakingAnimation {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(Angle2Radian(-5)), @(Angle2Radian(5)), @(Angle2Radian(-5))];
    anim.duration = 0.25;
    anim.delegate = self;
    [self.openNickNameButton.layer addAnimation:anim forKey:nil];
}

@end

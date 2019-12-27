//
//  TXYAlertViewController.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/24.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "TXYAlertViewController.h"
#import "UIView+AlertStyle.h"
#import "Masonry.h"
#import "UIColor+Hexadecimal.h"
#import "AlertStyleView.h"
@interface TXYAlertViewController ()

@property (strong, nonatomic) AlertStyleView *alertView;
@property (strong, nonatomic) UILabel *alertTitle;
@property (strong, nonatomic) UILabel *alertContent;
@property (strong, nonatomic) UIButton *cancelButton;

@end

@implementation TXYAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initAlertView];
}

- (void)initAlertView {
    self.alertView = [[AlertStyleView alloc] initWithFrame:self.view.bounds];
    self.alertView = [[AlertStyleView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, [UIScreen mainScreen].bounds.size.height/2-125, 300, 250)];
    [self.alertView setAlertStyle];
    self.alertView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.alertView];
    
    self.alertTitle = [[UILabel alloc] init];
   // self.alertTitle.frame = CGRectMake(10, 10, 100, 50);
    self.alertTitle.text = @"举报成功";
    self.alertTitle.textAlignment = NSTextAlignmentCenter;
    self.alertTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self.alertView addSubview:self.alertTitle];
    
    self.alertContent = [[UILabel alloc] init];
    self.alertContent.text = @"您的举报会在12小时内受理，若举报成功将第一时间告知处理结果，无需重复举报，感谢您的配合。";
    self.alertContent.lineBreakMode = NSLineBreakByWordWrapping;
   // self.alertContent.adjustsFontSizeToFitWidth = YES;
    self.alertContent.numberOfLines = 0;
    //self.alertContent.textAlignment = NSTextAlignmentCenter;
    self.alertContent.font = [UIFont systemFontOfSize:16.0];
    [self.alertView addSubview:self.alertContent];
    
    self.cancelButton = [UIButton new];
    self.cancelButton.frame = CGRectMake(0, 100, 300, 150);//这里设置frame是为了让下面添加单边框的layer能显示出来
    /**
     用masonry约束的时候其实并没有给控件一个具体的frame，所以调用 view.frame都是CGRectZero所以添加layer的时候总是看不到效果
     */
    [self.cancelButton setTitle:@"我知道了!" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //self.cancelButton.titleLabel.text = @"我知道了";
    self.cancelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    //self.cancelButton.titleLabel.textColor = [UIColor blackColor];
    CALayer *cancelBtnBorder = [CALayer layer];
    float width=self.cancelButton.bounds.size.width;
    cancelBtnBorder.frame = CGRectMake(0, 0, width, 1);
    cancelBtnBorder.backgroundColor = [UIColor colorWithHexString:@"#C0C0C0"].CGColor;
    [self.cancelButton.layer addSublayer:cancelBtnBorder];
    [self.alertView addSubview:self.cancelButton];
    [self.cancelButton addTarget:self action:@selector(cancelButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self buildElem];
}
 
- (void)buildElem {
//    __weak typeof(self) weakSelf = self;
//    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(weakSelf.view);
//        make.size.mas_equalTo(CGSizeMake(300, 250));
//    }];
    [_alertTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_alertView.mas_top).with.offset(30);
        make.left.right.equalTo(_alertView);
        make.height.equalTo(@30);
    }];
    [_alertContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_alertTitle.mas_bottom).with.offset(10);
        make.left.equalTo(_alertView).with.offset(15);
        make.right.equalTo(_alertView).with.offset(-15);
        make.height.equalTo(@90);
    }];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_alertContent.mas_bottom).with.offset(30);
        make.left.right.and.bottom.equalTo(_alertView);
    }];

}

- (void)cancelButtonEvent {
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

@end

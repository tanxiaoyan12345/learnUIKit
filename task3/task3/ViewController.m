//
//  ViewController.m
//  task3
//
//  Created by tanxiaoyan on 2019/12/31.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"

@interface ViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIButton *start;
//@property (strong, nonatomic) NSTimer *timer;
//@property (strong, nonatomic) dispatch_source_t mytimer;
@property (strong, nonatomic) UIButton *stop;
//@property (strong, nonatomic) NSThread *mythread;//创建一个常驻线程
//@property (assign, nonatomic) NSTimeInterval interval;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger sleeptime;
@property (assign, nonatomic) NSInteger newSleeptime;
@property (assign, nonatomic) NSInteger sleepTimeAddtion;
@property (strong, nonatomic) UITextField *textField;
@property (assign, nonatomic) BOOL isRuning;
@property (strong, nonatomic) NSDate *finishTime;
//@property (weak, nonatomic) NSThread *task1;
//@property (weak, nonatomic) NSThread *task2;
//@property (weak, nonatomic) NSThread *task3;
@property (assign, nonatomic) BOOL stopFlag;
@property (assign, nonatomic) BOOL continueFlag;
@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _start = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, [UIScreen mainScreen].bounds.size.height/2-50, 200, 100)];
    [_start addTarget:self action:@selector(startEvent) forControlEvents:UIControlEventTouchUpInside];
    [_start setTitle:@"start" forState:UIControlStateNormal];
    _start.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_start];
    
    _stop = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, [UIScreen mainScreen].bounds.size.height/2+100, 200, 100)];
    [_stop addTarget:self action:@selector(stopEvent) forControlEvents:UIControlEventTouchUpInside];
    [_stop setTitle:@"stop" forState:UIControlStateNormal];
    _stop.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_stop];

    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 30)];
    _textField.placeholder = @"输入时间间隔：";
    _textField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    _textField.backgroundColor = [UIColor grayColor];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 设置再次编辑是否清空
    _textField.clearsOnBeginEditing = YES;
    // 设置文本对齐方式
    _textField.textAlignment = NSTextAlignmentLeft;
    // 设置键盘的样式
    _textField.keyboardType = UIKeyboardTypeDefault;
    // 设置键盘外观
    _textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    // 设置return键样式
    _textField.returnKeyType = UIReturnKeyDefault;
    // 设置代理，用于实现协议
    _textField.delegate = self;
    [self.view addSubview:_textField];
    [self.textField addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventEditingDidEnd];//点击键盘上的return就相当于确定了当前的输入值

    self.sleepTimeAddtion = 0;//用来记录在间隔时新设置的时间比原间隔时间长时需要继续等待多久
    self.sleeptime = 5;//初始间隔时间设置为5s
    self.newSleeptime = self.sleeptime;
    self.count = 0;
    self.stopFlag = NO;
    self.continueFlag = NO;
}
- (void)endEdit{
    NSString *string = _textField.text;
    self.newSleeptime = [string intValue];
    NSLog(@"set task timer to %lds!",(long)self.newSleeptime);
    //间隔时设置时间的两种情况
    //新间隔大于旧间隔，从此次间隔开始就为新值
    if(self.isRuning==NO && self.newSleeptime>self.sleeptime){
        NSDate *currentTime = [NSDate date];
        double time = [currentTime timeIntervalSinceDate: self.finishTime];
        self.sleepTimeAddtion = time;
        NSLog(@"%ld",self.sleepTimeAddtion);
    }
    //间隔时设置的新的间隔时间小于原间隔时间立即触发新一轮循环
    if(self.isRuning==NO && self.newSleeptime<self.sleeptime){
        self.continueFlag = YES;
        [self stopEvent];
        self.continueFlag = NO;
        [self startEvent];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return YES;
}

- (void) blockOperation {
    NSLog(@"Task%ld Begin!",self.count);
    Task *task = [[Task alloc] init];
    _queue = [[NSOperationQueue alloc]init];
    _queue.maxConcurrentOperationCount = 2;
    self.isRuning = YES;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [task subTaskSimple1];
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [task subTaskSimple2];
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [task subTaskHard];
        self.finishTime = [NSDate date];
        self.count++;
        self.isRuning = NO;
    }];
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        //执行任务时设置新的时间间隔从下一轮开始才生效
        sleep((unsigned int)self.sleeptime);
        sleep((unsigned int)self.sleepTimeAddtion);
        self.sleepTimeAddtion = 0;
        self.sleeptime = self.newSleeptime;
        if(self.stopFlag == NO){
            [weakSelf blockOperation];
        }
    }];
    [_queue addOperation:op1];
    [_queue addOperation:op2];
    _queue.maxConcurrentOperationCount = 1;
    [_queue addOperation:op3];
    [_queue addOperation:op4];
}

- (void)startEvent {
    self.stopFlag = NO;
    [self blockOperation];
}

- (void)stopEvent {
    if(self.continueFlag == NO){//判断是按了stop按钮之后的停止还是间隔时设置时间变短需要开新一轮循环时的停止
        self.count = 0;
    }
    self.stopFlag = YES;
    self.isRuning = NO;
//    NSLog(@"想要停止");
    [_queue cancelAllOperations];//停止时移除当前队列的所有操作
    
}

@end

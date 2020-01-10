//
//  Task.m
//  task3
//
//  Created by tanxiaoyan on 2019/12/31.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "Task.h"

@implementation Task

- (void)subTaskSimple1 {
    int value = (arc4random() % 10) + 1;
    NSLog(@"即将睡眠%ds",value);
    sleep(value);
    NSLog(@"subTaskSimple1 completed！");
}

- (void)subTaskSimple2 {
    int value = (arc4random() % 10) + 1;
    NSLog(@"即将睡眠%ds",value);
    sleep(value);
    NSLog(@"subTaskSimple2 completed!");
}

- (void)subTaskHard {
    int value = (arc4random() % 10) + 1;
    NSLog(@"即将睡眠%ds",value);
    sleep(value);
    NSLog(@"subTaskHard completed!");
}
@end

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
    sleep(2);
    NSLog(@"subTaskSimple1 completed！");
}

- (void)subTaskSimple2 {
    sleep(4);
    NSLog(@"subTaskSimple2 completed!");
}

- (void)subTaskHard {
    sleep(2);
    NSLog(@"subTaskHard completed!");
}
@end

//
//  myNSOperation.m
//  task3
//
//  Created by tanxiaoyan on 2020/1/9.
//  Copyright © 2020 tanxiaoyan. All rights reserved.
//

#import "myNSOperation.h"
#import "Task.h"

@interface myNSOperation()

@property (nonatomic, assign, getter = isExecuting) BOOL executing;
@property (nonatomic, assign, getter = isFinished) BOOL finished;

@end

@implementation myNSOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (id)init {
    if(self = [super init])
    {
        _executing = NO;
        _finished = NO;
    }
    return self;
}

- (void)setExecuting:(BOOL)executing
{
    //调用KVO通知
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    //调用KVO通知
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished
{
    //调用KVO通知
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    //调用KVO通知
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isExecuting {
    return _executing;
}
- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (void)start {
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        self.finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    self.executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    Task *task = [[Task alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [task subTaskSimple1];
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [task subTaskSimple2];
    }];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue waitUntilAllOperationsAreFinished];
    self.finished = YES;
    self.executing = NO;
}

@end

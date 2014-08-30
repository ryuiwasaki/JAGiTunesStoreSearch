//
//  JAGMultiThreadOperation.m
//  ToMailDrop
//
//  Created by Ryu Iwasaki on 2014/04/06.
//  Copyright (c) 2014年 Ryu Iwasaki. All rights reserved.
//

#import "JAGMultiThreadOperation.h"

@interface JAGMultiThreadOperation (){
    BOOL _ready;
    BOOL _executing;
    BOOL _finished;
    BOOL _cancelled;
}

@property (nonatomic)BOOL ready;
@property (nonatomic)BOOL executing;
@property (nonatomic)BOOL finished;
@property (nonatomic)BOOL cancelled;

@end

@implementation JAGMultiThreadOperation

- (void)startOperation{
    
    [[[NSOperationQueue alloc] init] addOperation:self];
    
}

- (void)start{
    
    if (_finished || _cancelled) {
        [self cancel];
        return;
    }
    
    [self _execute];
    
}

- (void)_execute{
    
    [self setReady:NO];
    [self setExecuting:YES];
    [self setFinished:NO];
    [self setCancelled:NO];
    
}

- (void)_done{
    
    [self setReady:NO];
    [self setExecuting:NO];
    [self setFinished:YES];
    [self setCancelled:NO];
    
}

- (void)cancel{
    
    [self _cancel];
    
    [super cancel];
}

- (void)_cancel{
    
    [self setReady:NO];
    [self setExecuting:NO];
    [self setFinished:YES];
    [self setCancelled:YES];
    
}

- (void)finish{
    
    [self _done];
}

- (void)error{
    
    [self _done];
}

//--------------------------------------------------------------//
#pragma mark  - KVO
//--------------------------------------------------------------//

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    
}

- (void)setReady:(BOOL)isReady {
    
    if (_ready != isReady) {
        [self willChangeValueForKey:@"isReady"];
        _ready = isReady;
        [self didChangeValueForKey:@"isReady"];
    }
}

- (void)setExecuting:(BOOL)isExecuting {
    
    if (_executing != isExecuting) {
        [self willChangeValueForKey:@"isExecuting"];
        _executing = isExecuting;
        [self didChangeValueForKey:@"isExecuting"];
    }
}

- (void)setFinished:(BOOL)isFinished {
    
    if (_finished != isFinished) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = isFinished;
        [self didChangeValueForKey:@"isFinished"];
    }
}

- (void)setCancelled:(BOOL)isCancelled {
    
    if (_cancelled != isCancelled) {
        [self willChangeValueForKey:@"isCancelled"];
        _cancelled = isCancelled;
        [self didChangeValueForKey:@"isCancelled"];
    }
}

//--------------------------------------------------------------//
#pragma mark  - Status
//--------------------------------------------------------------//

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isFinished{
    return _finished;
}

- (BOOL)isExecuting{
    return _executing;
}

- (BOOL)isCancelled{
    return _cancelled;
}


@end

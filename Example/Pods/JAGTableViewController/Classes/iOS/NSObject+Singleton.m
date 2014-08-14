//
//  NSObject+Singleton.m
//  ToMailDrop
//
//  Created by Ryu Iwasaki on 2014/04/19.
//  Copyright (c) 2014年 Ryu Iwasaki. All rights reserved.
//

#import "NSObject+Singleton.h"

@implementation NSObject (Singleton)

//--------------------------------------------------------------//
#pragma mark  - Singleton
//--------------------------------------------------------------//
static NSMutableDictionary *dataManagers = nil;

// 抽象クラスとしてシングルトンを実装してみる。
+ (instancetype)jag_sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        dataManagers = [NSMutableDictionary new];
        
    });
    
    @synchronized (self) {
        
        id singleton = dataManagers[NSStringFromClass(self)];
        
        if (singleton) {
            
        } else {
            
            singleton = [[self allocWithZone:nil] init];
            dataManagers[NSStringFromClass(self)] = singleton;
        }
        
        return singleton;
    }
    
    return nil;
}
@end

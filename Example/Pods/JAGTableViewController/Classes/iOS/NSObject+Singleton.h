//
//  NSObject+Singleton.h
//  ToMailDrop
//
//  Created by Ryu Iwasaki on 2014/04/19.
//  Copyright (c) 2014年 Ryu Iwasaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Singleton.h"
@interface NSObject (Singleton)

+ (instancetype)jag_sharedInstance;

@end

//
//  JAGDataSource.h
//  ToMailDrop
//
//  Created by Ryu Iwasaki on 2014/04/28.
//  Copyright (c) 2014年 Ryu Iwasaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JAGTableViewDataSource.h"


@interface JAGDataSource : NSObject<JAGTableViewDataSource>{
    @protected
    NSMutableArray *_dataSource;
}

// itemsList = @[ @[section1-item,..],@[section2-item,..],...];
- (id)initWithItemsList:(NSArray *)itemsList;

- (BOOL)saveForKey:(NSString *)key;
- (BOOL)loadForKey:(NSString *)key;

@end

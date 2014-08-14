//
//  JAGTableViewDataSource.h
//  ToMailDrop
//
//  Created by Ryu Iwasaki on 2014/04/27.
//  Copyright (c) 2014年 Ryu Iwasaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JAGTableViewDataSource <NSObject>

- (void)addItems:(NSArray *)items;
- (void)replaceItemsAtIndex:(NSUInteger)index withItems:(NSArray *)items;
- (void)insertItems:(NSArray *)items atIndex:(NSUInteger)index;

- (void)insertItem:(id)item atIndexPath:(NSIndexPath *)indexPath;
- (void)replaceItemAtIndexPath:(NSIndexPath *)indexPath withItem:(id)item;
- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)firstItems;
- (NSArray *)lastItems;

- (id)itemWithIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)itemsWithSection:(NSUInteger)section;
- (NSUInteger)sectionCounts;
- (NSUInteger)itemCountsWithSection:(NSUInteger)section;

@end

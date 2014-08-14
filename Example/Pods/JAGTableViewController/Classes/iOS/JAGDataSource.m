//
//  JAGDataSource.m
//  ToMailDrop
//
//  Created by Ryu Iwasaki on 2014/04/28.
//  Copyright (c) 2014年 Ryu Iwasaki. All rights reserved.
//

#import "JAGDataSource.h"
#import <JAGSerialize/NSObject+JAGSerialize.h>
@interface JAGDataSource ()

@property ( nonatomic , readwrite ) NSMutableArray *dataSource;

@end

@implementation JAGDataSource

+ (id)dataSourceWithSections:(NSArray *)sectionList{
    
    JAGDataSource *ds = [[JAGDataSource alloc]initWithItemsList:sectionList];
    
    if (ds) {

    }
    
    return ds;
}

- (id)init{
    
    self = [super init];
    
    if (self) {
        _dataSource = [NSMutableArray new];
    }
    
    return self;
}

- (id)initWithItemsList:(NSArray *)itemsList{
    self = [self init];
    
    if (self) {
        _dataSource = [itemsList mutableCopy];
    }
    
    return self;
}

- (NSArray *)firstItems{
    return [_dataSource firstObject];
}

- (NSArray *)lastItems{
   return [_dataSource lastObject];
}

- (void)addItems:(NSArray *)items{
    [_dataSource addObject:items];
}

- (void)replaceItemsAtIndex:(NSUInteger)index withItems:(NSArray *)items{
    [_dataSource replaceObjectAtIndex:index withObject:items];
}

- (void)insertItems:(NSArray *)items atIndex:(NSUInteger)index{
    [_dataSource insertObject:items atIndex:index];
}

- (void)insertItem:(id)item atIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *items = [[self itemsWithSection:indexPath.section] mutableCopy];
    
    [items insertObject:item atIndex:indexPath.row];
    [self replaceItemsAtIndex:indexPath.section withItems:items];
}

- (void)replaceItemAtIndexPath:(NSIndexPath *)indexPath withItem:(id)item{
    
    NSMutableArray *items = [[self itemsWithSection:indexPath.section] mutableCopy];
    
    [items replaceObjectAtIndex:indexPath.row withObject:item];
    [self replaceItemsAtIndex:indexPath.section withItems:items];
    
}

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *items = [[self itemsWithSection:indexPath.section] mutableCopy];
    
    [items removeObjectAtIndex:indexPath.row];
    [self replaceItemsAtIndex:indexPath.section withItems:items];
}

- (id)itemWithIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *items = [self itemsWithSection:indexPath.section];
    
    if (!items.count) {
        return nil;
    }
    return [items objectAtIndex:indexPath.row];
}

- (NSArray *)itemsWithSection:(NSUInteger)section{
    
    if (!_dataSource.count) {
        
        return nil;
    }
    
    return  [_dataSource objectAtIndex:section];
    
}

- (NSUInteger)sectionCounts{
    
    return _dataSource.count;
}

- (NSUInteger)itemCountsWithSection:(NSUInteger)section{
    
    NSArray *items = [self itemsWithSection:section];
    if (!items) {
        return 0;
    }
    return items.count;
}

- (BOOL)saveForKey:(NSString *)key{
    
    return [self saveWithData:_dataSource forKey:key];
}

- (BOOL)loadForKey:(NSString *)key{
    if ([self loadDataForKey:key]) {
        return YES;
    }
    return NO;
    
}

@end

//
//  NSObject+JAGSerialize.h
//  Created by Ryu Iwasaki.
//  Copyright (c) 2014 Ryu Iwasaki. All rights reserved.

#import <Foundation/Foundation.h>

/**
 *  JAGSerialize category add serialize method for NSObject.
 *
 *  @author Ryu Iwasaki
 *  @version 1.0.0
 *
 *
 **/
@interface NSObject (JAGSerialize)

/**
 * Load data with target key.
 *
 * @param key original key of using input.
 *
 * @return load file data.
 *
 *
 **/
- (id)loadDataForKey:(NSString *)key;

/**
 * Load data with target key.
 * Using background thread.
 *
 * @param key original key of using input.
 *
 * @param completion the block is called when finished loading method.
 *
 * @return load file data.
 *
 *
 **/
- (void)loadDataForKey:(NSString *)key completionBlock:(void(^)(id dataObject))completion;


/**
 * Save data.
 * Using main thread.
 *
 * @param data save data object.
 *
 * @param key original key in the class. and Using load method.
 *
 * @return Success status Yes / No.
 *
 *
 **/
- (BOOL)saveWithData:(id<NSCoding>)data forKey:(NSString *)key;


/**
 * Save data.
 * Using background thread.
 *
 * @param data save data object.
 *
 * @param key original key in the class. and Using load method.
 *
 * @param completion called when finished archiving method.
 *
 * @return Success status Yes / No.
 *
 *
 **/
- (void)saveWithData:(id<NSCoding>)data forKey:(NSString *)key completionBlock:(void(^)(BOOL success))completion;

@end

//
//  JAGMultiThreadOperation.h
//  ToMailDrop
//
//  Created by Ryu Iwasaki on 2014/04/06.
//  Copyright (c) 2014年 Ryu Iwasaki. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JAGMultiThreadOperation : NSOperation

- (void)startOperation;
- (void)finish;
- (void)error;

@end

//
//  SearchKeywordsInputViewController.h
//  AppCaller
//
//  Created by Ryu Iwasaki on 2014/08/16.
//  Copyright (c) 2014年 JAGA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchKeywordsInputViewController : UITableViewController

@property (nonatomic,copy) void(^searchButtonAction)(UIButton *sender,NSString *inpuKeywords,UIViewController *vc);
@property (nonatomic,copy) void(^didCancelKeywordInputViewController)(SearchKeywordsInputViewController *vc);

@end

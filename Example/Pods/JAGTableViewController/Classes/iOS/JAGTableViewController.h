//
//  JAGTableViewController.h
//  ToMailDrop
//
//  Created by Ryu Iwasaki on 2014/04/27.
//  Copyright (c) 2014年 Ryu Iwasaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAGTableViewDataSource.h"
#import "JAGDataSource.h"

extern NSString *const kJAG_SearchDisplayTableViewCellIdentifier;
@protocol JAGTableViewControllerUtility <NSObject>

@optional

- (UITableViewCellStyle)defaultCellStyle;
- (NSString *)defaultCellReuseIdentifier;

- (void)jag_updateVisibleCells;
- (void)jag_updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)jag_updateDataSource;
- (void)jag_reloadData;
- (void)jag_defaultCellRegisterNibWithName:(NSString *)nibName;
- (void)jag_registerCellIdentifierAndNibWithName:(NSString *)nibName;
- (void)jag_registerNibWithName:(NSString *)nibName forCellReuseIdentifier:(NSString *)reuseIdentifier;

- (void)jag_tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPaths:(NSArray *)indexPaths;
- (UITableView *)jag_ActiveTableView;
@end

@interface JAGTableViewController : UITableViewController<JAGTableViewControllerUtility>{
    @protected
    JAGDataSource *_dataSource;
}

@property ( nonatomic ) JAGDataSource *dataSource;
@end


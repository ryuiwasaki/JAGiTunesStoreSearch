//
//  JAGTableViewController.m
//  ToMailDrop
//
//  Created by Ryu Iwasaki on 2014/04/27.
//  Copyright (c) 2014年 Ryu Iwasaki. All rights reserved.
//

#import "JAGTableViewController.h"

static NSString *const kCellIdentifier = @"Cell";
NSString *const kJAG_SearchDisplayTableViewCellIdentifier = @"JAG_CELL";

@interface JAGTableViewController ()

@end

@implementation JAGTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder ];
    
    if (self){
        
        _dataSource = [[JAGDataSource alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self jag_updateDataSource];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [_dataSource sectionCounts];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_dataSource itemCountsWithSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:kJAG_SearchDisplayTableViewCellIdentifier forIndexPath:indexPath];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:self.defaultCellStyle reuseIdentifier:@"JAG_CELL"];
        }
        
        
    } else  {
        
        NSString *CellIdentifier = self.defaultCellReuseIdentifier;
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:self.defaultCellStyle reuseIdentifier:CellIdentifier];
        }
    }

    [self jag_updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)jag_tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPaths:(NSArray *)indexPaths{
    
    [self.tableView beginUpdates];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [self.tableView endUpdates];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self jag_tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPaths:@[indexPath]];
}

- (UITableViewCellStyle)defaultCellStyle{
    
    return UITableViewCellStyleDefault;
}

- (NSString *)defaultCellReuseIdentifier{
    
    return kCellIdentifier;
}

- (void)jag_defaultCellRegisterNibWithName:(NSString *)nibName{
    
    [self jag_registerNibWithName:nibName forCellReuseIdentifier:self.defaultCellReuseIdentifier];
}

- (void)jag_registerCellIdentifierAndNibWithName:(NSString *)nibName{
    
    [self jag_registerNibWithName:nibName forCellReuseIdentifier:nibName];
}

- (void)jag_registerNibWithName:(NSString *)nibName forCellReuseIdentifier:(NSString *)reuseIdentifier{
    
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
}

- (UITableView *)jag_ActiveTableView{
    if ([self.searchDisplayController isActive]) {
        
        return self.searchDisplayController.searchResultsTableView;
    }
    
    return self.tableView;
}
//--------------------------------------------------------------//
#pragma mark  - Table View Cell Update
//--------------------------------------------------------------//

- (void)jag_updateDataSource{
    
    
    [self jag_updateVisibleCells];
}

// 見えているセルを更新する
- (void)jag_updateVisibleCells{
    
    // 見えているセルの表示更新
    for (UITableViewCell *cell in [self.jag_ActiveTableView visibleCells]){
        
        [self jag_updateCell:cell atIndexPath:[self.jag_ActiveTableView indexPathForCell:cell]];
    }
}

- (void)jag_updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)jag_reloadData{
    if (self.searchDisplayController.isActive) {
        [self.searchDisplayController.searchResultsTableView reloadData];
    } else {
        [self.tableView reloadData];
    }
}

@end

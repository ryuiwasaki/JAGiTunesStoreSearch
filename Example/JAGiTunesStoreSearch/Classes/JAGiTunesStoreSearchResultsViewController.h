//
//  JAGiTunesStoreSearchResultsViewController.h
//  AppCaller
//
//  Created by Ryu Iwasaki on 2014/08/10.
//  Copyright (c) 2014年 JAGA. All rights reserved.
//

#import "JAGTableViewController.h"
@class JAGiTunesStoreSearchResultItem;
@class JAGiTunesStoreSearch;

@class JAGiTunesStoreSearchResultsNavigationController;

@protocol JAGiTunesStoreSearchResultsNavigationDelegate;

@interface JAGiTunesStoreSearchResultsViewController : JAGTableViewController

+ (JAGiTunesStoreSearchResultsNavigationController *)navigationController;
+ (JAGiTunesStoreSearchResultsNavigationController *)navigationControllerForSearch:(JAGiTunesStoreSearch *)search;

+ (instancetype)createForSearch:(JAGiTunesStoreSearch *)search;

@property (nonatomic,weak) id < UINavigationControllerDelegate , JAGiTunesStoreSearchResultsNavigationDelegate > delegate;

@property (nonatomic) int32_t offset;
@property (nonatomic) int32_t limit;

@end


@interface JAGiTunesStoreSearchResultsDetailViewController : UITableViewController

@property (nonatomic,weak) id < UINavigationControllerDelegate , JAGiTunesStoreSearchResultsNavigationDelegate > delegate;
@property (nonatomic) JAGiTunesStoreSearchResultItem *selectedItem;

@end

@protocol JAGiTunesStoreSearchResultsNavigationDelegate

@optional
// First Layer
- (void)searchResultsViewController:(UIViewController *)vc didSelectSearchResult:(JAGiTunesStoreSearchResultItem *)item iconImage:(UIImage *)iconImage;

// Second Layer
- (void)searchResultsViewController:(UIViewController *)vc didPushSearchResultDetail:(JAGiTunesStoreSearchResultItem *)item iconImage:(UIImage *)iconImage;

@end

@interface JAGiTunesStoreSearchResultsNavigationController : UINavigationController

@property (nonatomic,weak) id < UINavigationControllerDelegate , JAGiTunesStoreSearchResultsNavigationDelegate > delegate;

@end
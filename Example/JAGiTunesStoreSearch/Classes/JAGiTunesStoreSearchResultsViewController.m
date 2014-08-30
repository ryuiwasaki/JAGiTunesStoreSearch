//
//  JAGiTunesStoreSearchResultsViewController.m
//  AppCaller
//
//  Created by Ryu Iwasaki on 2014/08/10.
//  Copyright (c) 2014年 JAGA. All rights reserved.
//

#import "JAGiTunesStoreSearchResultsViewController.h"
#import "JAGiTunesStoreSearch.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface JAGiTunesStoreSearchResultsViewController ()

@property (nonatomic) JAGiTunesStoreFetch *fetch;
@property (nonatomic) JAGiTunesStoreSearch *search;

@property (nonatomic) BOOL isSearched;
@property (nonatomic) NSOperationQueue *fetchQueue;

@property (nonatomic) NSIndexPath *selectedIndexPath;


@end

@implementation JAGiTunesStoreSearchResultsViewController

+ (JAGiTunesStoreSearchResultsNavigationController *)navigationController{

    return [[UIStoryboard storyboardWithName:@"JAGiTunesStoreSearchResult" bundle:nil] instantiateInitialViewController];
}

+ (JAGiTunesStoreSearchResultsNavigationController *)navigationControllerForSearch:(JAGiTunesStoreSearch *)search{

    JAGiTunesStoreSearchResultsNavigationController *nvc = [self navigationController];
    
    [(JAGiTunesStoreSearchResultsViewController *)nvc.viewControllers.firstObject setSearch:search];
    [(JAGiTunesStoreSearchResultsViewController *)nvc.viewControllers.firstObject setOffset:search.offset];
    [(JAGiTunesStoreSearchResultsViewController *)nvc.viewControllers.firstObject setLimit:search.limit];
    return nvc;
}

+ (instancetype)createForSearch:(JAGiTunesStoreSearch *)search{
    
    JAGiTunesStoreSearchResultsViewController *vc = [[JAGiTunesStoreSearchResultsViewController alloc] init];
    
    [vc setSearch:search];
    [vc setOffset:search.offset];
    [vc setLimit:search.limit];
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setFetch:(JAGiTunesStoreFetch *)fetch{
    
    _isSearched = NO;
    _fetch = fetch;
    
}

- (void)setLimit:(int32_t)limit{
    
    _limit = limit;
    
    if (_search) {
    
        _search.limit = _limit;
    }

}

- (void)setOffset:(int32_t)offset{
    
    _offset = offset;
    
    if (_search) {
     
        _search.offset = _offset;
    }
}

- (void)jag_updateDataSource{
    
    if (!_isSearched) {
        
        if (!_fetchQueue) {
            
            _fetchQueue = [[NSOperationQueue alloc] init];
            
        } else {
            [_fetchQueue cancelAllOperations];
        }
        
        _dataSource = [[JAGDataSource alloc] init];
        _fetch = [[JAGiTunesStoreFetch alloc] initWithSearch:_search];
        
        [_fetch fetchedResultsForQueue:_fetchQueue fetchedHandler:^(NSError *error, BOOL finished, NSArray *fetchedResults) {
           
            if (error) {
                
                return;
            }
            
            NSMutableArray *allItems = [NSMutableArray arrayWithArray:[_dataSource itemsWithSection:0]];
            [allItems addObjectsFromArray:fetchedResults];
            _dataSource = [[JAGDataSource alloc] initWithItemsList:@[allItems]];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self jag_reloadData];
            }];
            
            
            _isSearched = finished;
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataSource itemCountsWithSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([_delegate respondsToSelector:@selector(searchResultsViewController:didSelectSearchResult:iconImage:)]) {
        
        JAGiTunesStoreSearchResultItem *item = [_dataSource itemWithIndexPath:indexPath];
        [_delegate searchResultsViewController:self didSelectSearchResult:item iconImage:[[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:item.artworkUrl100]];
        
    } else {
        
        _selectedIndexPath = indexPath;
        [self performSegueWithIdentifier:@"showDetail" sender:self];
    }
}

- (void)jag_updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    JAGiTunesStoreSearchResultItem *item = [_dataSource itemWithIndexPath:indexPath];
    
    [(UIActivityIndicatorView *)[cell viewWithTag:5] setHidden:NO];
    [(UIActivityIndicatorView *)[cell viewWithTag:5] startAnimating];
    
    [(UIImageView *)[cell viewWithTag:1] sd_setImageWithURL:[NSURL URLWithString:item.artworkUrl100] placeholderImage:nil options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [(UIActivityIndicatorView *)[cell viewWithTag:5] stopAnimating];
        [(UIProgressView *)[cell viewWithTag:5] setHidden:YES];
        
    }];

    [(UILabel *)[cell viewWithTag:2] setText:item.trackCensoredName];
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:[NSLocale localeIdentifierFromComponents:@{NSLocaleCurrencyCode:item.currency}]];
    
    [(UILabel *)[cell viewWithTag:3] setText:[formatter stringFromNumber:item.price]];
}

- (IBAction)pushCancel:(id)sender {
    
    if (_delegate) {
        
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        
        JAGiTunesStoreSearchResultsDetailViewController *vc = segue.destinationViewController;
        vc.delegate = _delegate;
        vc.selectedItem = [_dataSource itemWithIndexPath:_selectedIndexPath];
    }
}

@end

@interface JAGiTunesStoreSearchResultsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *developerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *developerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation JAGiTunesStoreSearchResultsDetailViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItems = @[self.doneButton];
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_selectedItem.artworkUrl512] placeholderImage:nil options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    _itemNameLabel.text = _selectedItem.trackCensoredName;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:[NSLocale localeIdentifierFromComponents:@{NSLocaleCurrencyCode:_selectedItem.currency}]];
    
    _priceLabel.text = [formatter stringFromNumber:_selectedItem.price];
    
    [_ratingImageView sd_setImageWithURL:nil];
    
    _developerNameLabel.text = _selectedItem.artistName;
    _descriptionTextView.text = _selectedItem.descriptionStr;
    
}

- (IBAction)pushDone:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(searchResultsViewController:didPushSearchResultDetail:iconImage:)]) {

        [_delegate searchResultsViewController:self didPushSearchResultDetail:_selectedItem iconImage:[[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:_selectedItem.artworkUrl512]];
        
    } else {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}


@end

@implementation JAGiTunesStoreSearchResultsNavigationController

- (void)setDelegate:(id<UINavigationControllerDelegate,JAGiTunesStoreSearchResultsNavigationDelegate>)delegate{
    
    UIViewController *vc = self.viewControllers.firstObject;
    
    if ([vc isKindOfClass:[JAGiTunesStoreSearchResultsViewController class]]) {
        
        [(JAGiTunesStoreSearchResultsViewController *)vc setDelegate:delegate];

    }
}

@end

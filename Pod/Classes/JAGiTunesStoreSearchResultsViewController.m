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
@interface JAGiTunesStoreSearchResultsViewController ()< UISearchBarDelegate >

@property (nonatomic) JAGiTunesStoreFetch *fetch;
@property (nonatomic) JAGiTunesStoreSearch *search;

@property (nonatomic) BOOL isSearched;
@property (nonatomic) NSOperationQueue *fetchQueue;

@property (nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic) NSString *searchWords;
@property (nonatomic) NSMutableArray *allItems;
@property (nonatomic) NSArray *filterdItems;

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
    self.title = NSLocalizedString(@"Search AppStore",@"");
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Searching...",@"")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_fetchQueue cancelAllOperations];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void)jag_updateDataSource{
    
    if (_isSearched) {
        
        _dataSource = [[JAGDataSource alloc] initWithItemsList:@[_allItems]];
        
        if (_searchWords.length > 0) {
            
            NSPredicate *filter = [NSPredicate predicateWithFormat:@"trackCensoredName CONTAINS[c] %@",_searchWords];
            _filterdItems = [_allItems filteredArrayUsingPredicate:filter];
            _dataSource = [[JAGDataSource alloc] initWithItemsList:@[_filterdItems]];
        }
        
        [self jag_reloadData];
        
    } else {
        
        if (!_fetchQueue) {
            
            _fetchQueue = [[NSOperationQueue alloc] init];
            
        } else {
            [_fetchQueue cancelAllOperations];
        }
        
        _dataSource = [[JAGDataSource alloc] init];
        _fetch = [[JAGiTunesStoreFetch alloc] initWithSearch:_search];

        [_fetch fetchedResultsForQueue:_fetchQueue fetchedHandler:^(NSError *error, BOOL finished, NSArray *fetchedResults) {

            if ([SVProgressHUD isVisible] && ![_dataSource itemsWithSection:0].count) {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [SVProgressHUD dismiss];
                }];
                
            }
            
            if (error) {
                
                return;
            }
            
            _allItems = [NSMutableArray arrayWithArray:[_dataSource itemsWithSection:0]];
            [_allItems addObjectsFromArray:fetchedResults];
            
            _dataSource = [[JAGDataSource alloc] initWithItemsList:@[_allItems]];
            
            if (_searchWords.length > 0) {
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"trackCensoredName CONTAINS[c] %@",_searchWords];
                _filterdItems = [_allItems filteredArrayUsingPredicate:filter];
                _dataSource = [[JAGDataSource alloc] initWithItemsList:@[_filterdItems]];
            }
            
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
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        
        JAGiTunesStoreSearchResultItem *item = [_dataSource itemWithIndexPath:indexPath];

        [[SDWebImageManager sharedManager].imageCache queryDiskCacheForKey:item.artworkUrl100 done:^(UIImage *image, SDImageCacheType cacheType) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [SVProgressHUD dismiss];
                
            }];
            
            if (image) {
                
                [_delegate searchResultsViewController:self didSelectSearchResult:item iconImage:image];
                
            } else {
                /*
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Downloading now...",@"") message:NSLocalizedString(@"Please wait.",@"") preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK",@"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                }]];
                
                [self presentViewController:alert animated:YES completion:nil];
                 */
            }
        }];
        
        /*
         [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:item.artworkUrl512]  options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
         
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
         [SVProgressHUD showProgress:@(@(receivedSize).floatValue/@(expectedSize).floatValue).floatValue status:NSLocalizedString(@"Download",@"")];
         }];
         
         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         
         if (error) {
         
         [SVProgressHUD showErrorWithStatus:error.localizedDescription];
         
         } else {
         
         [SVProgressHUD dismiss];
         }
         
         [_delegate searchResultsViewController:self didSelectSearchResult:item iconImage:image];
         
         }];
         
        
        */
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
    
    if ([_delegate respondsToSelector:@selector(searchResultsViewController:didSelectSearchResult:iconImage:)]) {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

}

- (IBAction)pushCancel:(id)sender {
    
    if (_delegate) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    _searchWords = searchText;
    [self jag_updateDataSource];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    _searchWords = @"";
    
    [self jag_updateDataSource];
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

@interface JAGSearchKeywordsInputViewController ()< UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet UILabel *keywordsTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation JAGSearchKeywordsInputViewController

+ (JAGSearchKeywordsInputViewController *)searchKeywordsInputViewController{
    
    return [[UIStoryboard storyboardWithName:@"JAGiTunesStoreSearchResult" bundle:nil] instantiateViewControllerWithIdentifier:@"SearchKeywordsInputViewController"];
}

- (void)_showiTunesSeachResults{
    
    if (_keywordsTextField.text.length == 0) {
        return;
    }
    
    JAGiTunesStoreSearchResultsNavigationController *ivc = [JAGiTunesStoreSearchResultsViewController navigationControllerForSearch:[JAGiTunesStoreSearch findWithTerm:self.keywordsTextField.text country:@"JP" entity:SoftwareiTunesSearchEntity offset:0 limit:200 mediaType:SoftwareiTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute completion:nil]];
    ivc.delegate = self.delegate;
    
    [self presentViewController:ivc animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushSearchButton:(id)sender {
    
    [self _showiTunesSeachResults];
    
    if (self.didStartSearch) {
        _didStartSearch(_keywordsTextField.text,self);
    }
}

- (IBAction)pushCancel:(id)sender {
    
    if (self.didCancelInput) {
        
        self.didCancelInput(self);
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            [self.keywordsTextField becomeFirstResponder];
            
            break;
        case 1:
            
            if (_searchButton.enabled) {
                
                [self pushSearchButton:_searchButton];
            }
            
            break;
            
        default:
            break;
    }
    
}


//--------------------------------------------------------------//
#pragma mark - TextField Delegate
//--------------------------------------------------------------//

- (void)addObserveTextFieldNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)resignTextFieldNotification{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldTextDidChangeNotification:(NSNotification *)notification{
    UITextField *tf = notification.object;
    
    if ([tf isEqual:_keywordsTextField]) {
        
        if (tf.text.length > 0) {
            _searchButton.enabled = YES;
        } else {
            _searchButton.enabled = NO;
        }
        
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [self addObserveTextFieldNotification];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self _showiTunesSeachResults];
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self resignTextFieldNotification];
}

@end



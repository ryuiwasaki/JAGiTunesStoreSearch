//
//  SearchKeywordsInputViewController.m
//  AppCaller
//
//  Created by Ryu Iwasaki on 2014/08/16.
//  Copyright (c) 2014年 JAGA. All rights reserved.
//

#import "SearchKeywordsInputViewController.h"
#import "JAGiTunesStoreSearchResultsViewController.h"
#import "JAGiTunesStoreSearch.h"

@interface SearchKeywordsInputViewController ()< UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet UILabel *keywordsTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation SearchKeywordsInputViewController

- (void)_showiTunesSeachResults{
    
    JAGiTunesStoreSearchResultsNavigationController *ivc = [JAGiTunesStoreSearchResultsViewController navigationControllerForSearch:[JAGiTunesStoreSearch findWithTerm:self.keywordsTextField.text country:@"JP" entity:SoftwareiTunesSearchEntity offset:0 limit:200 mediaType:SoftwareiTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute completion:nil]];
    
    
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
    
    if (_searchButtonAction) {
        _searchButtonAction(sender,_keywordsTextField.text,self);
    }
}

- (IBAction)pushCancel:(id)sender {
    
    if (_didCancelKeywordInputViewController) {
        
        _didCancelKeywordInputViewController(self);
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            [_keywordsTextField becomeFirstResponder];
            
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
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self resignTextFieldNotification];
}

@end

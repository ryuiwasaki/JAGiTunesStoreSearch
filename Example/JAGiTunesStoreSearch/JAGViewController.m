//
//  JAGViewController.m
//  JAGiTunesStoreSearch
//
//  Created by Ryu Iwasaki on 2014/08/14.
//  Copyright (c) 2014年 Ryu Iwasaki. All rights reserved.
//

#import "JAGViewController.h"
#import "JAGiTunesStoreSearch.h"
#import "JAGiTunesStoreSearchResultsViewController.h"
@interface JAGViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField;

@end

@implementation JAGViewController


- (void)_showiTunesSearch{
    
    JAGiTunesStoreSearch *search = [JAGiTunesStoreSearch findWithTerm:self.keywordsTextField.text country:@"US" entity:SoftwareiTunesSearchEntity offset:0 limit:10 mediaType:SoftwareiTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute completion:nil];
    
    JAGiTunesStoreSearchResultsNavigationController *nv = [JAGiTunesStoreSearchResultsViewController navigationControllerForSearch:search];
    
    [self presentViewController:nv animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushSearch:(id)sender {
    
    [self _showiTunesSearch];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self _showiTunesSearch];
    
    return YES;
}

@end

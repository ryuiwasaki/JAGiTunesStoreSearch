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
@interface JAGViewController ()

@end

@implementation JAGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    JAGiTunesStoreSearch *search = [JAGiTunesStoreSearch findWithTerm:@"ryuiwasaki" country:@"US" entity:SoftwareiTunesSearchEntity offset:0 limit:10 mediaType:SoftwareiTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute completion:nil];
    
    JAGiTunesStoreSearchResultsNavigationController *nv = [JAGiTunesStoreSearchResultsViewController navigationControllerForSearch:search];
    
    [self presentViewController:nv animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

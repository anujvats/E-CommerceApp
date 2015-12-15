//
//  StoreViewController.m
//  Store2
//
//  Created by Vats, Anuj on 6/9/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "StoreViewController.h"

#import "Webserivces.h"
#import "StoreNameTableViewCell.h"
#import "StoreModel.h"
#import "StoreDetailViewController.h"

static NSString *const cellreuseIdentifier = @"StoreNameCell";

@interface StoreViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(nonatomic)NSInteger totalStores;
@property(nonatomic)NSInteger totalPages;
@property(nonatomic) NSInteger currentPage;
@property(nonatomic,strong) NSMutableArray *storeArray;
@property(nonatomic,strong) NSMutableArray *beforeSearchArray;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.beforeSearchArray = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.storeArray = [[NSMutableArray alloc] init];

    [self loadStoreData:0];
    
    
[self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreNameTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellreuseIdentifier];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.currentPage == self.totalPages
        
        || self.totalStores == self.storeArray.count) {
        
        return self.storeArray.count;
    }
    
    return self.storeArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    StoreModel *storeModel = [self.storeArray objectAtIndex:indexPath.row];
    
    StoreNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellreuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[StoreNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellreuseIdentifier];
    }
    
    cell.storeName.text = storeModel.displayName;
    
    cell.formattedDistance.text = storeModel.formattedDistance;
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
     self.beforeSearchArray = self.storeArray;
    
    StoreModel *storeModel = [self.storeArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"StoreDetails" sender:storeModel];
    
    
    
    
    
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.storeArray count] - 1 ) {
        
        
        if (self.currentPage < self.totalPages) {
            
              [self loadStoreData:++self.currentPage];
        }
        
      
    
    }

}


-(void)loadStoreData:(NSInteger)pageNumber{
    
    
    [[Webserivces alloc] loadCompleteStoreListwithPageID:pageNumber andCompletionBlock:^(id storeDetails, NSInteger totalPages, NSInteger totalStores, NSInteger currentPage, NSError *error) {
    
        self.totalPages = totalPages;
        self.totalStores = totalStores;
        self.currentPage = currentPage;
        
        [self.storeArray addObjectsFromArray:storeDetails];
        
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            [self.tableView reloadData];
        });
        
    }];
    
}


#pragma SearchBar delegate


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    searchBar.text = nil;
    
    return YES;
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    self.storeArray = self.beforeSearchArray;
    
    [self.tableView reloadData];
   
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [searchBar resignFirstResponder];

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    NSString *search = searchBar.text;
    
    [[Webserivces alloc] loadSearchStores:search andCompletion:^(id storeDetails, NSInteger totalPages, NSInteger totalStores, NSInteger currentPage, NSError *error) {
    
        
        self.beforeSearchArray = self.storeArray;
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            self.storeArray = storeDetails;
            
            [self.tableView reloadData];
        });
        
        
    }];
    
    
    [searchBar resignFirstResponder];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    StoreDetailViewController *storeDetail = [segue destinationViewController];
    
    
    storeDetail.storeModel = sender;
    
}

@end

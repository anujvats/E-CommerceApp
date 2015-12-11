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

@property(nonatomic,strong) NSMutableArray *storeArray;
@property(nonatomic,strong) NSMutableArray *beforeSearchArray;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.beforeSearchArray = [[NSMutableArray alloc] init];
    
    [[Webserivces alloc] loadCompleteStoreListwithCompletionBlock:^(id storeDetails, NSError *error) {
        
        __weak StoreViewController *storeViewController = self;
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            storeViewController.storeArray = [[NSMutableArray alloc] initWithArray:storeDetails];
            
            [storeViewController.tableView reloadData];
        });
        
        
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    
[self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreNameTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellreuseIdentifier];
    //[rover.customer setCustomerID:];
    
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
    
    return [self.storeArray count];
    
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
    
    [[Webserivces alloc] loadSearchStores:search andCompletion:^(id storeDetails, NSError *error) {
    
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

//
//  ShopViewController.m
//  Store2
//
//  Created by Vats, Anuj on 11/30/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "ShopViewController.h"


#import "Webserivces.h"
#import "ProductCollectionViewController.h"

@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)NSArray *cateogaryArray;



@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cateogaryArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categories.retailCo-uk" ofType:@"plist"]];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(incrementCartBadge)
                                                 name:@"ItemAddedToCart" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(decrementCartBadge)
                                                 name:@"ItemDeletedFromCart" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    [self.tabBarController.tabBar setHidden:NO];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.cateogaryArray count];
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = nil;
    
    NSString *cellIdentifier = @"Cateogary Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell ==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    NSArray *array = [self.cateogaryArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [array objectAtIndex:1];
    
    return cell;
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = [self.cateogaryArray objectAtIndex:indexPath.row];
    
    NSString *string = [array objectAtIndex:0];
    
    [self performSegueWithIdentifier:@"ProductCollectionViewSegue" sender:string];

    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    ProductCollectionViewController *productCollectionVC = [segue destinationViewController];
    
    productCollectionVC.cateogaryCode = sender;
    
    
}

- (void)incrementCartBadge {
    
        NSArray *tabBarItems = [self.navigationController.tabBarController.tabBar items];
        
        UITabBarItem *cartItem = [tabBarItems objectAtIndex:3];
        
        NSString *badgeValue = cartItem.badgeValue;
        
        NSInteger currentBageValue = [badgeValue integerValue];
        
        NSInteger newBageValue = currentBageValue + 1;
        
        NSNumber *bageString = [NSNumber numberWithInteger:newBageValue];
        
        cartItem.badgeValue = [bageString stringValue];
        
}



- (void)decrementCartBadge {
    
    NSArray *tabBarItems = [self.navigationController.tabBarController.tabBar items];
    
    UITabBarItem *cartItem = [tabBarItems objectAtIndex:3];
    
    NSString *badgeValue = cartItem.badgeValue;
    
    NSInteger currentBageValue = [badgeValue integerValue];
    
    NSInteger newBageValue = currentBageValue - 1;
    
    NSNumber *bageString = [NSNumber numberWithInteger:newBageValue];
    
    cartItem.badgeValue = [bageString stringValue];
    
}



@end

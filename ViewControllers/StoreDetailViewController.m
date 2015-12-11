
//
//  StoreDetailViewController.m
//  Store2
//
//  Created by Vats, Anuj on 12/10/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "StoreView.h"
#import "StoreonMapView.h"

@interface StoreDetailViewController ()

@property (weak,nonatomic) StoreView *storeName;
@property (weak,nonatomic) StoreonMapView *storeOnMapView;

@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadStoreView];
    [self loadStoreonMapView];
    
    
    self.scrollView.contentSize = CGSizeMake(320.0f, self.storeName.frame.size.height + self.storeOnMapView.frame.size.height);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadStoreView{
    
    NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"StoreView" owner:self options:nil];
    
    self.storeName = [viewArray objectAtIndex:0];
    
   
    [self.storeName configureItemwithModel:self.storeModel];
    
    
    [self.scrollView addSubview:self.storeName];
    
    
    
}


-(void)loadStoreonMapView{
    
    NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"StoreonMapView" owner:self options:nil];
    
    self.storeOnMapView = [viewArray objectAtIndex:0];
    
    self.storeOnMapView.frame = CGRectMake(0, self.storeName.frame.origin.y+self.storeName.frame.size.height, 320, self.storeOnMapView.frame.size.height);
    
    NSLog(@"%@",NSStringFromCGRect(self.storeOnMapView.frame));
    
    [self.storeOnMapView loadMapWithStoreLocationWithCLLocationCordinate:self.storeModel.storeCordinates];
    
    [self.scrollView addSubview:self.storeOnMapView];
    
    
    
}



@end

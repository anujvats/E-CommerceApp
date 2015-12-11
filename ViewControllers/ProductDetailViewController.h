//
//  ProductDetailViewController.h
//  Store2
//
//  Created by Vats, Anuj on 12/1/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@property (strong,nonatomic) NSArray *productImages;
@property (strong,nonatomic) NSString *productCode;
@property (strong,nonatomic) NSString *badgeValueCartIcon;

@end

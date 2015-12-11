//
//  ShopViewController.h
//  Store2
//
//  Created by Vats, Anuj on 11/30/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CartModel.h"

@interface ShopViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)CartModel *cartModelObj;

@end

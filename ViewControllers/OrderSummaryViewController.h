//
//  OrderSummaryViewController.h
//  Store2
//
//  Created by Vats, Anuj on 12/8/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartModel.h"
#import "CartEntryModel.h"
#import "PriceModel.h"
#import "ProductModel.h"
#import "ImageModel.h"

@interface OrderSummaryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)CartModel *cartModelObj;

@end

//
//  CartViewController.h
//  Store2
//
//  Created by Vats, Anuj on 12/5/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSString+Utitlity.h"

@class ProductDetailViewController;

@interface CartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *totalQuantity;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)CheckOut:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *checkOutButton;

@end

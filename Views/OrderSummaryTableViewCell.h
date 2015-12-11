//
//  OrderSummaryTableViewCell.h
//  Store2
//
//  Created by Vats, Anuj on 12/8/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSummaryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cartSummaryPrice;
@property (weak, nonatomic) IBOutlet UILabel *promotionalDiscount;
@property (weak, nonatomic) IBOutlet UILabel *VATvalue;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@end

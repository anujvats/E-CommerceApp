//
//  CartTableViewCell.h
//  Store2
//
//  Created by Vats, Anuj on 12/5/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell


//@property (nonatomic, weak) IBOutlet UIImageView *imageBorder;
@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *productBrandLabel;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeQuantityButton;
@property (weak, nonatomic) IBOutlet UILabel *quantityDescriptionLabel;



@end

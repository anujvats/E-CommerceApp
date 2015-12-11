//
//  StoreNameTableViewCell.h
//  Store2
//
//  Created by Vats, Anuj on 12/9/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreNameTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *formattedDistance;

@end

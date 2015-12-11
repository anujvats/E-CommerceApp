//
//  StoreView.h
//  Store2
//
//  Created by Vats, Anuj on 12/10/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StoreModel.h"

@interface StoreView : UIView<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;
@property (weak, nonatomic) IBOutlet UIImageView *storeImage;

@property(nonatomic,strong) NSString *imageURL;

- (IBAction)callButton:(id)sender;

-(void)configureItemwithModel:(StoreModel *)model;

@end

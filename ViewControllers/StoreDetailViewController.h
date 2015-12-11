//
//  StoreDetailViewController.h
//  Store2
//
//  Created by Vats, Anuj on 12/10/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"

@interface StoreDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong) StoreModel *storeModel;

@end

//
//  ProductCollectionViewController.h
//  Store2
//
//  Created by Vats, Anuj on 12/1/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ProductCollectionViewController : UICollectionViewController

@property(nonatomic,strong)NSArray *productModelArray;
@property(nonatomic,strong)NSString *productCode;

@end

//
//  ProductCollectionViewController.h
//  Store2
//
//  Created by Vats, Anuj on 12/1/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ProductCollectionViewController : UICollectionViewController

@property(nonatomic,strong)NSMutableArray *productModelArray;
@property(nonatomic,strong)NSString *productCode;
@property(nonatomic,strong) NSString *cateogaryCode;

@end

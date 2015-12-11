//
//  CartModel.h
//  Store2
//
//  Created by Vats, Anuj on 12/5/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PriceModel.h"
#import "ImageModel.h"
#import "ProductModel.h"


@interface CartModel : NSObject


@property(nonatomic,strong)NSMutableArray *cartEnteries;
@property(nonatomic,strong)PriceModel *totalPrice;
@property(nonatomic,strong)PriceModel *totalDiscount;
@property(nonatomic,strong)PriceModel *totalPriceWithTax;
@property(nonatomic,strong)PriceModel *totalTax;
@property(nonatomic) NSInteger totalCount;


-(id)initWithCartInfo:(NSDictionary *)infoDictionary;

@end

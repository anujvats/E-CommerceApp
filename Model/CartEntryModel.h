//
//  CartEntryModel.h
//  Store2
//
//  Created by Vats, Anuj on 12/5/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PriceModel.h"
#import "ProductModel.h"

@interface CartEntryModel : NSObject


@property(nonatomic) NSInteger entryNumber;
@property(nonatomic,strong)ProductModel *productModel;
@property(nonatomic,strong)PriceModel *basePrice;
@property(nonatomic,strong)PriceModel *totalPrice;
@property(nonatomic) NSInteger quantity;

-(id)initCartEntryModel:(NSDictionary *)InfoDictionary;

@end

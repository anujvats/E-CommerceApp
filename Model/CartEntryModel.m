//
//  CartEntryModel.m
//  Store2
//
//  Created by Vats, Anuj on 12/5/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "CartEntryModel.h"

static NSString *const keyEntryNumber = @"entryNumber";
static NSString *const keyproductModel = @"product";
static NSString *const keybasePriceModel = @"basePrice";
static NSString *const keytotalPriceModel = @"totalPrice";
static NSString *const keyQuanity =@"quantity";
@implementation CartEntryModel

-(id)initCartEntryModel:(NSDictionary *)InfoDictionary{
    
    self.basePrice = [[PriceModel alloc] initWithDictionary:[InfoDictionary valueForKey:keybasePriceModel]];
    
    self.totalPrice = [[PriceModel alloc] initWithDictionary:[InfoDictionary valueForKey:keytotalPriceModel]];
    
    self.productModel = [[ProductModel alloc] initWithDictionary:[InfoDictionary valueForKey:keyproductModel]];
    
    self.quantity = [[InfoDictionary valueForKey:keyQuanity] integerValue];
    
    self.entryNumber = [[InfoDictionary valueForKey:keyEntryNumber] integerValue];
    
    return self;
    
}


@end

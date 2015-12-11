//
//  CartModel.m
//  Store2
//
//  Created by Vats, Anuj on 12/5/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "CartModel.h"

#import "CartEntryModel.h"



static NSString *const keyEntry = @"entries";
static NSString *const keytotalPriceModel = @"totalPrice";
static NSString *const keytotalDiscountModel = @"totalDiscounts";
static NSString *const keytotalCount = @"totalItems";
static NSString *const keytotalPriceWithTAX = @"totalPriceWithTax";
static NSString *const keyTotalTax = @"totalTax";



@implementation CartModel


-(id)initWithCartInfo:(NSDictionary *)infoDictionary{
    
    self.totalCount = [[infoDictionary valueForKey:keytotalCount] integerValue];

    self.totalDiscount = [[PriceModel alloc] initWithDictionary:[infoDictionary valueForKey:keytotalDiscountModel]];
    self.totalPrice = [[PriceModel alloc] initWithDictionary:[infoDictionary valueForKey:keytotalPriceModel]];
    
    self.totalPriceWithTax = [[PriceModel alloc] initWithDictionary:[infoDictionary valueForKey:keytotalPriceWithTAX]];
    
    self.totalTax = [[PriceModel alloc] initWithDictionary:[infoDictionary valueForKey:keyTotalTax]];
    
    self.cartEnteries = [NSMutableArray array];
    
    for (NSDictionary *cartEntryDictionary in [infoDictionary valueForKey:keyEntry]) {
        
        CartEntryModel *cartEntryModel = [[CartEntryModel alloc] initCartEntryModel:cartEntryDictionary];
        
        if (cartEntryModel != nil) {
            
            [self.cartEnteries addObject:cartEntryModel];
            
        }
  
    }
    
    return self;
}

@end

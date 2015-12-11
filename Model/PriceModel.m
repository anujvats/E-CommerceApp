//
//  PriceModel.m
//  Store2
//
//  Created by Vats, Anuj on 12/3/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "PriceModel.h"


static NSString *const keyCurrency = @"currencyIso";
static NSString *const keyformattedValue = @"formattedValue";
static NSString *const KeyPriceType = @"priceType";
static NSString *const keyValue = @"value";

@implementation PriceModel


-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    self = [super init];
    
    self.currencyISo = [dictionary valueForKey:keyCurrency];
    self.formattedValue = [dictionary valueForKey:keyformattedValue];
    self.priceType = [dictionary valueForKey:KeyPriceType];
    self.value = [dictionary valueForKey:keyValue];
  
    return self;
    
}

@end

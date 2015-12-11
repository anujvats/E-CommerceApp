//
//  ProductModel.m
//  Store2
//
//  Created by Vats, Anuj on 12/2/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "ProductModel.h"


static NSString *const keyimage = @"images";
static NSString *const keyName = @"name";
static NSString *const keyPrice = @"price";
static NSString *const keyCode = @"code";
static NSString *const keyStock = @"stock";
static NSString *const keyUrl = @"url";
static NSString *const keyAvailableForPick = @"availableForPickup";


@implementation ProductModel


-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    self = [super init];
    
    self.name = [dictionary valueForKey:keyName];
    self.code = [dictionary valueForKey:keyCode];
    self.url = [dictionary valueForKey:keyUrl];
    
    self.imageModel = [[NSMutableArray alloc] init];
    self.priceModel = [[NSMutableArray alloc] init];
    
    NSArray *tempArray = [NSArray array];
    NSDictionary *tempDict = [NSDictionary dictionary];
    
    tempArray = [dictionary valueForKey:keyimage];
    
    for (tempDict in tempArray) {
        
        ImageModel *pricemodel = [[ImageModel alloc] initWithDictionary:tempDict];
        
        if (pricemodel != nil) {
            
            [self.imageModel addObject:pricemodel];
            
        }
        
        
    }
    
  
        
        PriceModel *pricemodel = [[PriceModel alloc] initWithDictionary:[dictionary valueForKey:keyPrice]];
        
        if (pricemodel != nil) {
            
            [self.priceModel addObject:pricemodel];
            
        }
        
    
    
    
    return self;
    
}



@end

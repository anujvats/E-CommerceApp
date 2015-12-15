//
//  ProductModel.h
//  Store2
//
//  Created by Vats, Anuj on 12/2/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PriceModel.h"
#import "ImageModel.h"

@interface ProductModel : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *availableForPickup;
@property(nonatomic,strong)NSMutableArray *priceModel;
@property(nonatomic,strong)NSMutableArray *imageModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

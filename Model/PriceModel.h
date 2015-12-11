//
//  PriceModel.h
//  Store2
//
//  Created by Vats, Anuj on 12/3/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceModel : NSObject

@property(nonatomic,strong)NSString *formattedValue;
@property(nonatomic,strong)NSString *currencyISo;
@property(nonatomic,strong)NSString *priceType;
@property(nonatomic,strong)NSString *value;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

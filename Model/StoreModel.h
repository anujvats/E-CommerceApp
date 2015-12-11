//
//  StoreModel.h
//  Store2
//
//  Created by Vats, Anuj on 12/9/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "ImageModel.h"

@interface StoreModel : NSObject


@property(nonatomic,strong) NSString *formattedDistance;
@property(nonatomic) CLLocationCoordinate2D storeCordinates;
@property(nonatomic,strong) NSArray *features;
@property(nonatomic,strong) NSDictionary *address;
@property(nonatomic,strong) NSString *displayName;
@property(nonatomic,strong) NSMutableArray *imageModels;
@property(nonatomic,strong) NSString *storeName;


-(instancetype)initWithDictionary:(NSDictionary *)infoDictionary;

@end

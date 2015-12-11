//
//  StoreModel.m
//  Store2
//
//  Created by Vats, Anuj on 12/9/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "StoreModel.h"

static NSString *const keyformattedDistance = @"formattedDistance";
static NSString *const keygeoPoint = @"geoPoint";
static NSString *const keyFeature = @"features";
static NSString *const keyaddress = @"address";
static NSString *const keyDisplayName = @"displayName";
static NSString *const keyStoreImages = @"storeImages";
static NSString *const keyStoreName = @"name";
static NSString *const keyStoreLongitude = @"longitude";
static NSString *const keyStoreLatitude = @"latitude";

@implementation StoreModel

-(instancetype)initWithDictionary:(NSDictionary *)infoDictionary{
    
    self = [super init];
    
    self.formattedDistance = [infoDictionary valueForKey:keyformattedDistance];
    
    CLLocationDegrees latitude =[[[infoDictionary valueForKey:keygeoPoint] valueForKey:keyStoreLatitude] doubleValue];
    CLLocationDegrees longitude = [[[infoDictionary valueForKey:keygeoPoint] valueForKey:keyStoreLongitude] doubleValue];
    
    self.storeCordinates = CLLocationCoordinate2DMake(latitude, longitude);
    
    self.features = [infoDictionary valueForKey:keyFeature];
    
    self.address = [infoDictionary valueForKey:keyaddress];
    
    self.displayName = [infoDictionary valueForKey:keyDisplayName];
    
    self.storeName = [infoDictionary valueForKey:keyStoreName];
    
    self.imageModels = [NSMutableArray array];
    
    for (NSDictionary *dictionary in [infoDictionary valueForKey:keyStoreImages]) {
        
        ImageModel *imageModel = [[ImageModel alloc] initWithDictionary:dictionary];
        
        if (imageModel != nil) {
            
            [self.imageModels addObject:imageModel];
        }
    
    }
    
    
    return self;
}


@end

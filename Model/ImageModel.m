//
//  ImageModel.m
//  Store2
//
//  Created by Vats, Anuj on 12/2/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "ImageModel.h"

static NSString *const keyformat = @"format";
static NSString *const keyimageType = @"imageType";
static NSString *const keyURL = @"url";

@implementation ImageModel


-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    self = [super init];
    
    self.format = [dictionary valueForKey:keyformat];
    self.imageType = [dictionary valueForKey:keyimageType];
    self.imageURL = [dictionary valueForKey:keyURL];
    
    return self;
}

@end

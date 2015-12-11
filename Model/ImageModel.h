//
//  ImageModel.h
//  Store2
//
//  Created by Vats, Anuj on 12/2/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

@property(nonatomic,strong) NSString *format;
@property(nonatomic,strong) NSString *imageType;
@property(nonatomic,strong) NSString *imageURL;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

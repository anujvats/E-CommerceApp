//
//  DataProvider.h
//  Store2
//
//  Created by Vats, Anuj on 12/2/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^NSDataNSErrorBlock)(NSData *data, NSError *error);

@interface DataProvider : NSObject

- (id)initWithRequestURL:(NSString *)url completionBlock:(NSDataNSErrorBlock)completionBlock;
- (id)initWithURL:(NSString *)url httpMethod:(NSString *)httpMethod httpBody:(NSData *)postData completionBlock:(NSDataNSErrorBlock)completionBlock;

@end

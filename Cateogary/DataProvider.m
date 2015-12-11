//
//  DataProvider.m
//  Store2
//
//  Created by Vats, Anuj on 12/2/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "DataProvider.h"

#import "NSString+Utitlity.h"

@interface DataProvider()

@property(nonatomic,strong)NSMutableData *data;
@property(nonatomic,strong) NSDataNSErrorBlock completionBlock;

@end


@implementation DataProvider



-(id)initWithRequest:(NSMutableURLRequest *)request andCompletetionBlock:(NSDataNSErrorBlock)completionBlock{
    
    
    if (completionBlock) {
        
        self.completionBlock = completionBlock;
    }
    
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    if (connection) {
        
        _data = [[NSMutableData alloc] init];
        
    }else {
        
        
        return nil;
    }
    
    return self;
}


- (id)initWithRequestURL:(NSString *)url completionBlock:(NSDataNSErrorBlock)completionBlock{
    
    NSMutableURLRequest *request =
    
    [NSMutableURLRequest requestWithURL:[self URLByEncodingString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    
    [request setHTTPMethod:@"GET"];
    
    return [self initWithRequest:request andCompletetionBlock:completionBlock];
}

- (id)initWithURL:(NSString *)url httpMethod:(NSString *)httpMethod httpBody:(NSData *)postData completionBlock:(NSDataNSErrorBlock)completionBlock {
    
    NSMutableURLRequest *request =
    
    [NSMutableURLRequest requestWithURL:[self URLByEncodingString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    
    if (httpMethod && ![httpMethod isEmpty] && ([httpMethod isEqualToString:@"PUT"]
                                                || [httpMethod isEqualToString:@"DELETE"]
                                                || [httpMethod isEqualToString:@"GET"]
                                                || [httpMethod isEqualToString:@"POST"])) {
        [request setHTTPMethod:httpMethod];
    }
    
    if (postData) {
       
        [request setHTTPBody:postData];
    }
    
    return [self initWithRequest:request andCompletetionBlock:completionBlock];
}


- (NSURL *)URLByEncodingString:(NSString *)url {
    
    return [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}



#pragma NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    
    NSLog(@"NSURL response status %ld",(long)[response statusCode]);
  
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
   
    NSLog(@"Connection Did Receive Data ");
    
    
    [self.data appendData:data];
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    NSLog(@"Connection Did fail with error ");
    
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"Data Load complete");
    
    
    if (self.completionBlock) {
        
        if (self.data && self.data.length) {
            
                dispatch_async(dispatch_queue_create("HYBRIS API ParseQueue", NULL), ^{ _completionBlock (self.data, nil);
                });
            }
    
         }
}

@end

//
//  Webserivces.m
//  Store2
//
//  Created by Vats, Anuj on 11/30/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "Webserivces.h"

#import  "DataProvider.h"
#import "ProductModel.h"
#import "ImageModel.h"
#import "CartModel.h"
#import "StoreModel.h"

static NSString *const keyProducts = @"products";
static NSString *const keyProductImage = @"images";
static NSString *const keyStores = @"stores";

@implementation Webserivces

+(Webserivces *)sharedInstance{
    
    static Webserivces *sharedToken;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{ sharedToken = [[Webserivces alloc] init]; });
    
    return sharedToken;
}


-(void)loadCateogaryProductfromHybriswithCateogaryCaode:(NSString *)cateogaryCode andCompletioBlock:(ProductModelBlock)productModelBlock{
    
    NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.93:9001/rest/v1/retailCo-uk/products?query=::%@&clear=true&pageSize=20&currentPage=0&lang=en",cateogaryCode];

    
    (void)[[DataProvider alloc] initWithRequestURL:urlString completionBlock:^(NSData *data, NSError *error) {
    
        
         NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        NSMutableArray *productsArray = [[NSMutableArray alloc] init];
        
        NSArray *productArrayJSON =[NSArray array];
        
        productArrayJSON =[jsonDictionary valueForKey:keyProducts];
        
        for (NSDictionary *productDictionary in productArrayJSON) {
            
            
            ProductModel *productModel = [[ProductModel alloc] initWithDictionary:productDictionary];
            
            
            if (productModel !=nil) {
                
                [productsArray addObject:productModel];
                
            }
            
            
        }
       
        dispatch_async(dispatch_queue_create("Product array return queue", NULL), ^{
        
            productModelBlock(productsArray,nil);
        });
        
        
    }];
    
}


-(void)loadProductwithProductCode:(NSString *)productCode andCompletionBlock:(ProductDetailModelBlock)productDetail{
    
    NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.93:9001/rest/v1/retailCo-uk/products/%@?options=BASIC,CATEGORIES,CLASSIFICATION,DESCRIPTION,GALLERY,PRICE,PROMOTIONS,REVIEW,STOCK,VARIANT_FULL&lang=en",productCode];
    
    
   (void)[[DataProvider alloc] initWithRequestURL:urlString completionBlock:^(NSData *data, NSError *error) {
       
       
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
       NSMutableArray *productImages = [[NSMutableArray alloc] init];
       
       NSArray *productImageJSON =[NSArray array];
       
       productImageJSON =[jsonDictionary valueForKey:keyProductImage];
       
       for (NSDictionary *productDictionary in productImageJSON) {
           
           
           ImageModel *imageModel = [[ImageModel alloc] initWithDictionary:productDictionary];
           
           
           if (imageModel !=nil) {
               
               [productImages addObject:imageModel];
               
           }
           
           
       }
       
       dispatch_async(dispatch_queue_create("Product array return queue", NULL), ^{
           
           productDetail(productImages,nil);
       });
       
    }];
    
}


-(void)addProductToCartWithCode:(NSString *)code quantity:(NSInteger)quantity completionBlock:(cartDetailsBlock)cartDetails{
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.93:9001/rest/v1/retailCo-uk/cart/entry"];
    
    NSString *postBody = [NSString stringWithFormat:@"code=%@&qty=%li", code, (long)quantity];
    
    NSData *postData = [NSData dataWithBytes:[postBody UTF8String] length:[postBody length]];
    
    (void)[[DataProvider alloc] initWithURL:urlString httpMethod:@"POST" httpBody:(NSData *)postData completionBlock:^(NSData *jsonData, NSError *error) {
       
        if (cartDetails) {
            
            if (error) {
                dispatch_async (dispatch_get_main_queue (), ^{ cartDetails (nil, error);
                });
                return;
            }
            
            if (jsonData) {
                
                NSError *jsonError;
                
                NSMutableDictionary *dict =
                [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers
                                                               error:&jsonError]];
                
                if (jsonError) {
                    if (cartDetails) {
                        dispatch_async (dispatch_get_main_queue (), ^{cartDetails (nil, jsonError);
                        });
                    }
                    
                    return;
                }
                
                BOOL success = [dict objectForKey:@"statusCode"] ? YES:NO;
                
                if (cartDetails) {
                    
                    if (success) {
                        dispatch_async (dispatch_get_main_queue (), ^{ cartDetails  (dict, error);
                        });
                    }
                    else {
                        dispatch_async (dispatch_get_main_queue (), ^{ cartDetails  (nil, [NSError errorWithDomain:@"com.hybris" code:1 userInfo:dict]);
                        });
                    }
                }
            }
            else {
                if (cartDetails) {
                    dispatch_async (dispatch_get_main_queue (), ^{ cartDetails  (nil, error);
                    });
                }
            }
        }
    }];
    
}


- (void)cartWithCompletionBlock:(cartModelBlock)completionBlock {
    
    NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.93:9001/rest/v1/retailCo-uk/cart"];
    
    
    (void)[[DataProvider alloc] initWithRequestURL:urlString completionBlock:^(NSData *jsonData, NSError *error) {
        
     if (completionBlock) {
         
         if (error) {
             
             dispatch_async (dispatch_get_main_queue (), ^{ completionBlock (nil, error);
                });
                return;
            }
            
            if (jsonData) {
               
                NSError *jsonError;
                
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:jsonData options:
                                                               NSJSONReadingMutableContainers error:&
                                                               jsonError]];
                
                if (jsonError) {
                    if (completionBlock) {
                        dispatch_async (dispatch_get_main_queue (), ^{ completionBlock (nil, jsonError);
                        });
                    }
                    
                    return;
                }
                
                __block NSMutableArray *objects = [[NSMutableArray alloc] init];
                
            
                
                [objects addObject:[[CartModel alloc]initWithCartInfo:dict]];
                
                if (completionBlock) {
                    
                    dispatch_async (dispatch_get_main_queue (), ^{ completionBlock (objects, error);
                    });
                }
            }
            else {
                if (completionBlock) {
                    dispatch_async (dispatch_get_main_queue (), ^{ completionBlock (nil, error);
                    });
                }
            }
        }
    }];
}





- (void)deleteProductInCartAtEntry:(NSInteger)entry completionBlock:(cartModelBlock)completionBlock {
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.93:9001/rest/v1/retailCo-uk/cart/entry"];
    
    (void)[[DataProvider alloc] initWithURL:[NSString stringWithFormat:@"%@/%i",urlString,
                                                         entry] httpMethod:@"DELETE" httpBody:nil completionBlock:^(NSData *jsonData, NSError *error)
    {
        if (jsonData) {
            
            if (completionBlock) {
                if (error) {
                    dispatch_async (dispatch_get_main_queue (), ^{ completionBlock (nil, error);
                    });
                    return;
                }
                
                NSError *jsonError;
                
                NSMutableDictionary *dict =
                [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers
                                                               error
                                                                                                     :&
                                                               jsonError]];
                
                if (jsonError) {
                    if (completionBlock) {
                        dispatch_async (dispatch_get_main_queue (), ^{ completionBlock (nil, jsonError);
                        });
                    }
                    
                    return;
                }
                
                BOOL success = [[dict objectForKey:@"statusCode"] isEqualToString:@"success"] ? YES:NO;
                
                if (completionBlock) {
                    if (success) {
                        dispatch_async (dispatch_get_main_queue (), ^{ completionBlock  (dict, error);
                        });
                    }
                    else {
                        dispatch_async (dispatch_get_main_queue (), ^{ completionBlock  (nil, [NSError errorWithDomain:@"com.hybris" code:1 userInfo:dict]);
                        });
                    }
                }
            }
            else {
                if (completionBlock) {
                    dispatch_async (dispatch_get_main_queue (), ^{ completionBlock  (nil, error);
                    });
                }
            }
        }
    }];
}

-(void)loadCompleteStoreListwithCompletionBlock:(storeDetailsBlock)storeDetailsBlock{
    
    NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.93:9001/rest/v1/retailCo-uk/stores"];
    http://localhost:9001/rest/v1/retailCo-uk/stores/?query=london&options=HOURS&currentPage=0&lang=en
    (void)[[DataProvider alloc] initWithRequestURL:urlString completionBlock:^(NSData *data, NSError *error) {
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        NSArray *storesArray = [NSArray array];
        
        NSMutableArray *storeModels = [[NSMutableArray alloc] init];
        
        storesArray = [jsonDictionary valueForKey:keyStores];
        
        
        for (NSDictionary *dictionary in storesArray) {
            
            
            StoreModel *storeModel = [[StoreModel alloc] initWithDictionary:dictionary];
            
            
            if (storeModel != nil) {
                
                [storeModels addObject:storeModel];
                
            }
            
        }
        
        dispatch_async(dispatch_queue_create("Store array return queue", NULL), ^{
            
            storeDetailsBlock(storeModels,nil);
        });
    
    }];
    
    
}


-(void)loadSearchStores:(NSString *)searchString andCompletion:(storeDetailsBlock)storeDetailsBlock{
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.93:9001/rest/v1/retailCo-uk/stores/?query=%@&options=HOURS&currentPage=0&lang=en",searchString];

    (void)[[DataProvider alloc] initWithRequestURL:urlString completionBlock:^(NSData *data, NSError *error) {
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        NSArray *storesArray = [NSArray array];
        
        NSMutableArray *storeModels = [[NSMutableArray alloc] init];
        
        storesArray = [jsonDictionary valueForKey:keyStores];
        
        
        for (NSDictionary *dictionary in storesArray) {
            
            
            StoreModel *storeModel = [[StoreModel alloc] initWithDictionary:dictionary];
            
            
            if (storeModel != nil) {
                
                [storeModels addObject:storeModel];
                
            }
            
        }
        
        dispatch_async(dispatch_queue_create("Store array return queue", NULL), ^{
            
            storeDetailsBlock(storeModels,nil);
        });
        
    }];
 
}

@end

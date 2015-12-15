//
//  Webserivces.h
//  Store2
//
//  Created by Vats, Anuj on 11/30/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ProductModelBlock)(id productresults,NSInteger totalPages,NSInteger totalStores,NSInteger currentPage, NSError *error);
typedef void (^cartModelBlock)(id cartModel, NSError *error);
typedef void (^ProductDetailModelBlock)(id productDetails, NSError *error);
typedef void (^cartDetailsBlock)(id cartDetails, NSError *error);
typedef void (^storeDetailsBlock)(id storeDetails,NSInteger totalPages,NSInteger totalStores,NSInteger currentPage, NSError *error);

@interface Webserivces : NSObject


+(Webserivces *)sharedInstance;

-(void)loadCateogaryProductfromHybriswithCateogaryCaode:(NSString *)cateogaryCode andPageID:(NSInteger )pageID andCompletioBlock:(ProductModelBlock)productModelBlock;
-(void)loadProductwithProductCode:(NSString *)productCode andCompletionBlock:(ProductDetailModelBlock)productDetail;
- (void)addProductToCartWithCode:(NSString *)code quantity:(NSInteger)quantity completionBlock:(cartDetailsBlock)cartDetails;
- (void)cartWithCompletionBlock:(cartModelBlock)completionBlock;
- (void)deleteProductInCartAtEntry:(NSInteger)entry completionBlock:(cartModelBlock)completionBlock;
-(void)loadCompleteStoreListwithPageID:(NSInteger)pageID andCompletionBlock:(storeDetailsBlock)storeDetailsBlock;
-(void)loadSearchStores:(NSString *)searchString andCompletion:(storeDetailsBlock)storeDetailsBlock;
@end

//
//  StoreView.m
//  Store2
//
//  Created by Vats, Anuj on 12/10/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "StoreView.h"
#import "ImageModel.h"

static NSString *const keyFormattedAddress = @"formattedAddress";
static NSString *const keyImageFormat = @"format";
static NSString *const keyStore = @"store";
static NSString *const keyImageURL =@"url";

typedef void (^IsImageLoadedSucessfully)(BOOL succeeded, UIImage *image);

@implementation StoreView

-(void)configureItemwithModel:(StoreModel *)model{
    
    
    self.storeName.text = model.storeName;
    
    NSString *addressString = [model.address valueForKey:keyFormattedAddress];
    
   addressString = [addressString  stringByTrimmingCharactersInSet:
     [NSCharacterSet whitespaceCharacterSet]];
    
    self.storeAddress.text =  [addressString stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    
    for (ImageModel *imageModel in model.imageModels) {
        
        if ([imageModel.format isEqualToString:keyStore]) {
            
            self.imageURL = imageModel.imageURL;
            
        }
        
    }
  
    
    NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.75:9001%@",self.imageURL];
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    [self downloadImageAsync:url andCompletionBlock:^(BOOL succeeded, UIImage *image) {
        
        if (succeeded) {
        
            self.storeImage.image = image;
            
        }
        
        
    }];
    
}

- (IBAction)callButton:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Call Store" message:@"Your service provider may charge for this call as per your plan" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    
    [alertView show];
    
  
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 1.0) {
        
        
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://+91-9718420501"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        
        
    }
    
}

-(void)downloadImageAsync:(NSURL *)url andCompletionBlock:(IsImageLoadedSucessfully)isImageLoaded{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   
                                   isImageLoaded (YES,image);
                                   
                               } else{
                                   
                                   isImageLoaded (NO,nil);
                               }
                           }];
    
    
}
@end

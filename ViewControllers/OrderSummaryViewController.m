//
//  OrderSummaryViewController.m
//  Store2
//
//  Created by Vats, Anuj on 12/8/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//



static NSString *cellReuseIdentifier = @"CartCell";
static NSString *constCellReuseIdentifier = @"OrderSummaryCell";
typedef void (^IsImageLoadedSucessfully)(BOOL succeeded, UIImage *image);

#import "OrderSummaryViewController.h"

#import "OrderSummaryTableViewCell.h"
#import "CartTableViewCell.h"

@interface OrderSummaryViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation OrderSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderSummaryTableViewCell class]) bundle:nil] forCellReuseIdentifier:constCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CartTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    
    }else{
        
        return [self.cartModelObj.cartEnteries count];
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
        
        
        OrderSummaryTableViewCell *orderSummaryTBLVC = [tableView dequeueReusableCellWithIdentifier:constCellReuseIdentifier forIndexPath:indexPath];
        
        if (orderSummaryTBLVC == nil) {
            
            orderSummaryTBLVC = [[OrderSummaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:constCellReuseIdentifier];
        }
        
        
        orderSummaryTBLVC.cartSummaryPrice.text = self.cartModelObj.totalPrice.formattedValue;
        orderSummaryTBLVC.promotionalDiscount.text = self.cartModelObj.totalDiscount.formattedValue;
        orderSummaryTBLVC.VATvalue.text =self.cartModelObj.totalTax.formattedValue;
        
        orderSummaryTBLVC.totalPrice.text =self.cartModelObj.totalPriceWithTax.formattedValue;
        
        return orderSummaryTBLVC;

        
    }else{
        
        
        CartTableViewCell *cartTBLVC = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
        
        if (cartTBLVC == nil) {
            
            cartTBLVC = [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        }
        
        CartEntryModel *cartEntryModel = [self.cartModelObj.cartEnteries objectAtIndex:indexPath.row];
        
        ProductModel *productModel = cartEntryModel.productModel;
        
        
        cartTBLVC.productTitleLabel.text = productModel.name;
        
        cartTBLVC.itemPriceLabel.text = cartEntryModel.basePrice.formattedValue;
        
        cartTBLVC.totalPriceLabel.text = cartEntryModel.totalPrice.formattedValue;
        
        NSNumber *itemQuantitynumber = [NSNumber numberWithInteger:cartEntryModel.quantity];
        
        cartTBLVC.itemQuantityLabel.text = [itemQuantitynumber stringValue];
        
        for (ImageModel *imageModel in productModel.imageModel) {
            
            
            NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.75:9001%@",imageModel.imageURL];
            
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            
            if ([imageModel.format isEqualToString:@"cartIcon"]) {
                
                [self downloadImageAsync:url andCompletionBlock:^(BOOL succeeded, UIImage *image) {
                    
                    if (succeeded) {
                        
                        cartTBLVC.productImageView.image = image;
                        
                    }}];
                
            }}
        
        
        return cartTBLVC;
        
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        return 160;
        
    }
    
    return 84;

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

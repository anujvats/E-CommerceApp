//
//  CartViewController.m
//  Store2
//
//  Created by Vats, Anuj on 12/5/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "CartViewController.h"

#import "Webserivces.h"
#import "OrderSummaryViewController.h"
#import "ProductDetailViewController.h"
#import "CartTableViewCell.h"
#import "CartModel.h"
#import "CartEntryModel.h"
#import "PriceModel.h"
#import "ProductModel.h"
#import "ImageModel.h"

static NSString *cellReuseIdentifier = @"CartCell";

static NSString *orderSummarySegue = @"OrderSummary";

typedef void (^IsImageLoadedSucessfully)(BOOL succeeded, UIImage *image);

@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource>

@end


@interface CartViewController()

@property(nonatomic,strong)CartModel *cartModelObj;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    
    self.totalPrice.adjustsFontSizeToFitWidth = YES;
    self.totalQuantity.adjustsFontSizeToFitWidth = YES;
    
    
   [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CartTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
  
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tabBarController.tabBar setHidden:NO];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    (void)[[Webserivces alloc] cartWithCompletionBlock:^(id cartModel, NSError *error) {
        
        
       self.cartModelObj = [cartModel objectAtIndex:0];
        
        __weak CartViewController *cartViewController = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [cartViewController.tableView reloadData];

        });
        
    }];
    
    
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
    
    
    
    if ([self.cartModelObj.cartEnteries count] == 0) {
        self.totalPrice.text= @"Total Price £0.00";
        self.totalQuantity.text = @"0 items in Bag";
        [self.checkOutButton  setEnabled:NO];
        [self.checkOutButton setTintColor:[UIColor clearColor]];
        
    }else{
        
        
        [self.checkOutButton  setEnabled:YES];
        [self.checkOutButton setTintColor:nil];
        
    }
    
    
    
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return [self.cartModelObj.cartEnteries count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSNumber *totalCountnumber = [NSNumber numberWithInteger:self.cartModelObj.totalCount];

    
    self.totalQuantity.text = [NSString stringWithFormat:@"%@ items in Bag", [totalCountnumber stringValue]];
    
    
    self.totalPrice.text = [NSString stringWithFormat:@"Total Price %@",self.cartModelObj.totalPrice.formattedValue];
    
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];

       if (cell == nil) {
          
           cell = [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
       }

   CartEntryModel *cartEntryModel = [self.cartModelObj.cartEnteries objectAtIndex:indexPath.row];
    
    ProductModel *productModel = cartEntryModel.productModel;

    
    cell.productTitleLabel.text = productModel.name;
    
    cell.itemPriceLabel.text = cartEntryModel.basePrice.formattedValue;
    
    cell.totalPriceLabel.text = cartEntryModel.totalPrice.formattedValue;
    
    NSNumber *itemQuantitynumber = [NSNumber numberWithInteger:cartEntryModel.quantity];
    
    cell.itemQuantityLabel.text = [itemQuantitynumber stringValue];
    
    for (ImageModel *imageModel in productModel.imageModel) {
        
        
        NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.93:9001%@",imageModel.imageURL];
        
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        
        if ([imageModel.format isEqualToString:@"cartIcon"]) {
            
          [self downloadImageAsync:url andCompletionBlock:^(BOOL succeeded, UIImage *image) {
              
              if (succeeded) {
                  
                  cell.productImageView.image = image;
                  
              }}];
            
        }}
    
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CartEntryModel *cartEntryModel = [self.cartModelObj.cartEnteries objectAtIndex:indexPath.row];
    
    
    ProductModel *productModel = cartEntryModel.productModel;
    
    NSString *productCode = productModel.code;
    
    
   
    
   
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
  
    
    
    [[Webserivces sharedInstance]loadProductwithProductCode:productCode andCompletionBlock:^(id productDetails, NSError *error) {
        
         __block __weak ProductDetailViewController *viewController;
        
        __block __weak CartViewController *cartViewController = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            
             UITabBarItem *cartItem = [[self.tabBarController.tabBar items] objectAtIndex:3];
            viewController =
        
            (ProductDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ProductDetailVC"];
            
            viewController.productImages = productDetails;
            viewController.badgeValueCartIcon = cartItem.badgeValue;
            
            
            [cartViewController.navigationController pushViewController:viewController animated:YES];
            
        });
        
        
        
        
    }];

    
    
    
    
    
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {


    CartEntryModel *entryModel = [self.cartModelObj.cartEnteries objectAtIndex:indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    [[Webserivces alloc] deleteProductInCartAtEntry:entryModel.entryNumber completionBlock:^(id cartModel, NSError *error) {
        
        __weak CartViewController *cartviewController =self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ItemDeletedFromCart" object:nil];
            
            [cartviewController viewDidAppear:YES];
            
        });
        
        
        
        
    }];
        
        
        
        
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


- (IBAction)CheckOut:(id)sender {
    
    
    [self performSegueWithIdentifier:orderSummarySegue sender:self.cartModelObj];
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    OrderSummaryViewController *orderSummaryVC = [segue destinationViewController];
    
    orderSummaryVC.cartModelObj = sender;
    
}

@end

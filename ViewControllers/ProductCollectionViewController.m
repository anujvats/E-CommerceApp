//
//  ProductCollectionViewController.m
//  Store2
//
//  Created by Vats, Anuj on 12/1/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "ProductCollectionViewController.h"

#import "ProductDetailViewController.h"
#import "ProductCollectionViewCell.h"
#import "ProductModel.h"
#import "ImageModel.h"
#import "PriceModel.h"
#import "Webserivces.h"

typedef void (^IsImageLoadedSucessfully)(BOOL succeeded, UIImage *image);

@interface ProductCollectionViewController ()

@property(nonatomic) NSInteger totalProducts;
@property(nonatomic) NSInteger totalPages;
@property(nonatomic) NSInteger currentPage;

@end

@implementation ProductCollectionViewController



- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"ProductCell" bundle:[NSBundle mainBundle]];
    
    self.productModelArray = [[NSMutableArray alloc] init];
    
    [self fetchResultswithPageNumber:0];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"ProductCell"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
       [self.tabBarController.tabBar setHidden:NO];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if ([self.productModelArray isKindOfClass:[NSArray class]]) {
        
        return [self.productModelArray count];
   
    }else{
        
        
        return 0;
    }
    
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ProductModel *productModel = [self.productModelArray objectAtIndex:indexPath.row];
    
    PriceModel *priceModel = [productModel.priceModel objectAtIndex:0];
    
    ImageModel *imageModel = [productModel.imageModel objectAtIndex:0];
    
    NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.75:9001%@",imageModel.imageURL];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    __weak ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];

    
    [self downloadImageAsync:url andCompletionBlock:^(BOOL succeeded, UIImage *image) {
        
        if (succeeded) {
            
            cell.productImage.image = image;
        }
    }];
    
    cell.productCode = productModel.code;
    
    cell.productName.text = productModel.name;
    
    cell.productPrice.text = priceModel.formattedValue;
    
    
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
 
    
    
    
    
    
}


-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"Index Path : %li",(long)indexPath.row);
    
    
    NSLog(@"product Model Array :%li",(long)[self.productModelArray count]);
    
    if (indexPath.row == [self.productModelArray count]-10) {
        
        
        if (self.currentPage < self.totalPages) {
            
            [self fetchResultswithPageNumber:++self.currentPage];
            
        }
        
        
    }
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
    ProductCollectionViewCell *productCollectionCell = (ProductCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    
  [[Webserivces sharedInstance]loadProductwithProductCode:productCollectionCell.productCode andCompletionBlock:^(id productDetails, NSError *error) {
      
      
      
      dispatch_async(dispatch_get_main_queue(), ^{
          
          self.productCode = productCollectionCell.productCode;
          
           [self performSegueWithIdentifier:@"MySegueIdentifier" sender:productDetails];
      });
      
   
      
      
  }];
    
    
    
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

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

-(void)fetchResultswithPageNumber:(NSInteger)pageNumber{
    
    
    [[Webserivces sharedInstance] loadCateogaryProductfromHybriswithCateogaryCaode:self.cateogaryCode andPageID:pageNumber andCompletioBlock:^(id productresults,NSInteger totalPages,NSInteger totalProducts,NSInteger currentPage, NSError *error) {
        
        
        self.currentPage = currentPage;
        self.totalPages = totalPages;
        self.totalProducts = totalProducts;
        
        
        [self.productModelArray addObjectsFromArray:productresults];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            [self.collectionView reloadData];
            
        });
        
        
    }];
    
    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ProductDetailViewController *productDetailVC = [segue destinationViewController];
    productDetailVC.productImages = sender;
    UITabBarItem *cartItem = [[self.tabBarController.tabBar items] objectAtIndex:3];
    productDetailVC.badgeValueCartIcon = cartItem.badgeValue;
    productDetailVC.productCode = self.productCode;
    
}

@end

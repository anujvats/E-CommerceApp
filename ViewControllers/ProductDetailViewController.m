//
//  ProductDetailViewController.m
//  Store2
//
//  Created by Vats, Anuj on 12/1/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "ProductDetailViewController.h"

#import "UIBarButtonItem+Badge.h"
#import "CartViewController.h"
#import "PDPCollectionViewCell.h"
#import "ImageModel.h"
#import "Webserivces.h"


typedef void (^IsImageLoadedSucessfully)(BOOL succeeded, UIImage *image);

static NSString *const keyStatusCode = @"statusCode";
NSString *const AddedToCart = @"ItemAddedToCart";

@interface ProductDetailViewController ()<UITabBarDelegate>

@property(nonatomic,strong) PDPCollectionViewCell *pdpCollectionCellView;


@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    
  [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *addToCartButton = [[UIBarButtonItem alloc]
                                   initWithTitle:nil
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(openCartViewControllerFromPDP)];
    
    addToCartButton.image = [UIImage imageNamed:@"tab-cart"];
    
    self.navigationItem.rightBarButtonItem = addToCartButton;
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PDPCollectionViewCell" owner:self options:nil];
    
    
    self.pdpCollectionCellView = [array lastObject];
    
    self.pdpCollectionCellView.frame = CGRectMake(0, 64,self.pdpCollectionCellView.frame.size.width, self.pdpCollectionCellView.frame.size.height);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(incrementCartBadgeonPDP)
                                                 name:@"ItemAddedToCartonPDP" object:nil];
    
    [self.view addSubview:self.pdpCollectionCellView];
    
     self.tabBar.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self currentCartItemBadgeValue];
    
    CGFloat xcordinate = 0;
    
    for (ImageModel *imageModel in self.productImages ) {
        
        if ([imageModel.format isEqualToString:@"product"] && [imageModel.imageType isEqualToString:@"GALLERY"]) {
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xcordinate, 0, 320, 455)];
            
            
            NSString *urlString = [NSString stringWithFormat:@"http://10.217.98.93:9001%@",imageModel.imageURL];
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            [self downloadImageAsync:url andCompletionBlock:^(BOOL succeeded, UIImage *image)
            
            {
                
                imageView.image = image;
                
                
            }];
            
            [self.pdpCollectionCellView.scrollView addSubview:imageView];
            
            xcordinate += 320;
            
            [self.pdpCollectionCellView.scrollView setContentSize:CGSizeMake(xcordinate, 0)];
            
        }
    }
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    

    [self.tabBarController.tabBar setHidden:YES];
    
    
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
    if ([item.title isEqualToString:@"Info"]) {
    
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TabbarPopView" owner:self options:nil];
        
        UIView *arrayView = [array objectAtIndex:0];
        
        arrayView.frame = CGRectMake(0, 260, 320, 260);
        
        [self.pdpCollectionCellView addSubview:arrayView];
        
    }else if ([item.title isEqualToString:@"AddToBag"]){
        
        
    [[Webserivces alloc] addProductToCartWithCode:self.productCode quantity:1 completionBlock:^(id cartDetails, NSError *error) {
        
        if ([[cartDetails valueForKey:keyStatusCode] isEqualToString:@"success"]) {
            
            
              dispatch_async(dispatch_get_main_queue(),^{
                  
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"ItemAddedToCart" object:nil];
              
              });
            
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ItemAddedToCartonPDP" object:nil];
            
            });
        
        }
    }];
        
        
        
    }else{
        
        
        
    }
    
    
}

- (void)incrementCartBadgeonPDP {
    
    NSArray *navBarItems = [self.navigationController.navigationBar items];
    
    UINavigationItem *cartItem = [navBarItems lastObject];
    
    UIBarButtonItem *addTocartButton = cartItem.rightBarButtonItem;
    
    NSInteger currentBageValue = [self.badgeValueCartIcon integerValue];
    
    NSInteger newBageValue = currentBageValue + 1;
    
    NSNumber *bageString = [NSNumber numberWithInteger:newBageValue];
    
    addTocartButton.badgeValue = [bageString stringValue];
    
}


-(void)currentCartItemBadgeValue{
    
    NSArray *navBarItems = [self.navigationController.navigationBar items];
    
    UINavigationItem *cartItem = [navBarItems lastObject];
    
    UIBarButtonItem *addTocartButton = cartItem.rightBarButtonItem;
    
    addTocartButton.badgeValue =self.badgeValueCartIcon;
    
    
}


-(void)openCartViewControllerFromPDP{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    __weak CartViewController *yourViewController =
    (CartViewController *)
    [storyboard instantiateViewControllerWithIdentifier:@"cartViewController"];
    [self.navigationController pushViewController:yourViewController animated:YES];
    
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

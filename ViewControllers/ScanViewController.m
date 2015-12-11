//
//  ScanViewController.m
//  Store2
//
//  Created by Vats, Anuj on 5/20/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "ScanViewController.h"


#import "ProductDetailViewController.h"
#import "Webserivces.h"

@interface ScanViewController ()

@property(strong,nonatomic)NSString *productCode;
@property (strong, nonatomic)ZXCapture *capture;
@property (nonatomic, assign) BOOL hasScannedResult;
@property (weak , nonatomic) IBOutlet UIView *scanRectView;


@end

@implementation ScanViewController

- (void)dealloc {
    [self.capture.layer removeFromSuperlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate =self;
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    
    self.navigationItem.hidesBackButton = YES;
    
    

    self.capture.layer.frame = self.scanView.bounds;
    
    [self.scanView.layer addSublayer:self.capture.layer];
    
    [self.scanView bringSubviewToFront:self.scanRectView];
    
   
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
    
    [self startScan];
    
    self.capture.delegate = self;
    
    self.capture.layer.frame = self.scanView.bounds;
    
    CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.scanView.frame.size.width, 418 / self.scanView.frame.size.height);
    self.capture.scanRect = CGRectApplyAffineTransform(self.scanRectView.frame, captureSizeTransform);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Private Methods

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result) return;
      [self.capture stop];
    
    // We got a result. Display information about the result onscreen.
    NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
   
    NSString *display = [NSString stringWithFormat:@"Scanned!\n\nFormat: %@\n\nContents:\n%@", formatString, result.text];
    
    
    NSLog(@"Log Display %@",display);
    
    if(self.hasScannedResult == NO)
    {
        
        self.hasScannedResult = YES;
        
        
        [[Webserivces alloc]loadProductwithProductCode:result.text andCompletionBlock:^(id productDetails, NSError *error) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.productCode = result.text;
                
                [self performSegueWithIdentifier:@"ScanProductDetails" sender:productDetails];
                
            });
            
            
            
            
            
            
        }];
    }
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)startScan{
    
    
    self.hasScannedResult = NO;
    
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
   
    searchBar.text = nil;
    
    return YES;
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [searchBar resignFirstResponder];
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    if(self.hasScannedResult == NO)
    {
        
        self.hasScannedResult = YES;
        
        
        [[Webserivces alloc]loadProductwithProductCode:searchBar.text andCompletionBlock:^(id productDetails, NSError *error) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.productCode = searchBar.text;
                
                [self performSegueWithIdentifier:@"ScanProductDetails" sender:productDetails];
                
            });
            
            
            
            
            
            
        }];
    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    ProductDetailViewController *productDetails = [segue destinationViewController];
   
    UITabBarItem *cartItem = [[self.tabBarController.tabBar items] objectAtIndex:3];
   
    productDetails.badgeValueCartIcon = cartItem.badgeValue;
    
    productDetails.productCode = self.productCode;
    
    productDetails.productImages = sender;
    
    
    
    
}

@end

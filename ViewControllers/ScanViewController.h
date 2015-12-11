//
//  ScanViewController.h
//  Store2
//
//  Created by Vats, Anuj on 5/20/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZXingObjC/ZXingObjC.h>

@interface ScanViewController : UIViewController<UISearchBarDelegate,ZXCaptureDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *scanView;

@end

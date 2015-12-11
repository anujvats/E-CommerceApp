//
//  LoginViewController.h
//  Store2
//
//  Created by Vats, Anuj on 5/20/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(id)sender;

@end

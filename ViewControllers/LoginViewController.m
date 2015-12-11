//
//  LoginViewController.m
//  Store2
//
//  Created by Vats, Anuj on 5/20/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "LoginViewController.h"
#import "ShopViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userName.text = @"Anuj Vats";
    self.password.text = @"anujvats";
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
//    if ([segue.identifier isEqualToString:@"newsegue"]) {
//        
//    UITabBarController *tabcontroller = [segue destinationViewController];
//        
//    UINavigationController *navigationcontroller = [tabcontroller.viewControllers objectAtIndex:0];
//        
//        ShopViewController *shopviewcontroller = [navigationcontroller.viewControllers objectAtIndex:0];
//        
//        
//    }
    
    


    
}


- (IBAction)login:(id)sender {
    
//    [self performSegueWithIdentifier:@"mainview" sender:self];
    
}
@end

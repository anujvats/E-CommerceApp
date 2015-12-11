//
//  AppDelegate.h
//  Store2
//
//  Created by Vats, Anuj on 5/21/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Rover/Rover.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Rover *rover;
@property (strong, nonatomic) RVConfig *config;

@end

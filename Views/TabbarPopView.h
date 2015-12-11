//
//  TabbarPopView.h
//  Store2
//
//  Created by Vats, Anuj on 12/1/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarPopView : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
- (IBAction)dismissFromSuperView:(id)sender;

@end

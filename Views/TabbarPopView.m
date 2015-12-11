//
//  TabbarPopView.m
//  Store2
//
//  Created by Vats, Anuj on 12/1/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "TabbarPopView.h"

@implementation TabbarPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)dismissFromSuperView:(id)sender {
    
    [self removeFromSuperview];
    
}
@end

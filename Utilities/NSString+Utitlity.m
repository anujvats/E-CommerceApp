//
//  NSString+Utitlity.m
//  Store2
//
//  Created by Vats, Anuj on 12/5/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "NSString+Utitlity.h"

@implementation NSString (Utitlity)


- (BOOL)isEmpty {
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
}


- (NSString *)stringByTrimmingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end

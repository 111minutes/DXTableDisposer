//
//  MUCellDataTextPair.m
//  MUKitTest
//
//  Created by Malaar on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataTextPair.h"

@implementation MUCellDataTextPair

@synthesize title, titleFont, titleColor;
@synthesize text, textFont, textColor;

#pragma mark - Init/Dealloc

- (id)init
{
    self = [super initWithObject:nil key:nil];
    if (self) {
        self = [self initWithObject:nil key:nil];
    }
    return  self;
}

- (id)initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super initWithObject:aObject key:aKey];
    if (self) {
        titleFont = [UIFont systemFontOfSize:16];
        titleColor = [UIColor blackColor];

        textFont = [UIFont systemFontOfSize:16];
        textColor = [UIColor blackColor];
    }
    return self;
}


#pragma mark - Maping

- (void)mapFromObject
{
    if (_object && _key) {
        text = [_object valueForKeyPath:_key];
    }
}

- (void)mapToObject
{
    if (_object && _key) {
        [_object setValue:text forKeyPath:_key];
    }
}

@end

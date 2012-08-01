//
//  MULabelCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataStandart.h"
#import "MUCellStandart.h"


@implementation MUCellDataStandart

@synthesize subtitle;
@synthesize image;
@synthesize imageURL;
@synthesize imagePlaceholder;
@synthesize title;
@synthesize titleFont;
@synthesize subtitleFont;
@synthesize titleColor;
@synthesize subtitleColor;
@synthesize titleTextAlignment;

#pragma mark - Init/Dealloc

- (id)init
{
    self = [super initWithObject:nil key:nil];
    if (self) {
        self = [self initWithObject:nil key:nil];
    }
    return self;
}

- (id)initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super initWithObject:aObject key:aKey];
    if (self) {
        self.cellClass = [MUCellStandart class];

        titleTextAlignment = UITextAlignmentLeft;
        titleFont = [UIFont systemFontOfSize:18];
        subtitleFont = [UIFont systemFontOfSize:16];
        titleColor = [UIColor blackColor];
        subtitleColor = [UIColor grayColor];
    }
    return self;
}


#pragma mark - Maping

- (void)mapFromObject
{
    if (_object && _key) {
        subtitle = [_object valueForKeyPath:_key];
    }
}

- (void)mapToObject
{
    if (_object && _key) {
        [_object setValue:subtitle forKeyPath:_key];
    }
}

@end

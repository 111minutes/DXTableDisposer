//
//  MUCellDataTextView.m
//  MUKitTest
//
//  Created by Malaar on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataTextView.h"
#import "MUCellTextView.h"


@implementation MUCellDataTextView

@synthesize textAlignment = _textAlignment;
@synthesize autocapitalizationType = _autocapitalizationType;
@synthesize autocorrectionType = _autocorrectionType;
@synthesize keyboardType = _keyboardType;
@synthesize keyboardAppearance = _keyboardAppearance;
@synthesize returnKeyType = _returnKeyType;

@synthesize validator = _validator;
@synthesize filter = _filter;

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
        self.cellClass = [MUCellTextView class];
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;

        _textAlignment = UITextAlignmentLeft;
        _autocapitalizationType = UITextAutocapitalizationTypeNone;
        _autocorrectionType = UITextAutocorrectionTypeNo;
        _keyboardType = UIKeyboardTypeDefault;
        _keyboardAppearance = UIKeyboardAppearanceDefault;
        _returnKeyType = UIReturnKeyDefault;
    }
    return self;
}


- (CGFloat)cellHeightForWidth:(CGFloat)aWidth
{
    return 90;
}

@end

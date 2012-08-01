//
//  MUEntryCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataTextField.h"
#import "MUCellTextField.h"


@implementation MUCellDataTextField

@synthesize textSecured = _textSecured;
@synthesize placeholder = _placeholder, placeholderColor = _placeholderColor;

@synthesize autocapitalizationType = _autocapitalizationType;
@synthesize autocorrectionType = _autocorrectionType;
@synthesize keyboardType = _keyboardType;
@synthesize keyboardAppearance = _keyboardAppearance;
@synthesize returnKeyType = _returnKeyType;

@synthesize validator;
@synthesize filter;

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
        self.cellClass = [MUCellTextField class];
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;

        _autocapitalizationType = UITextAutocapitalizationTypeNone;
        _autocorrectionType = UITextAutocorrectionTypeNo;
        _keyboardType = UIKeyboardTypeDefault;
        _keyboardAppearance = UIKeyboardAppearanceDefault;
        _returnKeyType = UIReturnKeyDefault;
    }
    return self;
}


@end

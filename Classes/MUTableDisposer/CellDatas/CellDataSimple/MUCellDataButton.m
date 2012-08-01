//
//  MUButtonCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataButton.h"
#import "MUCellButton.h"


@implementation MUCellDataButton

@synthesize targetAction = _targetAction;

@synthesize title = _title;
@synthesize titleFont = _titleFont;
@synthesize titleColor = _titleColor;
@synthesize titleAlignment = _titleAlignment;

#pragma mark - Init/Dealloc

- (id)init
{
    self = [super init];
    if (self) {
        self.cellClass = [MUCellButton class];

        _titleAlignment = UITextAlignmentLeft;
        _titleFont = [UIFont systemFontOfSize:18];
        _titleColor = [UIColor blackColor];
        _targetAction = [[MUTargetAction alloc] init];
    }
    return self;
}


#pragma mark - Target/Action

- (void)setTarget:(id)aTarget action:(SEL)anAction
{
    [_targetAction setTarget:aTarget action:anAction];
    [self addCellSelectedTarget:_targetAction.target action:_targetAction.action];
}

@end

//
//  MUCellData.m
//  MUKit
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellData.h"
#import "MUTargetAction.h"

@implementation MUCellData
{
@private
    NSMutableArray *_cellSelectedHandlers;
    NSMutableArray *_cellDeselectedHandler;
}


@synthesize cellNibName = _cellNibName;
@synthesize cellClass = _cellClass;
@dynamic cellIdentifier;
@synthesize controllerClass = _controllerClass;
@synthesize cellSelectionStyle = _cellSelectionStyle;
@synthesize cellStyle = _cellStyle;
@synthesize cellAccessoryType = _cellAccessoryType;
@synthesize autoDeselect = _autoDeselect;
@synthesize visible = _visible;
@synthesize enableEdit = _enableEdit;


- (id)init
{
    self = [super init];
    if (self) {
        _visible = YES;
        _autoDeselect = YES;
        _enableEdit = YES;
        _cellSelectionStyle = UITableViewCellSelectionStyleBlue;
        _cellStyle = UITableViewCellStyleDefault;
        _cellAccessoryType = UITableViewCellAccessoryNone;

        _cellSelectedHandlers = [NSMutableArray new];
        _cellDeselectedHandler = [NSMutableArray new];
    }
    return self;
}


- (CGFloat)cellHeightForWidth:(CGFloat)aWidth
{
    return 44.f;
}

- (NSString *)cellIdentifier
{
    return NSStringFromClass(self.cellClass);
}

- (void)addCellSelectedTarget:(id)aTarget action:(SEL)anAction
{
    [_cellSelectedHandlers addObject:[MUTargetAction targetActionWithTarget:aTarget action:anAction]];
}

- (void)addCellDeselectedTarget:(id)aTarget action:(SEL)anAction
{
    [_cellDeselectedHandler addObject:[MUTargetAction targetActionWithTarget:aTarget action:anAction]];
}

- (void)performSelectedHandlers
{
    for (MUTargetAction *handler in _cellSelectedHandlers) {
        [handler sendActionFrom:self];
    }
}

- (void)performDeselectedHandlers
{
    for (MUTargetAction *handler in _cellDeselectedHandler) {
        [handler sendActionFrom:self];
    }
}

- (MUCell *)createCell
{
    MUCell *cell = nil;

    if (_cellNibName) {
        cell = (MUCell *) [[[NSBundle mainBundle] loadNibNamed:_cellNibName owner:self options:nil] lastObject];
    }
    else {
        cell = [[self.cellClass alloc] initWithStyle:self.cellStyle reuseIdentifier:self.cellIdentifier];
    }
    return cell;
}

@end

//
//  MUBooleanCellData.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataSwitch.h"
#import "MUCellSwitch.h"

@implementation MUCellDataSwitch

@synthesize boolValue = _boolValue;
@synthesize targetAction = _targetAction;
@synthesize onText = _onText;
@synthesize offText = _offText;

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
        self.cellClass = [MUCellSwitch class];
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
        _targetAction = [[MUTargetAction alloc] init];
    }
    return self;
}


#pragma mark - Target/Action

- (void)setTarget:(id)aTarget action:(SEL)anAction
{
    [_targetAction setTarget:aTarget action:anAction];
}

#pragma mark - Maping

- (void)mapFromObject
{
    if (_object && _key) {
        _boolValue = [[_object valueForKeyPath:_key] boolValue];
    }
}

- (void)mapToObject
{
    if (_object && _key) {
        [_object setValue:[NSNumber numberWithBool:_boolValue] forKeyPath:_key];
    }
}

@end

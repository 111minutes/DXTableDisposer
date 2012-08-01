//
//  MUCellDataMaped.m
//  MUKit
//
//  Created by Yuriy Bosov on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMaped.h"

@implementation MUCellDataMaped


@synthesize key = _key;
@synthesize object = _object;


- (id)init
{
    NSAssert(NO, @"You can't use this method! Instead use 'initWithObject:key:'");
    return nil;
}

- (id)initWithObject:(NSObject *)aObject key:(NSString *)aKey
{
    self = [super init];
    if (self) {
        _key = aKey;
        _object = aObject;
    }
    return self;
}


- (void)mapFromObject
{
    NSAssert(nil, @"Override this method in subclasses!");
}

- (void)mapToObject
{
    NSAssert(nil, @"Override this method in subclasses!");
}

@end

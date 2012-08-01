//
//  MUTableDisposerMapped.mm
//  MUKitTest
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTableDisposerMapped.h"

@implementation MUTableDisposerMapped


- (void)mapFromObject
{
    for (MUSectionReadonly *section in _sections) {
        if ([section isKindOfClass:[MUSectionWritable class]]) {
            [(MUSectionWritable *) section mapFromObject];
        }
    }
}

- (void)mapToObject
{
    for (MUSectionReadonly *section in _sections) {
        if ([section isKindOfClass:[MUSectionWritable class]]) {
            [(MUSectionWritable *) section mapToObject];
        }
    }
}

- (void)reloadData
{
    [self mapFromObject];
    [super reloadData];
}

@end

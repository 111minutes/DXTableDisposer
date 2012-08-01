//
//  MUTableDisposerModeled.m
//  MUKitTest
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTableDisposerModeled.h"

@implementation MUTableDisposerModeled
{
    NSMutableDictionary *_registeredClasses;
}

@synthesize modeledDelegate;


- (id)init
{
    if ((self = [super init])) {
        _registeredClasses = [NSMutableDictionary new];
    }
    return self;
}


- (void)registerCellData:(Class)aCellDataClass forModel:(Class)aModelClass
{
    NSAssert([aCellDataClass isSubclassOfClass:[MUCellDataModeled class]], @"CellData must be subclass of MUCellDataModeled!");
    [_registeredClasses setObject:aCellDataClass forKey:aModelClass];
}

- (void)setupModels:(NSArray *)aModels forSectionAtIndex:(NSUInteger)aSectionIndex
{
    MUSectionReadonly *section = [self sectionByIndex:aSectionIndex];
    [self setupModels:aModels forSection:section];
}

- (void)setupModels:(NSArray *)aModels forSection:(MUSectionReadonly *)aSection
{
    assert(aSection);

    for (id model in aModels) {
        Class cellDataClass = [_registeredClasses objectForKey:[model class]];

        NSAssert(cellDataClass, ([NSString stringWithFormat:@"Model doesn't have registered cellData class %@", NSStringFromClass([model class])]));

        MUCellDataModeled *cellData = [[cellDataClass alloc] initWithModel:model];
        if (cellData) {
            [aSection addCellData:cellData];

            if (modeledDelegate && [modeledDelegate respondsToSelector:@selector(tableDisposer:didCreateCellData:)]) {
                [modeledDelegate tableDisposer:self didCreateCellData:cellData];
            }

        }
    }

}

@end

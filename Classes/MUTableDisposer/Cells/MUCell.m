//
//  MUCell.m
//  MUKit
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCell.h"

@implementation MUCell

@synthesize cellData;


- (void)setupCellData:(MUCellData *)aCellData
{
    if (cellData != aCellData) {
        cellData = aCellData;
    }

    self.selectionStyle = cellData.cellSelectionStyle;
    self.accessoryType = cellData.cellAccessoryType;
}


- (NSArray *)inputTraits
{
    return nil;
}

@end

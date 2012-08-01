//
//  MUCellDataModeledDynamic.h
//  Pro-Otdyh
//
//  Created by Yuriy Bosov on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataModeled.h"


typedef struct _MUCellIndent
{
    float left;
    float top;
    float right;
    float bottom;
} MUCellIndent;

MUCellIndent MUCellIndentMake(float left, float top, float right, float botton);

@interface MUCellDataModeledDynamic : MUCellDataModeled
{
    MUCellIndent _cellIndent;
    int _currentCellWidth;
    float _currentCellHeight;
}

- (MUCellIndent)setupCellIndent;
- (float)recalculateCellHeight;

@end

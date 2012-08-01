//
//  MUCellDataModeledDynamic.m
//  Pro-Otdyh
//
//  Created by Yuriy Bosov on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataModeledDynamic.h"


MUCellIndent MUCellIndentMake(float left, float top, float right, float bottom) {
    MUCellIndent cellIndent;
    cellIndent.left = left;
    cellIndent.top = top;
    cellIndent.right = right;
    cellIndent.bottom = bottom;
    return cellIndent;
}

@implementation MUCellDataModeledDynamic

- (id)initWithModel:(id)aModel
{
    self = [super initWithModel:aModel];
    if (self) {
        _cellIndent = [self setupCellIndent];
    }
    return self;
}

- (MUCellIndent)setupCellIndent
{
    return MUCellIndentMake(5, 5, 20, 5);
}

- (float)cellHeightForWidth:(CGFloat)aWidth
{
    if ((int) aWidth != _currentCellWidth) {
        _currentCellWidth = (int) aWidth;
        _currentCellHeight = [self recalculateCellHeight];
    }
    return _currentCellHeight;
}

- (float)recalculateCellHeight
{
    return 44.f;
}

@end

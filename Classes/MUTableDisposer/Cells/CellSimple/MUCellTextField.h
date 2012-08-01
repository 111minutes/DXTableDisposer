//
//  MUEntryCell.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCell.h"
#import "MUTextField.h"

@interface MUCellTextField : MUCell
{
    UILabel *_titleLabel;
}

@property(nonatomic, readonly) MUTextField *textField;

@end

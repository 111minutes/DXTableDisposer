//
//  MUEntryCell.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellTextField.h"
#import "MUCellDataTextField.h"


@interface MUCellTextField ()

- (void)didChangeValueInTextField:(UITextField *)aTextField;

@end

@implementation MUCellTextField


@synthesize textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        textField = [[MUTextField alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
        [self.contentView addSubview:textField];
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [textField addTarget:self action:@selector(didChangeValueInTextField:) forControlEvents:UIControlEventEditingDidEnd];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = _titleLabel;

    }
    return self;
}

- (void)setupCellData:(MUCellData *)aCellData
{
    [super setupCellData:aCellData];

    MUCellDataTextField *cellDataTextField = (MUCellDataTextField *) aCellData;

    textField.autocapitalizationType = cellDataTextField.autocapitalizationType;
    textField.autocorrectionType = cellDataTextField.autocorrectionType;
    textField.keyboardType = cellDataTextField.keyboardType;
    textField.keyboardAppearance = cellDataTextField.keyboardAppearance;
    textField.returnKeyType = cellDataTextField.returnKeyType;
    textField.secureTextEntry = cellDataTextField.textSecured;


    textField.font = cellDataTextField.textFont;
    textField.text = cellDataTextField.text;
    textField.textColor = cellDataTextField.textColor;
    textField.placeholder = cellDataTextField.placeholder;
    textField.enabled = cellDataTextField.enableEdit;

    textField.validator = cellDataTextField.validator;
    textField.filter = cellDataTextField.filter;

    if ([cellDataTextField.title length]) {
        textField.textAlignment = UITextAlignmentRight;

        CGSize titleLabelSize = [cellDataTextField.title sizeWithFont:cellDataTextField.titleFont];
        _titleLabel.frame = CGRectMake(0, 0, titleLabelSize.width + 10, titleLabelSize.height);
        _titleLabel.text = cellDataTextField.title;
        _titleLabel.textColor = cellDataTextField.titleColor;
        _titleLabel.font = cellDataTextField.titleFont;
    }
    else {
        textField.textAlignment = UITextAlignmentLeft;

        _titleLabel.text = nil;
        _titleLabel.frame = CGRectZero;
    }
}

- (NSArray *)inputTraits
{
    return [NSArray arrayWithObject:textField];
}

- (void)didChangeValueInTextField:(UITextField *)aTextField
{
    ((MUCellDataTextField *) self.cellData).text = aTextField.text;
}

@end




//
//  MUEntryCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataTextPair.h"
#import "MUValidator.h"
#import "MUFilter.h"


@interface MUCellDataTextField : MUCellDataTextPair

@property(nonatomic, assign) BOOL textSecured;                                       ///< default is NO

@property(nonatomic, copy) NSString *placeholder;
@property(nonatomic, strong) UIColor *placeholderColor;

@property(nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;   ///< default is UITextAutocapitalizationTypeSentences
@property(nonatomic, assign) UITextAutocorrectionType autocorrectionType;           ///< default is UITextAutocorrectionTypeDefault
@property(nonatomic, assign) UIKeyboardType keyboardType;                           ///< default is UIKeyboardTypeDefault
@property(nonatomic, assign) UIKeyboardAppearance keyboardAppearance;               ///< default is UIKeyboardAppearanceDefault
@property(nonatomic, assign) UIReturnKeyType returnKeyType;                         ///< default is UIReturnKeyDefault

@property(nonatomic, strong) MUValidator *validator;
@property(nonatomic, strong) MUFilter *filter;

@end

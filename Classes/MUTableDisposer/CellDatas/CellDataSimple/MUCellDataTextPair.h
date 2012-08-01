//
//  MUCellDataTextPair.h
//  MUKitTest
//
//  Created by Malaar on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMaped.h"

@interface MUCellDataTextPair : MUCellDataMaped

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIFont *titleFont;

@property(nonatomic, copy) NSString *text;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, strong) UIFont *textFont;

@end

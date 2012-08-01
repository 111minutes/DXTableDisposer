//
//  MULabelCellData.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellDataMaped.h"

@interface MUCellDataStandart : MUCellDataMaped

@property(nonatomic, strong) UIImage *image;                                   ///< Use to setup image

@property(nonatomic, strong) NSURL *imageURL;                                  ///< Use to setup image asynchronous from URL
@property(nonatomic, strong) UIImage *imagePlaceholder;

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIFont *titleFont;
@property(nonatomic, assign) UITextAlignment titleTextAlignment;

@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, strong) UIColor *subtitleColor;
@property(nonatomic, strong) UIFont *subtitleFont;

- (id)initWithObject:(NSObject *)aObject key:(NSString *)aKey;

@end

//
//  MUKeyboardToolbar.h
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@protocol MUKeyboardToolbarProtocol <NSObject>

- (void)didNextButtonPressd;
- (void)didPrevButtonPressd;
- (void)didDoneButtonPressd;

@end

@interface MUKeyboardToolbar : UIToolbar
{
    UISegmentedControl *_segmentedPreviousNext;
    UIBarButtonItem *_doneButton;
 //   id <MUKeyboardToolbarProtocol> _delegate;
}

@property(nonatomic, copy) NSString *previousTitle;
@property(nonatomic, copy) NSString *nextTitle;
@property(nonatomic, strong) id <MUKeyboardToolbarProtocol> delegate;

@property(nonatomic, readonly) UIBarButtonItem *doneButton;

- (void)selectedInputFieldIndex:(NSInteger)selectInsex allCountInputFields:(NSInteger)allCountInputFields;

@end

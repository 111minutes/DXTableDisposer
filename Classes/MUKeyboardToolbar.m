//
//  MUKeyboardToolbar.m
//  MUKitTest
//
//  Created by Yuriy Bosov on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUKeyboardToolbar.h"

@interface MUKeyboardToolbar ()

- (void)segmentedControlPreviousNextChangedValue:(id)sender;
- (void)buttonDonePressed:(id)sender;

@end

@implementation MUKeyboardToolbar


@synthesize previousTitle;
@synthesize nextTitle;
@synthesize doneButton;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.barStyle = UIBarStyleBlack;
        self.translucent = YES;
        self.backgroundColor = [UIColor clearColor];

        // Default labels
        self.previousTitle = @"Previous";
        self.nextTitle = @"Next";

        // Setup segmented controls
        _segmentedPreviousNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:self.previousTitle, self.nextTitle, nil]];
        _segmentedPreviousNext.segmentedControlStyle = UISegmentedControlStyleBar;
        _segmentedPreviousNext.momentary = YES;
        _segmentedPreviousNext.tintColor = [UIColor blackColor];
        _segmentedPreviousNext.clipsToBounds = YES;
        [_segmentedPreviousNext addTarget:self action:@selector(segmentedControlPreviousNextChangedValue:) forControlEvents:UIControlEventValueChanged];

        // Make segmented controls a bar button
        UIBarButtonItem *barSegment = [[UIBarButtonItem alloc] initWithCustomView:_segmentedPreviousNext];

        // Create spacing
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        // Create done button
        doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonDonePressed:)];

        NSArray *items = [NSArray arrayWithObjects:barSegment, flex, doneButton, nil];
        self.items = items;
    }
    return self;
}

- (void)dealloc
{
    self.previousTitle = nil;
    self.nextTitle = nil;
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    [_segmentedPreviousNext setTintColor:tintColor];
}

- (void)selectedInputFieldIndex:(NSInteger)selectInsex allCountInputFields:(NSInteger)allCountInputFields
{
    // Check if "Previous" button should be enabled
    if (selectInsex > 0) {
        [_segmentedPreviousNext setEnabled:YES forSegmentAtIndex:0];
    }
    else {
        [_segmentedPreviousNext setEnabled:NO forSegmentAtIndex:0];
    }

    // Check if "Next" button should be enabled
    if (selectInsex < allCountInputFields - 1) {
        [_segmentedPreviousNext setEnabled:YES forSegmentAtIndex:1];
    }
    else {
        [_segmentedPreviousNext setEnabled:NO forSegmentAtIndex:1];
    }
}

- (void)segmentedControlPreviousNextChangedValue:(id)sender
{
    switch ([(UISegmentedControl *) sender selectedSegmentIndex]) {
        case 0:
            [delegate didPrevButtonPressd];
            break;
        case 1:
            [delegate didNextButtonPressd];
            break;
        default:
            break;
    }
}

- (void)buttonDonePressed:(id)sender
{
    [delegate didDoneButtonPressd];
}

- (void)setPreviousTitle:(NSString *)aPreviousTitle
{
    previousTitle = aPreviousTitle;
    [_segmentedPreviousNext setTitle:previousTitle forSegmentAtIndex:0];
}

- (void)setNextTitle:(NSString *)aNextTitle
{
    nextTitle = aNextTitle;
    [_segmentedPreviousNext setTitle:nextTitle forSegmentAtIndex:1];
}

@end





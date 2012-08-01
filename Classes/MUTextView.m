//
//  MUTextView.m
//  MUKit
//
//  Created by Yuriy Bosov on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUTextView.h"
#import "MUKeyboardAvoidingProtocol.h"


@interface MUTextView_Holder : NSObject <UITextViewDelegate>

@property(nonatomic, strong) MUTextView *holded;

@end

@interface MUTextView ()

- (void)setup;

@end

@implementation MUTextView

@synthesize mudelegate;
@synthesize keyboardAvoiding;
@synthesize observedText;
@synthesize filter = _filter;


- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    super.delegate = nil;
}

- (void)setup
{
    _delegateHolder = [MUTextView_Holder new];
    _delegateHolder.holded = self;
    super.delegate = _delegateHolder;
}

#pragma mark - MUValidationProtocol

- (void)setValidator:(MUValidator *)aValidator
{
    if (_validator != aValidator) {
        _validator = aValidator;
        _validator.validatableObject = self;
    }
}

- (NSString *)validatableText
{
    return self.text;
}

- (void)setValidatableText:(NSString *)aValidatableText
{
    self.text = aValidatableText;
}

- (MUValidator *)validator
{
    return _validator;
}

- (BOOL)validate
{
    return (_validator) ? ([_validator validate]) : (YES);
}

#pragma mark - UITextViewDelegate

- (void)setDelegate:(id <UITextViewDelegate>)delegate
{
    if (delegate) {
        NSAssert(NO, @"Must use mudelegate!");
    }
}

- (id <UITextViewDelegate>)delegate
{
    return _delegateHolder;
}

@end

@implementation MUTextView_Holder

@synthesize holded;


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    BOOL result = YES;

    if ([holded.mudelegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
        result = [holded.mudelegate textViewShouldBeginEditing:textView];

    return result;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    BOOL result = YES;

    if ([holded.mudelegate respondsToSelector:@selector(textViewShouldEndEditing:)])
        result = [holded.mudelegate textViewShouldEndEditing:textView];

    return result;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [holded.keyboardAvoiding adjustOffset];

    if ([holded.mudelegate respondsToSelector:@selector(textViewDidBeginEditing:)])
        [holded.mudelegate textViewDidBeginEditing:textView];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    holded.observedText = textView.text;

    if ([holded.mudelegate respondsToSelector:@selector(textViewDidEndEditing:)])
        [holded.mudelegate textViewDidEndEditing:textView];
}

- (BOOL)textView:(MUTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL result = YES;

    if (textView.filter) {
        result = [textView.filter filterText:textView shouldChangeCharactersInRange:range replacementString:text];
    }

    if ([holded.mudelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
        result = [holded.mudelegate textView:textView shouldChangeTextInRange:range replacementText:text];

    return result;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([holded.mudelegate respondsToSelector:@selector(textViewDidChange:)])
        [holded.mudelegate textViewDidChange:textView];
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([holded.mudelegate respondsToSelector:@selector(textViewDidChangeSelection:)])
        [holded.mudelegate textViewDidChangeSelection:textView];
}

@end

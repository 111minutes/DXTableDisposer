//
//  MUValidator.m
//  MUKit
//
//  Created by Malaar on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUValidator.h"

BOOL canBeInputByPhonePad(char c);

NSString *getOnlyNumbers(NSString *phoneNumber) {
    NSMutableString *res = [[NSMutableString alloc] init];
    for (int i = 0; i < [phoneNumber length]; i++) {
        char next = [phoneNumber characterAtIndex:i];
        if (canBeInputByPhonePad(next))
            [res appendFormat:@"%c", next];
    }
    return res;
}

BOOL canBeInputByPhonePad(char c) {
    if (c >= '0' && c <= '9') return YES;
    return NO;
}

@implementation MUValidator

@synthesize validatableObject;
@synthesize errorMessage;


- (BOOL)validate
{
    return NO;
}


@end

@implementation MUValidatorAny


- (BOOL)validate
{
    return YES;
}

@end

@implementation MUValidatorNumber


- (BOOL)validate
{
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:@"^[0-9]+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if (_validatableObject && _validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];
    return count == 1;
}

@end

@implementation MUValidatorLetters


- (BOOL)validate
{
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:@"^[A-Za-z]+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if (_validatableObject && _validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];
    return count == 1;
}

@end

@implementation MUValidatorWords


- (BOOL)validate
{
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:@"^([A-Za-z]| )+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if (_validatableObject && _validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];
    return count == 1;
}

@end

@implementation MUValidatorEmail


- (BOOL)validate
{
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    static NSString *mailRegExp = @"^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)$";
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:mailRegExp options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if (_validatableObject && _validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];
    return count == 1;
}

@end

@implementation MUValidatorEqual


- (id)initWithTestedField:(id <MUValidationProtocol>)aTestedObject
{
    if ((self = [super init])) {
        _testedValidator = [aTestedObject validator];
    }

    return self;
}

- (id)initWithTestedFieldValidator:(MUValidator *)aTestedValidator
{
    if ((self = [super init])) {
        _testedValidator = aTestedValidator;
    }

    return self;
}


- (BOOL)validate
{
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [_validatableObject.validatableText isEqualToString:_testedValidator.validatableObject.validatableText];
}

@end

@implementation MUValidatorNotEmpty


- (BOOL)validate
{
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [_validatableObject.validatableText length] > 0;
}

@end

@implementation MUValidatorUSAZipCode


- (BOOL)validate
{
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:@"^[0-9]+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if (_validatableObject && _validatableObject.validatableText && [_validatableObject.validatableText length] == 5) {
        count = [regExp numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];
    }
    return count == 1;
}

@end

@implementation MUValidatorFullName


- (BOOL)validate
{
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:@"^([A-Za-z])+ ([A-Za-z])+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if (_validatableObject && _validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];
    return count == 1;
}

@end

@implementation MUValidatorURL


- (BOOL)validate
{
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:@"^http(s)?://[a-z0-9-]+(.[a-z0-9-]+)+(:[0-9]+)?(/.*)?$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger count = 0;
    if (_validatableObject && _validatableObject.validatableText)
        count = [regExp numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];

    return count == 1;
}

@end

@implementation MUValidatorIntWithRange


- (id)initWithRange:(NSRange)aRange
{
    self = [super init];
    if (self) {
        _range = aRange;
    }
    return self;
}

- (BOOL)validate
{
    BOOL result = NO;
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int intValue = [_validatableObject.validatableText intValue];
    result = intValue >= _range.location && intValue <= _range.location + _range.length;
    return result;
}

@end

@implementation MUValidatorStringWithRange


- (id)initWithRange:(NSRange)aRange
{
    self = [super init];
    if (self) {
        _range = aRange;
    }
    return self;
}

- (BOOL)validate
{
    BOOL result = NO;
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (_validatableObject && _validatableObject.validatableText &&
            [_validatableObject.validatableText length] >= _range.location &&
        [_validatableObject.validatableText length] <= _range.location + _range.length) {
        result = YES;
    }
    return result;
}

@end

@implementation MUValidatorCountNumberInTextWithRange


- (id)initWithRange:(NSRange)aRange
{
    self = [super init];
    if (self) {
        _range = aRange;
    }
    return self;
}

- (BOOL)validate
{
    BOOL result = NO;
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (_validatableObject && _validatableObject.validatableText) {
        NSString *onlyNumber = getOnlyNumbers(_validatableObject.validatableText);
        if (onlyNumber && [onlyNumber length] >= _range.location && [onlyNumber length] <= _range.location + _range.length) {
            result = YES;
        }
    }
    return result;
}

@end

@implementation MUValidatorMoney

- (BOOL)validate
{
    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSUInteger count = 0;
    if (_validatableObject && _validatableObject.validatableText) {
        NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:@"^[1-9]+([0])?(\\.[0-9]{1,2})?$" options:NSRegularExpressionCaseInsensitive error:nil];
        count = [regExp numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];

        if (count == 0) {
            regExp = [[NSRegularExpression alloc] initWithPattern:@"^[0]\\.[1-9]([0-9])?$" options:NSRegularExpressionCaseInsensitive error:nil];
            count = [regExp numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];
        }

        if (count == 0) {
            regExp = [[NSRegularExpression alloc] initWithPattern:@"^[0]\\.[0-9][1-9]$" options:NSRegularExpressionCaseInsensitive error:nil];
            count = [regExp numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];
        }
    }

    return count == 1;
}

@end

@implementation MUValidatorRegExp

@synthesize regularExpression = _regularExpression;


- (id)initWithRegExp:(NSRegularExpression *)aRegExp
{
    self = [super init];
    if (self) {
        self.regularExpression = aRegExp;
    }
    return self;
}


- (BOOL)validate
{
    BOOL result = NO;

    _validatableObject.validatableText = [_validatableObject.validatableText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (_validatableObject.validatableText) {
        NSUInteger count = 0;
        count = [_regularExpression numberOfMatchesInString:_validatableObject.validatableText options:0 range:NSMakeRange(0, [_validatableObject.validatableText length])];

        result = count == 1;
    }
    return result;
}

@end





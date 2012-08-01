//
//  MUValidator.h
//  MUKit
//
//  Created by Malaar on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *getOnlyNumbers(NSString *phoneNumber);

@class MUValidator;

///
@protocol MUValidationProtocol <NSObject>

@property(nonatomic, copy) NSString *validatableText;
- (void)setValidator:(MUValidator *)aValidator;
- (MUValidator *)validator;
- (BOOL)validate;

@end

/// TextField validator
@interface MUValidator : NSObject
{
    id <MUValidationProtocol> _validatableObject;
    NSString *_errorMessage;
}

@property(nonatomic, strong) id <MUValidationProtocol> validatableObject;
@property(nonatomic, copy) NSString *errorMessage;

- (BOOL)validate;

@end

/// Alwayse return YES
@interface MUValidatorAny : MUValidator
{
}
@end

/// return YES if textField has only numbers
@interface MUValidatorNumber : MUValidator
{
}
@end

/// only english letters
@interface MUValidatorLetters : MUValidator
{
}
@end

/// only english words
@interface MUValidatorWords : MUValidator
{
}
@end

/// only email
@interface MUValidatorEmail : MUValidator
{
}
@end

/// return YES if current value equal with value of aTestedField
@interface MUValidatorEqual : MUValidator
{
    MUValidator *_testedValidator;
}

- (id)initWithTestedField:(id <MUValidationProtocol>)aTestedObject;
- (id)initWithTestedFieldValidator:(MUValidator *)aTestedValidator;

@end

///
@interface MUValidatorNotEmpty : MUValidator
{
}
@end

///
@interface MUValidatorUSAZipCode : MUValidator
{
}
@end

/// full name consist of first name ' ' lastName
@interface MUValidatorFullName : MUValidator
{
}
@end

///
@interface MUValidatorURL : MUValidator
{
}
@end

///
@interface MUValidatorIntWithRange : MUValidator
{
    NSRange _range;
}

- (id)initWithRange:(NSRange)aRange;

@end

///
@interface MUValidatorStringWithRange : MUValidator
{
    NSRange _range;
}

- (id)initWithRange:(NSRange)aRange;

@end

/// Exemple: validation count number in phone number (050)-50-50-500
@interface MUValidatorCountNumberInTextWithRange : MUValidator
{
    NSRange _range;
}

- (id)initWithRange:(NSRange)aRange;

@end

///
@interface MUValidatorMoney : MUValidator
{

}

@end

///
@interface MUValidatorRegExp : MUValidator

@property(nonatomic, strong) NSRegularExpression *regularExpression;

- (id)initWithRegExp:(NSRegularExpression *)aRegExp;

@end

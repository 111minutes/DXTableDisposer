//
//  MUTextField.h
//  MUKit
//
//  Created by Malaar on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUValidator.h"
#import "MUFilter.h"
#import "MUKeyboardAvoiderProtocol.h"

@class MUTextField_Holder;

@interface MUTextField : UITextField <MUValidationProtocol, UITextFieldDelegate, MUKeyboardAvoiderProtocol>
{
    MUValidator *_validator;
    MUTextField_Holder *_delegateHolder;
}

@property(nonatomic, strong) id <UITextFieldDelegate> mudelegate;
@property(nonatomic, strong) MUFilter *filter;

@end

//
//  TKDataFormValidator.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKDataFormEntityProperty;

/**
 A protocol used to validate values when using TKDataForm.
 */
@protocol TKDataFormValidator <NSObject>
@required

/**
 Defines the validation logic for a specific property.
 @param property The property to validate.
 */
- (BOOL)validateProperty:(TKDataFormEntityProperty *)property;

/**
 Returns a response message based on the validation status of the property.
 */
- (NSString *)validationMessage;

@end

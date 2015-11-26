//
//  TKDataFormEntityProperty.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKDataForm.h"

@class TKDataFormEntity;

/**
 @discussion This class represents a model of a property.
 */
@interface TKDataFormEntityProperty : NSObject

/**
 The name of the source property.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 The class of the source property. Will be nil if it is a primitive (read-only).
 */
@property (nonatomic, strong, readonly) Class propertyClass;

/**
 The type of the property.
 */
@property (nonatomic) TKDataFormPropertyType type;

/**
 The name that will be displayed in TKDataForm.
 */
@property (nonatomic, strong) NSString *displayName;

/**
 The name of the group to which this property will belong. Used with TKDataFormEntityDataSource.
 */
@property (nonatomic) NSString *groupKey;

/**
 The index at which a property will be placed in the data form.
 */
@property (nonatomic) NSInteger propertyIndex;

/**
 The TKDataFormEntity to which the property belongs (read-only).
 */
@property (nonatomic, weak, readonly) TKDataFormEntity *owner;

/**
 Determines if the property should be visible in the data form.
 */
@property (nonatomic) BOOL hidden;

/**
 Determines if the property could be edited in the data form.
 */
@property (nonatomic) BOOL readonly;

/**
 Indicates indicates if the property has passed validation (read-only).
 */
@property (nonatomic, readonly) BOOL isValid;

/**
 An array of validators that adopt the TKDataFormValidator protocol that will be used to validate the property.
 */
@property (nonatomic, strong) NSArray *validators;

/**
 A feedback message used to show the validation results.
 */
@property (nonatomic, strong) NSString *feedbackMessage;

/**
 A UIImage that will be displayed next to the title label of the property.
 */
@property (nonatomic, strong) UIImage *image;

/**
 A UIImage that will be displayed to show validation results.
 */
@property (nonatomic, strong) UIImage *feedbackImage;

/**
 The value of the property model. This value may still not be committed.
 */
- (id)value;

/**
 The last committed value.
 */
- (id)originalValue;

@end

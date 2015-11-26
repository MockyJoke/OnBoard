//
//  TKDataFormEntity.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TKDataFormEntityProperty;

/**
 @discussion This class represents a model that is created from the business object.
 */
@interface TKDataFormEntity : NSObject

/**
 The object from which a model will be created.
 */
@property (nonatomic, strong) NSObject *sourceObject;

/**
 Instantiates a TKDataFormEntity with an object.
 @param object The source object.
 */
- (id)initWithObject:(NSObject *)object;

/**
 @return An array of TKDataFormEntityProperty objects containing all the properties from the bisuness object.
 */
- (NSArray *)properties;

/**
 @return All the properties that will be visible in the data form.
 */
- (NSArray *)visibleProperties;

/**
 The TKDataFormEntityProperty with the specified name.
 @param name The name of the property that has to be returned.
 @return TKDataFormEntityProperty.
 */
- (TKDataFormEntityProperty *)propertyWithName:(NSString *)name;

@end

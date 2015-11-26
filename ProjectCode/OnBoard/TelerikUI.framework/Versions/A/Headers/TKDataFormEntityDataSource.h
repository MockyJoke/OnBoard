//
//  TKDataFormEntityDataSource.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKDataForm.h"

@class TKDataFormEntity;

/**
 @discussion The default data source for TKDataForm.
 */
@interface TKDataFormEntityDataSource : NSObject <TKDataFormDataSource, TKDataFormDelegate>

/**
 The business object that is edited in TKDataForm.
 */
@property (nonatomic, strong) NSObject *selectedObject;

/**
 The TKDataFormEntity that is created from the object (read-only).
 */
@property (nonatomic, strong, readonly) TKDataFormEntity *entityModel;

/**
 Determines if the properties can be reordered in the data form.
 */
@property (nonatomic) BOOL allowPropertySorting;

@end

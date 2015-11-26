//
//  TKDataFormOptionsEditor.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "TKDataFormEditor.h"

/**
 An editor view which allows editing values in TKDataForm by using an option list.
 */
@interface TKDataFormOptionsEditor : TKDataFormEditor

/**
 An array of all options in the TKDataFormOptions.
 */
@property (nonatomic, strong) NSArray *options;

/**
 The label of the selected option (read-only).
 */
@property (nonatomic, strong, readonly) UILabel *selectedOptionLabel;

@end

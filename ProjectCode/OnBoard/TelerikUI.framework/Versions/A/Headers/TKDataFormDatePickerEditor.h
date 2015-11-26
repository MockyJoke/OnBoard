//
//  TKDataFormDatePickerCell.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "TKDataFormEditor.h"

/**
 @discussion The default editor for date values. In its essence, it is a UIDatePicker.
 */
@interface TKDataFormDatePickerEditor : TKDataFormEditor

/**
 The value label of the editor (read-only).
 */
@property (nonatomic, strong, readonly) UILabel *editorValueLabel;

/**
 The NSDateFormatter object included in the TKDataFormDatePickerEditor.
 */
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

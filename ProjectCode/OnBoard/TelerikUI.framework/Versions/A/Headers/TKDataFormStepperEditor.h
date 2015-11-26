//
//  TKDataFormStepperCell.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "TKDataFormEditor.h"

/**
 The editor view is used to edit numeric values. In its essence, it is a UIStepper.
 */
@interface TKDataFormStepperEditor : TKDataFormEditor

/**
 The value label of TKDataFormStepperEditor (read-only).
 */
@property (nonatomic, strong, readonly) UILabel *valueLabel;

@end

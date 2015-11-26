//
//  TKDataFormSegmentedCell.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "TKDataFormEditor.h"

/**
 An editor view used to edit values in TKDataForm by using a UISegmentedControl.
 */
@interface TKDataFormSegmentedEditor : TKDataFormEditor

/**
 The names of all the segments in TKDataFormSegmentedEditor.
 */
@property (nonatomic, strong) NSArray *segments;

@end

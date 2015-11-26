//
//  TKDataFormOptionsViewController.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKDataFormOptionsEditor;

/**
 @discussion The TKDataFormOptionsViewController class represents a view controller used to represent a list with options in master/detail scenario.
 */
@interface TKDataFormOptionsViewController : UITableViewController

/**
 The editor items.
 */
@property (nonatomic, strong) NSArray *items;

/**
 An instance of TKDataFormOptionsEditor.
 */
@property (nonatomic, weak) TKDataFormOptionsEditor *editor;

@end

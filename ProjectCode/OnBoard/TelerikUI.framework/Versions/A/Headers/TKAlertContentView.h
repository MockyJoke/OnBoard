//
//  TKAlertViewContentView.h
//  AlertView
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "TKView.h"

@class TKAlertStyle;

/**
 The message body of an alert defined in a TKAlert object.
 */
@interface TKAlertContentView : TKView

/**
 The image view contained in TKAlert's content view.
 */
@property (nonatomic, strong) UIImageView* imageView;

/**
 The text label contained in TKAalert's content view.
 */
@property (nonatomic, strong) UILabel* textLabel;

/**
 The style object containing all properties for styling TKAlert.
*/
@property (nonatomic, weak) TKAlertStyle *style;

@end

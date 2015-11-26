//
//  TKDataFormHeaderView.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "TKView.h"

/**
 A view used in TKDataForm to represent a header.
 */
@interface TKDataFormHeaderView : TKView

/**
 The title label of the header (read-only).
 */
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/**
 The insets of the header's content.
 */
@property (nonatomic) UIEdgeInsets insets;

/**
 The fill color for the separator area.
 */
@property (nonatomic, strong) TKFill *separatorColor;

@end

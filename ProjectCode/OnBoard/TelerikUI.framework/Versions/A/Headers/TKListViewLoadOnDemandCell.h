//
//  TKListViewLoadOnDemandCell.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>

@interface TKListViewLoadOnDemandCell : TKListViewCell

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)updateState;

@end

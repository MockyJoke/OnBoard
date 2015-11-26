//
//  TKAlertAction.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

@class TKAlert;

/**
 This object represents an action that can be executed when tapping a button in an alert.
 */
@interface TKAlertAction : NSObject

/**
 The block that will execute when TKAlertAction's button is clicked.
 */
@property (nonatomic, copy) BOOL (^handler)(TKAlert *alert, TKAlertAction* action);

/**
 The title.
 */
@property (nonatomic, strong) NSString* title;

/**
 The color of the title.
 */
@property (nonatomic, strong) UIColor* titleColor;

/**
 The background color.
 */
@property (nonatomic, strong) UIColor* backgroundColor;

/**
 The font.
 */
@property (nonatomic, strong) UIFont* font;

/**
 The tag.
 */
@property (nonatomic) NSInteger tag;

/**
 The corner radius.
 */
@property (nonatomic) CGFloat cornerRadius;

/**
 Initializes a TKAlertAction with a title and a block method to be called when the button of the action is tapped.
 @param title The title.
 @param handler The block method to be called when the button of the action is tapped.
 */
-(instancetype)initWithTitle:(NSString *)title handler:(BOOL (^)(TKAlert *alert, TKAlertAction* action))handler;

/**
 Initializes a TKAlertAction with a title and a block method to be called when the button of the action is tapped.
 @param title The title.
 @param handler The block method to be called when the button of the action is clicked.
 */
+(TKAlertAction*)actionWithTitle:(NSString*)title handler:(BOOL (^)(TKAlert *alert, TKAlertAction* action))handler;

@end

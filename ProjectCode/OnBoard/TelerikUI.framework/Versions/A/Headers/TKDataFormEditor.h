//
//  TKDataFormCell.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKDataFormEntityProperty;
@class TKDataFormEditorStyle;

/**
 The base editor class used in TKDataForm.
 */
@interface TKDataFormEditor : UIView

/**
 The text label of the editor (read-only).
 */
@property (nonatomic, strong, readonly) UILabel *textLabel;

/**
 The image view of the editor (read-only).
 */
@property (nonatomic, strong, readonly) UIImageView *imageView;

/**
 The validation image view in TKDataFormEditor (read-only).
 */
@property (nonatomic, strong, readonly) UIImageView *feedbackImageView;

/**
 The validation text label in TKDataFormEditor.
 */
@property (nonatomic, strong, readonly) UILabel *feedbackLabel;

/**
The space for TKDataFormEditor's content. It should be a value between 0 and 1.
 */
@property (nonatomic) CGFloat contentSpace;

/**
 The TKDataFormEditor's value.
 */
@property (nonatomic) id value;

/**
 The property that is edited by this editor.
 */
@property (nonatomic, strong) TKDataFormEntityProperty *property;

/**
 The object responsible for TKDataFormEditor's styling and customization.
 */
@property (nonatomic, strong) TKDataFormEditorStyle *style;

/**
 Initializes a TKDataFormEditor with an entity property.
 @param property The entity property used for creating TKDataFormEditor.
 */
- (id)initWithProperty:(TKDataFormEntityProperty *)property;

/**
 @return The control used to edit a property.
 */
- (UIView *)editor;

/**
 Notifies TKDataForm when the editor value is changed. Must be called from sublclasses.
 */
- (void)notifyValueChange;

/**
 This method returns YES if the editor is inline and NO if the editor is not inline.
 */
- (BOOL)isInlineEditor;

/**
 When this method is called the editor gets the focus. Must be called form sublclasses.
 */
- (void)changeEditorOnFocus;


@end

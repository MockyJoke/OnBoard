//
//  TKDataForm.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TKDataFormDataSource;
@protocol TKDataFormDelegate;
@class TKDataFormEntityProperty;
@class TKDataFormEditor;

/**
 @enum TKDataFormPropertyType
 @discussion An enum that defines the type of the property.
 */
typedef NS_ENUM(int, TKDataFormPropertyType) {
    /**
     The property is of type object.
     */
    TKDataFormPropertyTypeObject,
    
    /**
     The property is of type decimal number.
     */
    TKDataFormPropertyTypeInteger,
    
    /**
     The property is of type floating point number.
     */
    TKDataFormPropertyTypeFloat,
    
    /**
     The property is of type bool.
     */
    TKDataFormPropertyTypeBool,
    
    /**
     The property is of type unsigned number.
     */
    TKDataFormPropertyTypeUnsigned,
    
    /**
     The property is of type string.
     */
    TKDataFormPropertyTypeText,
    
    /**
     The property is of type date.
     */
    TKDataFormPropertyTypeDate
};

/**
 @enum TKDataFormCommitMode
 @discussion An enum that defines the commit modes for TKDataForm.
 */
typedef NS_ENUM(int, TKDataFormCommitMode)
{
    /**
     The property value will be commited on every change happening in the editor. The property will first be validated.
     */
    TKDataFormCommitModeImmediate,
    
    /**
     The property will be commited when the focus changes to another editor.
     If validation mode is delayed, the property will still be validated before commit.
     */
    TKDataFormCommitModeOnLostFocus,
    
    /**
     The entered data will be commited when the TKDataForm's commit method is called explicitly.
     */
    TKDataFormCommitModeDelayed
};

/**
 @enum TKDataFormValidationMode
 @discussion An enum that defines the validation modes for TKDataForm.
 */
typedef NS_ENUM(int, TKDataFormValidationMode)
{
    /**
     The property will be validated on every change of its value.
     */
    TKDataFormValidationModeImmediate,
    
    /**
     The property will be validated when the focus changes to another editor.
     */
    TKDataFormValidationModeOnLostFocus,
    
    /**
     The property will be validated when the commit method is invoked. This should be used only with TKDataFormCommitModeDelayed.
     */
    TKDataFormValidationModeDelayed
};

/**
 @discussion TKDataForm is a component that allows you to easily edit a business object's properties.
 */
@interface TKDataForm : UIView

/**
 TKDataForm's data source.
 */
@property (nonatomic, weak) id<TKDataFormDataSource> dataSource;

/**
 TKDataForm's delegate.
 */
@property (nonatomic, weak) id<TKDataFormDelegate> delegate;

/**
 TKDataForm's commit mode. It determines when the data the user has just entered will be reflected on the underlying business object.
 */
@property (nonatomic) TKDataFormCommitMode commitMode;

/**
 TKDataForm's validation mode.
 */
@property (nonatomic) TKDataFormValidationMode validationMode;

/**
 Determines if scrolling is enabled.
 */
@property (nonatomic) BOOL allowScroll;

/**
 Commits the data entered in TKDataForm. This method takes effect only when commit mode is TKDataFormCommitModeDelayed.
 */
- (void)commit;

/**
 Registers an editor class for a specified property. This method has highest priority among the other two register methods (for type and for class).
 @param editorClass The class of the editor that will be used.
 @param property The property for which the editor class will be used.
 */
- (void)registerEditor:(Class)editorClass forProperty:(TKDataFormEntityProperty *)property;

/**
 Registers an editor of a specified class for a property of a specified class.
 @param editorClass The class of the editor that will be used.
 @param propertyClass The property class for which the editor class will be used.
 */
- (void)registerEditor:(Class)editorClass forPropertyOfClass:(Class)propertyClass;

/**
 Registers an editor class for a property type.
 @param editorClass The class of the editor that will be used.
 @param propertyType The type of the properties that will be registered.
 */
- (void)registerEditor:(Class)editorClass forPropertyOfType:(TKDataFormPropertyType)propertyType;

/**
 Reloads TKDataForm.
 */
- (void)reloadData;

/**
 Updates the layout of the editors in TKDataForm.
 */
- (void)updateEditors;

@end

/**
 @discussion The TKDataSource protocol is adopted by an object that mediates the application's data model for a TKDataForm object.
 The data source provides the data form object with the information it needs to construct and modify a data form.
 */
@protocol TKDataFormDataSource <NSObject>

@required

/**
 The TKDataFormEntityProperty at the specified index path.
 @param dataForm The requesting TKDataForm object.
 @param indexPath The property index path.
 @return The TKDataFormEntityProperty at the specified index path.
 */
- (TKDataFormEntityProperty *)dataForm:(TKDataForm *)dataForm propertyAtIndexPath:(NSIndexPath *)indexPath;

/**
 The number of rows in the corresponding section.
 @param dataForm The requesting TKDataForm object.
 @param section The section for which a number of rows should be returned.
 @return The number of rows in the corresponding section.
 */
- (NSInteger)dataForm:(TKDataForm *)dataForm numberOfRowsInSection:(NSInteger)section;

/**
 The value of the corresponding property.
 @param dataForm The requesting TKDataForm object.
 @param property The property which value will be returned.
 @return The value of the corresponding property.
 */
- (id)dataForm:(TKDataForm *)dataForm valueForProperty:(TKDataFormEntityProperty *)property;

/**
 Defines the value for the corresponding property.
 @param dataForm The requesting TKDataForm object.
 @param value The value that will be set to the property.
 @param property The propery which value will be set.
 */
- (void)dataForm:(TKDataForm *)dataForm setValue:(id)value forProperty:(TKDataFormEntityProperty *)property;

@optional

/**
 The number of sections in the form.
 @param dataForm The requesting TKDataForm object.
 @return The number of section in the data form.
 */
- (NSInteger)numberOfSectionsInDataForm:(TKDataForm *)dataForm;

/**
 The header title of the corresponding section.
 @param dataForm The requesting TKDataForm object.
 @param section The section which requests a header title.
 @return The title string.
 */
- (NSString *)dataForm:(TKDataForm *)dataForm titleForHeaderInSection:(NSInteger)section;

/**
 The footer title for the corresponding section.
 @param dataForm The requesting TKDataForm object.
 @param section The section which requests a footer title.
 @return The title string.
 */
- (NSString *)dataForm:(TKDataForm *)dataForm titleForFooterInSection:(NSInteger)section;

@end

/**
 @discussion The methods declared by the TKDataFormDelegate protocol allow the adopting delegate to respond to messages from the TKDataForm class and thus respond to different operations.
 */
@protocol TKDataFormDelegate <NSObject>
@optional

/**
 The TKDataFormEditor for the specified property.
 @param dataForm The requesting TKDataForm object.
 @param property The property for which an editor will be returned.
 @return The TKDataFormEditor for the corresponding property.
 */
- (TKDataFormEditor *)dataForm:(TKDataForm *)dataForm editorForProperty:(TKDataFormEntityProperty *)property;

/**
 Called when a row with the corresponding property is selected.
 @param dataForm The requesting TKDataForm object.
 @param property The property that has been selected.
 */
- (void)dataForm:(TKDataForm *)dataForm didSelectRowForProperty:(TKDataFormEntityProperty *)property;

/**
 Called after a property is edited.
 @param dataForm The requesting TKDataForm object.
 @param property The edited property.
 */
- (void)dataForm:(TKDataForm *)dataForm didEditProperty:(TKDataFormEntityProperty *)property;

/**
 Called after a property is validated.
 @param dataForm The requesting TKDataForm object.
 @param property The validated property.
 @param editor The property edior.
 */
- (void)dataForm:(TKDataForm *)dataForm didValidateProperty:(TKDataFormEntityProperty *)property editor:(TKDataFormEditor *)editor;

/**
 Called when a property has to be validated.
 @param dataForm The requesting TKDataForm object.
 @param property The property that has to be validated.
 @param editor The property's editor.
 */
- (BOOL)dataForm:(TKDataForm *)dataForm validateProperty:(TKDataFormEntityProperty *)property editor:(TKDataFormEditor *)editor;

/**
 Called before an editor is desplayed to the screen of after validation. This method lets you change the visual styles and setting of TKDataFormEditor object.
 @param dataForm The requesting TKDataForm object.
 @param editor The editor that will be updated.
 @param property The editor's property.
 */
- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKDataFormEntityProperty *)property;

/**
 Called just before a property value will be commited to the business object.
 @param dataForm The requesting TKDataForm object.
 @param property The property which value is about to be committed.
 */
- (void)dataForm:(TKDataForm *)dataForm willCommitProperty:(TKDataFormEntityProperty *)property;

/**
 Called after a property value is committed to the business object.
 @param dataForm The requesting TKDataForm object.
 @param property The property that has been committed.
 */
- (void)dataForm:(TKDataForm *)dataForm didCommitProperty:(TKDataFormEntityProperty *)property;

/**
 The header for the corresponding section.
 @param dataForm The requesting TKDataForm object.
 @param section The section.
 @return The header for the section.
 */
- (UIView *)dataForm:(TKDataForm *)dataForm viewForHeaderInSection:(NSInteger)section;

/**
 The footer for the corresponding section.
 @param dataForm The requesting TKDataForm object.
 @param section The section.
 @return The footer for the section.
 */
- (UIView *)dataForm:(TKDataForm *)dataForm viewForFooterInSection:(NSInteger)section;

/**
 The header height for the corresponding section.
 @param dataForm The requesting TKDataForm object.
 @param section The section for which a header height is requested.
 @return The height for the section header.
 */
- (CGFloat)dataForm:(TKDataForm *)dataForm heightForHeaderInSection:(NSInteger)section;

/**
 Asks the delegate for footer height for the corresponding section.
 @param dataForm The requesting TKDataForm object.
 @param section The section for which a footer height is requested.
 @return Height for the section footer.
 */
- (CGFloat)dataForm:(TKDataForm *)dataForm heightForFooterInSection:(NSInteger)section;

@end
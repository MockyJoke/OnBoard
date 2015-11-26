//
//  TKListViewLinearLayout.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

/**
 @enum TKListViewScrollDirection
 @discussion Defines the scroll direction.
 */
typedef NS_ENUM(NSInteger, TKListViewScrollDirection)
{
    /**
     Vertical scroll direction.
     */
    TKListViewScrollDirectionVertical,
    /**
     Horizontal scroll direction.
     */
    TKListViewScrollDirectionHorizontal
};

/**
 @enum TKListViewItemAlignment
 @discussion Defines the cell alignment when using columns layout.
 */
typedef NS_ENUM(NSInteger, TKListViewItemAlignment)
{
    /**
     Visually stretch items.
     */
    TKListViewItemAlignmentStretch   = 0,
    /**
     Visually left align items.
     */
    TKListViewItemAlignmentLeft      = 1,
    /**
     Visually center items.
     */
    TKListViewItemAlignmentCenter    = 2,
    /**
     Visually right align items.
     */
    TKListViewItemAlignmentRight     = 3,
};

/**
 @enum TKListViewItemAnimation
 @discussion Defines the cell animation to be applied when a cell appears/hides or is being inserted.
 */
typedef NS_ENUM(NSInteger, TKListViewItemAnimation)
{
    /**
     Default animation will be used.
     */
    TKListViewItemAnimationDefault,
  
    /**
     A fade in/fade out animation.
     */
    TKListViewItemAnimationFade,
    
    /**
     A scale in/scale out animation.
     */
    TKListViewItemAnimationScale,
    
    /**
     A slide in/slide out animation.
     */
    TKListViewItemAnimationSlide
};

/**
 A base layout used to render cells in TKListView.
 */
@interface TKListViewLinearLayout : UICollectionViewLayout

/**
 The scroll direction.
 */
@property (nonatomic) TKListViewScrollDirection scrollDirection;

@property (nonatomic) TKListViewItemAnimation itemInsertAnimation;

@property (nonatomic) TKListViewItemAnimation itemDeleteAnimation;

@property (nonatomic) TKListViewItemAnimation itemAppearAnimation;

@property (nonatomic) CGFloat animationDuration;

/**
 The desired cell alignment within a column.
 */
@property (nonatomic) TKListViewItemAlignment itemAlignment;

/**
 The spacing between items.
 */
@property (nonatomic) CGFloat itemSpacing;

/**
 The item size. 
 */
@property (nonatomic) CGSize itemSize;

/**
 The header reference size.
 */
@property (nonatomic) CGSize headerReferenceSize;

/**
 The footer reference size.
 */
@property (nonatomic) CGSize footerReferenceSize;

/**
 Initializes the group header layout attributes.
 @param attributes The attributes to initialize.
 @param point The current location.
 */
- (CGPoint)initHeaderAttributes:(UICollectionViewLayoutAttributes*)attributes atPoint:(CGPoint)point;

/**
 Initializes the group footer layout attributes.
 @param attributes The attributes to initialize.
 @param point The current location.
 */
- (CGPoint)initFooterAttributes:(UICollectionViewLayoutAttributes*)attributes atPoint:(CGPoint)point;

/**
 Initializes item attributes in list view group.
 @param section The current section to initialize.
 @param location The current location.
 */
- (CGPoint)layoutSection:(NSInteger)section atPoint:(CGPoint)location;

/**
 Initializes a single item layout attributes.
 @param attributes The item attributes to initialize.
 @param point The current location.
 @param lastInSection Indicates whether the item is the last in its section.
 */
- (CGPoint)initItemAttributes:(UICollectionViewLayoutAttributes*)attributes atPoint:(CGPoint)point lastInSection:(BOOL)lastInSection;

/**
 Calculates the item width(height when using horizontal scroll direction) based on layout parameters.
 */
- (CGFloat)calculatedItemWidth;

@end

//
//  TKLinearGradientFill.h
//  TelerikUI
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "TKGradientFill.h"

/**
 @discussion Represents a linear gradient fill.
 */
@interface TKLinearGradientFill : TKGradientFill

/**
 Reverses a linear gradient fill.
 @param fill The fill.
 @return The reversed fill.
 */
+ (instancetype)reverse:(TKLinearGradientFill*)fill;

/**
 Creates a linear gradient fill with colors.
 @param colors The array of UIColor containing gradient colors.
 */
+ (instancetype)linearGradientFillWithColors:(NSArray *)colors;

/**
 Creates a linear gradient fill with colors, start point and end point.
 @param colors The array of UIColor containing gradient colors.
 @param startPoint The start point for gradient drawing. Both values are in the interval of 0 to 1.
 @param endPoint The end point for gradient drawing. Both values are in the interval of 0 to 1.
 */
+ (instancetype)linearGradientFillWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 Creates a linear gradient fill with colors, locations, start point and end point.
 @param colors The array of UIColor containing gradient colors.
 @param locations The array of NSNumber objects defining the location of each gradient stop in the interval of 0 to 1.
 @param startPoint The start point for gradient drawing. Both values are in the interval of 0 to 1.
 @param endPoint The end point for gradient drawing. Both values are in the interval of 0 to 1.
 */
+ (instancetype)linearGradientFillWithColors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 Initializes a linear gradient fill with colors, start point and end point.
 @param colors The array of UIColor containing gradient colors.
 @param startPoint The start point for gradient drawing. Both values are in the interval of 0 to 1.
 @param endPoint The end point for gradient drawing. Both values are in the interval of 0 to 1.
 */
- (id)initWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 Initializes a linear gradient fill with colors, locations, start point and end point.
 @param colors The array of UIColor containing gradient colors
 @param locations The array of NSNumber objects defining the location of each gradient stop in the interval of 0 to 1.
 @param startPoint The start point for gradient drawing. Both values are in the interval of 0 to 1.
 @param endPoint The end point for gradient drawing. Both values are in the interval of 0 to 1.
 */
- (id)initWithColors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 The start point of the gradient. Both values are in the interval of 0 to 1.
 */
@property (nonatomic, assign) CGPoint startPoint;

/**
 The end point of the gradient. Both values are in the interval of 0 to 1.
 */
@property (nonatomic, assign) CGPoint endPoint;

@end

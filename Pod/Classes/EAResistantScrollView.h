//
//  EAResistantScrollView.h
//  Pods
//
//  Created by Edgar Antunes on 05/03/2015.
//
//

@import UIKit;

@interface EAResistantScrollView : UIScrollView

/**
 *  This flag defines whether or not resistance is enabled on the scroll view.
 *  If this is set to NO, both @c resistanceFactor and @c resistanceProgressionRatio
 *  remain unused. Otherwise, if set to YES, resistance is applied based on those two values.
 */
@property (nonatomic, assign) IBInspectable BOOL shouldApplyResistance;

/**
 *  This property defines the base value of how resistant the scroll view is when
 *  performing overscroll operations. Please look at @c resistanceProgressionRatio
 *  in order to achieve progressive resistance during an overscroll operation.
 */
@property (nonatomic, assign) IBInspectable CGFloat resistanceFactor;

/**
 *  This property affects how much more resistant the scroll view becomes as the user
 *  continues performing overscroll operations. If this value is 0 the resistance will
 *  be defined solely by @c resistanceFactor and it will remain the same throughout
 *  the overscroll operation; otherwise, it will impact how much resistance is seen
 *  when overscrolling.
 *
 *  Values between 0 and 1 seem to work best with the current implementation.
 */
@property (nonatomic, assign) IBInspectable CGFloat resistanceProgressionRatio;

/**
 *  If defined, this block is run every time the scroll view's delegate method
 *  @c scrollViewDidScroll: is called. Since this class sets itself as the scroll 
 *  view's delegate, this may be used when external code needs to be executed.
 */
@property (nonatomic, copy) void (^scrollViewDidScrollExecutionBlock)(UIScrollView *);

@end

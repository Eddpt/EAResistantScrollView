# EAResistantScrollView

## Interface

Resistance can be enabled or disabled through the following property:
```
/**
 *  This flag defines whether or not resistance is enabled on the scroll view.
 *  If this is set to NO, both @c resistanceFactor and @c resistanceProgressionRatio
 *  remain unused. Otherwise, if set to YES, resistance is applied based on those two values.
 */
@property (nonatomic, assign) IBInspectable BOOL shouldApplyResistance;
```


When enabled, resistance is applied using a `resistanceFactor` and a `resistanceProgressionRatio`:
```
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
```


It is also possible to define an execution block that is run every time the `UIScrollView`'s delegate method `scrollViewDidScroll:` is called. The block is executed after the resistance is applied so that the `contentOffset` value is adjusted when running the block:
```
/**
 *  If defined, this block is run every time the scroll view's delegate method
 *  @c scrollViewDidScroll: is called. Since this class sets itself as the scroll 
 *  view's delegate, this may be used when external code needs to be executed.
 */
@property (nonatomic, copy) void (^scrollViewDidScrollExecutionBlock)(UIScrollView *);
```


If usages of this class need to implement the `UIScrollView`'s delegate methods for some other tasks, they can do so simply by setting the delegate. `EAResistantScrollView` will be responsible for redirecting any delegate calls to the appropriate object.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

EAResistantScrollView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "EAResistantScrollView"

Import:

	#import <EAResistantScrollView/EAResistantScrollView.h>

## Author

Edgar Antunes

## License

EAResistantScrollView is available under the MIT license. See the LICENSE file for more info.


//
//  EAResistantScrollView.m
//  Pods
//
//  Created by Edgar Antunes on 05/03/2015.
//
//

#import "EAResistantScrollView.h"

@interface EAResistantScrollView() <UIScrollViewDelegate>

@property (nonatomic, weak) id<UIScrollViewDelegate> secondaryDelegate;

@property (nonatomic, assign) BOOL isInActiveGesture;

@property (nonatomic, assign) CGPoint lastRecognizedTouch;

@end

@implementation EAResistantScrollView

#pragma mark - Initialization

- (instancetype)init
{
  self = [super init];
  if (!self) {
    return nil;
  }

  [self setupScrollView];

  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (!self) {
    return nil;
  }
  
  [self setupScrollView];
  
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (!self) {
    return nil;
  }
  
  [self setupScrollView];
  
  return self;
}

- (void)setupScrollView
{
  super.delegate = self;
  
  [self.panGestureRecognizer addTarget:self action:@selector(panGestureRecognizerDetected:)];
}

- (void)setDelegate:(id<UIScrollViewDelegate>)delegate
{
  self.secondaryDelegate = delegate;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if (!self.isInActiveGesture || !self.shouldApplyResistance) {
    [self finalizeScrollViewDidScroll:scrollView];
    return;
  }
  
  if (self.tracking) {
    if (scrollView.contentOffset.y <= 0) { // Negative overscrolling
      CGFloat distanceMoved = self.lastRecognizedTouch.y - scrollView.contentOffset.y;
      CGFloat normalizedDistance = - distanceMoved / (self.resistanceFactor + self.normalizedResistanceProgressionRatio * distanceMoved);
      
      scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, normalizedDistance);
    } else {
      
      CGFloat nonVisibleContentSize = scrollView.contentSize.height - scrollView.frame.size.height;
      
      if (scrollView.contentOffset.y > nonVisibleContentSize) { // Positive overscrolling
        CGFloat distanceMoved = self.lastRecognizedTouch.y - (scrollView.contentOffset.y - nonVisibleContentSize);
        CGFloat normalizedDistance = nonVisibleContentSize - distanceMoved / (self.resistanceFactor - self.normalizedResistanceProgressionRatio * distanceMoved);
        
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, normalizedDistance);
      }
    }
  }
  
  [self finalizeScrollViewDidScroll:scrollView];
}

- (void)finalizeScrollViewDidScroll:(UIScrollView *)scrollView
{
  !self.scrollViewDidScrollExecutionBlock ?: self.scrollViewDidScrollExecutionBlock(scrollView);
  
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
    [self.secondaryDelegate scrollViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
    [self.secondaryDelegate scrollViewDidZoom:scrollView];
  }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
    [self.secondaryDelegate scrollViewWillBeginDragging:scrollView];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
    [self.secondaryDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
    [self.secondaryDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
  }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
    [self.secondaryDelegate scrollViewWillBeginDecelerating:scrollView];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
    [self.secondaryDelegate scrollViewDidEndDecelerating:scrollView];
  }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
    [self.secondaryDelegate scrollViewDidEndScrollingAnimation:scrollView];
  }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  if ([self.secondaryDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
    return [self.secondaryDelegate viewForZoomingInScrollView:scrollView];
  }
  
  return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
    [self.secondaryDelegate scrollViewWillBeginZooming:scrollView withView:view];
  }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
    [self.secondaryDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
  }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
    return [self.secondaryDelegate scrollViewShouldScrollToTop:scrollView];
  }
  
  return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
  if ([self.secondaryDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
    [self.secondaryDelegate scrollViewDidScrollToTop:scrollView];
  }
}


#pragma mark - Gesture Recognizer

- (void)panGestureRecognizerDetected:(UIPanGestureRecognizer *)recognizer
{
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan:
      self.isInActiveGesture = YES;
      break;
      
    case UIGestureRecognizerStateEnded:
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed:
      self.isInActiveGesture = NO;
      break;
      
    default:
      break;
  }

  self.lastRecognizedTouch = [recognizer translationInView:self];
}


#pragma mark - Private helpers

- (float)normalizedResistanceProgressionRatio
{
  return self.resistanceProgressionRatio / 100;
}

@end

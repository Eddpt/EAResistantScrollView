//
//  EAResistantScrollView.m
//  Pods
//
//  Created by Edgar Antunes on 05/03/2015.
//
//

#import "EAResistantScrollView.h"

@interface EAResistantScrollView() <UIScrollViewDelegate>

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
  self.delegate = self;
  
  [self.panGestureRecognizer addTarget:self action:@selector(panGestureRecognizerDetected:)];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  !self.scrollViewDidScrollExecutionBlock ?: self.scrollViewDidScrollExecutionBlock(scrollView);
  
  if (!self.isInActiveGesture || !self.shouldApplyResistance) {
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

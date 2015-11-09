//
//  AWScrollView.h
//  AWScrollView-OC
//
//  Created by Alex Ling on 9/11/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWScrollView : UIScrollView <UIScrollViewDelegate>

- (void) scrollTo:(CGPoint) point;
- (void) setUp;

@property CGFloat xExtension;
@property CGFloat yExtension;

@property CGFloat screenWidth;
@property CGFloat screenHeight;

@property CGPoint upPoint;
@property CGPoint leftPoint;
@property CGPoint rightPoint;
@property CGPoint downPoint;
@property CGPoint centerPoint;

@property NSTimeInterval transitionTime;
@property UIView *mainView;

@end

typedef enum{
	Up,
	Down,
	
	Left,
	Right,
	
	None
}ScrollDirection;

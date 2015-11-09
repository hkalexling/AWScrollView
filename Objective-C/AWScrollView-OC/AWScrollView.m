//
//  AWScrollView.m
//  AWScrollView-OC
//
//  Created by Alex Ling on 9/11/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

#import "AWScrollView.h"

@implementation AWScrollView

-(void)setUp{
	
	[self initialize];
	
	self.upPoint = CGPointMake(self.xExtension, 0);
	self.leftPoint = CGPointMake(0, self.yExtension);
	self.rightPoint = CGPointMake(2 * self.xExtension, self.yExtension);
	self.downPoint = CGPointMake(self.xExtension, 2 * self.yExtension);
	self.centerPoint = CGPointMake(self.xExtension, self.yExtension);
	
	self.frame = CGRectMake(0, 0, self.screenWidth, self.screenHeight);
	self.contentOffset = CGPointMake(self.xExtension, self.yExtension);
	self.contentSize = CGSizeMake(self.screenWidth + 2 * self.xExtension, self.screenHeight + 2 * self.yExtension);
	self.delegate = self;
	self.showsHorizontalScrollIndicator = NO;
	self.showsVerticalScrollIndicator = NO;
	self.directionalLockEnabled = YES;
	self.scrollEnabled = NO;
	self.bounces = NO;
	
	self.mainView = [[UIView alloc] initWithFrame:CGRectMake(self.xExtension, self.yExtension, self.screenWidth, self.screenHeight)];
	self.mainView.backgroundColor = [UIColor clearColor];
	
	UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(mainViewTapped)];
	[self.mainView addGestureRecognizer:tapRec];
	
	[self addSubview:self.mainView];
	
	UIPanGestureRecognizer *panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(paned:)];
	[self addGestureRecognizer:panRec];
}

-(void)mainViewTapped{
	[self scrollTo:CGPointMake(self.xExtension, self.yExtension)];
}

-(void)paned:(UIPanGestureRecognizer *)sender{
	if (sender.state == UIGestureRecognizerStateBegan){
		ScrollDirection scrollDir = None;
		CGPoint translation = [sender translationInView:self];
		if (fabs(translation.x) > fabs(translation.y)){
			if (translation.x > 0) {
				scrollDir = Left;
			}
			else{
				scrollDir = Right;
			}
		}
		else if (fabs(translation.x) < fabs(translation.y)){
			if (translation.y > 0) {
				scrollDir = Up;
			}
			else{
				scrollDir = Down;
			}
		}
		if (scrollDir != None) {
			[self handleScrollDirection:scrollDir];
		}
	}
}

-(void)initialize{
	if (!self.xExtension){
		self.xExtension = [UIScreen mainScreen].bounds.size.width/2;
	}
	
	if (!self.yExtension){
		self.yExtension = [UIScreen mainScreen].bounds.size.height/2;
	}
	
	if (!self.screenWidth){
		self.screenWidth = [UIScreen mainScreen].bounds.size.width;
	}
	
	if (!self.screenHeight){
		self.screenHeight = [UIScreen mainScreen].bounds.size.height;
	}
	
	if (!self.transitionTime){
		self.transitionTime = 0.5;
	}
}

-(void)handleScrollDirection:(ScrollDirection)direction{
	CGPoint offset = self.contentOffset;
	
	if (direction == Up) {
		if ([self closeBetween:self.contentOffset.x and:self.xExtension]) {
			if ([self closeBetween:self.contentOffset.y and:2 * self.yExtension] || [self closeBetween:self.contentOffset.y and:self.yExtension]){
				offset = CGPointMake(self.contentOffset.x, self.contentOffset.y - self.yExtension);
			}
		}
	}
	
	else if (direction == Down) {
		if ([self closeBetween:self.contentOffset.x and:self.xExtension]) {
			if ([self closeBetween:self.contentOffset.y and:0] || [self closeBetween:self.contentOffset.y and:self.yExtension]){
				offset = CGPointMake(self.xExtension, self.contentOffset.y + self.yExtension);
			}
		}
	}
	
	else if (direction == Left) {
		if ([self closeBetween:self.contentOffset.y and:self.yExtension]) {
			if ([self closeBetween:self.contentOffset.x and:2 * self.xExtension] || [self closeBetween:self.contentOffset.x and:self.xExtension]){
				offset = CGPointMake(self.contentOffset.x - self.xExtension, self.yExtension);
			}
		}
	}
	
	else if (direction == Right) {
		if ([self closeBetween:self.contentOffset.y and:self.yExtension]) {
			if ([self closeBetween:self.contentOffset.x and:0] || [self closeBetween:self.contentOffset.x and:self.xExtension]){
				offset = CGPointMake(self.contentOffset.x + self.xExtension, self.yExtension);
			}
		}
	}
	
	[self scrollTo:offset];
}

-(void)scrollTo:(CGPoint)point{
	[UIView animateWithDuration:self.transitionTime animations:^{
		self.contentOffset = point;
	} completion: nil];
}

-(BOOL)closeBetween:(CGFloat) floatA and:(CGFloat) floatB {
	return ABS(floatA - floatB) <= 0.5;
}

@end

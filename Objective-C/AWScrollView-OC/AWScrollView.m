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
	
	self.locked = NO;
	
	if (!self.transitionTime){
		self.transitionTime = 0.5;
	}
	
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
	self.bounces = NO;
	
	self.locked = YES;
	
	self.mainView = [[UIView alloc] initWithFrame:CGRectMake(self.xExtension, self.yExtension, self.screenWidth, self.screenHeight)];
	self.mainView.backgroundColor = [UIColor clearColor];
	
	UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(mainViewTapped)];
	[self.mainView addGestureRecognizer:tapRec];
	
	[self addSubview:self.mainView];
}

-(void)mainViewTapped{
	[self scrollTo:CGPointMake(self.xExtension, self.yExtension)];
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
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	self.initialOffset = scrollView.contentOffset;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (self.locked){
		ScrollDirection direction = [self determineScrollDirection:scrollView];
		CGPoint offset = self.initialOffset;
		
		if (direction == Up) {
			if ([self closeBetween:self.initialOffset.x and:self.xExtension]) {
				if ([self closeBetween:self.initialOffset.y and:2 * self.yExtension] || [self closeBetween:self.initialOffset.y and:self.yExtension]){
					offset = CGPointMake(self.xExtension, self.initialOffset.y - self.yExtension);
				}
			}
		}
		
		else if (direction == Down) {
			if ([self closeBetween:self.initialOffset.x and:self.xExtension]) {
				if ([self closeBetween:self.initialOffset.y and:0] || [self closeBetween:self.initialOffset.y and:self.yExtension]){
					offset = CGPointMake(self.xExtension, self.initialOffset.y + self.yExtension);
				}
			}
		}
		
		else if (direction == Left) {
			if ([self closeBetween:self.initialOffset.y and:self.yExtension]) {
				if ([self closeBetween:self.initialOffset.x and:2 * self.xExtension] || [self closeBetween:self.initialOffset.x and:self.xExtension]){
					offset = CGPointMake(self.initialOffset.x - self.xExtension, self.yExtension);
				}
			}
		}
		
		else if (direction == Right) {
			if ([self closeBetween:self.initialOffset.y and:self.yExtension]) {
				if ([self closeBetween:self.initialOffset.x and:0] || [self closeBetween:self.initialOffset.x and:self.xExtension]){
					offset = CGPointMake(self.initialOffset.x + self.xExtension, self.yExtension);
				}
			}
		}
		
		[self scrollTo:offset];
	}
}

-(ScrollDirection)determineScrollDirection:(UIScrollView *)localScrollView{
	ScrollDirection scrollDir;
	if (self.initialOffset.x != localScrollView.contentOffset.x && self.initialOffset.y != localScrollView.contentOffset.y) {
		if (ABS(self.initialOffset.x - localScrollView.contentOffset.x) > ABS(self.initialOffset.y - localScrollView.contentOffset.y)){
			scrollDir = Horizontal;
		}
		else{
			scrollDir = Vertical;
		}
	}
	else{
		if (self.initialOffset.x == localScrollView.contentOffset.x) {
			scrollDir = Vertical;
		}
		else{
			scrollDir = Horizontal;
		}
	}
	if (scrollDir == Horizontal){
		if (self.initialOffset.x > localScrollView.contentOffset.x) {
			scrollDir = Left;
		}
		else if (self.initialOffset.x < localScrollView.contentOffset.x) {
			scrollDir = Right;
		}
		else {
			scrollDir = None;
		}
	}
	else{
		if (self.initialOffset.y > localScrollView.contentOffset.y) {
			scrollDir = Up;
		}
		else if (self.initialOffset.y < localScrollView.contentOffset.y){
			scrollDir = Down;
		}
		else{
			scrollDir = None;
		}
	}
	return scrollDir;
}

-(void)scrollTo:(CGPoint)point{
	self.locked = NO;
	self.scrollEnabled = NO;
	[UIView animateWithDuration:self.transitionTime animations:^{
		self.contentOffset = point;
	} completion: ^(BOOL finished){
		self.locked = YES;
		self.scrollEnabled = YES;
	}];
}

-(BOOL)closeBetween:(CGFloat) floatA and:(CGFloat) floatB {
	return ABS(floatA - floatB) <= 0.5;
}

@end

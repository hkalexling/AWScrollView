//
//  AWScrollView.swift
//  AWScrollView-Lab
//
//  Created by Alex Ling on 8/11/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

import UIKit

extension CGFloat{
	func closeTo (anotherFloat : CGFloat) -> Bool{
		return abs(self - anotherFloat) <= 0.5
	}
}

class AWScrollView: UIScrollView, UIScrollViewDelegate{
	
	var xExtension : CGFloat = UIScreen.mainScreen().bounds.size.width/2
	var yExtension : CGFloat = UIScreen.mainScreen().bounds.size.height/2
	
	let screenWidth = UIScreen.mainScreen().bounds.size.width
	let screenHeight = UIScreen.mainScreen().bounds.size.height
	
	var initialOffset : CGPoint = CGPoint()
	var locked : Bool = false
	
	var transitionTime : NSTimeInterval = 0.5
	
	var mainView : UIView!
	
	enum ScrollDirection {
		case Horizontal
		case Vertical
		
		case Up
		case Down
		
		case Left
		case Right
		
		case None
	}
	
	func setUp(){
		self.frame = CGRectMake(0, 0, self.screenWidth, self.screenHeight)
		self.contentOffset = CGPointMake(self.xExtension, self.yExtension)
		self.contentSize = CGSizeMake(self.screenWidth + 2 * self.xExtension, self.screenHeight + 2 * self.yExtension)
		self.delegate = self
		self.showsHorizontalScrollIndicator = false
		self.showsVerticalScrollIndicator = false
		self.directionalLockEnabled = true
		self.bounces = false
		
		self.locked = true
		
		self.mainView = UIView(frame: CGRectMake(self.xExtension, self.yExtension, self.screenWidth, self.screenHeight))
		self.mainView.backgroundColor = UIColor.clearColor()
		
		let tapRec = UITapGestureRecognizer(target: self, action: Selector("mainViewTapped"))
		self.mainView.addGestureRecognizer(tapRec)
		
		self.addSubview(self.mainView)
	}
	
	func mainViewTapped(){
		self.scrollTo(CGPointMake(self.xExtension, self.yExtension))
	}
	
	func scrollViewWillBeginDragging(scrollView: UIScrollView) {
		self.initialOffset = self.contentOffset
	}
	
	func scrollViewDidScroll(scrollView: UIScrollView) {
		if (self.locked){
			let direction : ScrollDirection = self.determineScrollDirection(scrollView)
			var offset = self.initialOffset
			
			if direction == .Up {
				if self.initialOffset.x.closeTo(self.xExtension) {
					if self.initialOffset.y.closeTo(2 * self.yExtension) || self.initialOffset.y.closeTo(self.yExtension) {
						offset = CGPointMake(self.xExtension, self.initialOffset.y - self.yExtension)
					}
				}
			}
				
			else if direction == .Down {
				if self.initialOffset.x.closeTo(self.xExtension) {
					if self.initialOffset.y.closeTo(0) || self.initialOffset.y.closeTo(self.yExtension) {
						offset = CGPointMake(self.xExtension, self.initialOffset.y + self.yExtension)
					}
				}
			}
				
			else if direction == .Left {
				if self.initialOffset.y.closeTo(self.yExtension) {
					if self.initialOffset.x.closeTo(2 * self.xExtension) || self.initialOffset.x.closeTo(self.xExtension) {
						offset = CGPointMake(self.initialOffset.x - self.xExtension, self.yExtension)
					}
				}
			}
				
			else if direction == .Right {
				if self.initialOffset.y.closeTo(self.yExtension) {
					if self.initialOffset.x.closeTo(0) || self.initialOffset.x.closeTo(self.xExtension) {
						offset = CGPointMake(self.initialOffset.x + self.xExtension, self.yExtension)
					}
				}
			}
			self.scrollTo(offset)
		}
	}
	
	func determineScrollDirection(localSrcollView : UIScrollView) -> ScrollDirection {
		var scrollDir : ScrollDirection
		if self.initialOffset.x != localSrcollView.contentOffset.x && self.initialOffset.y != localSrcollView.contentOffset.y {
			if abs(self.initialOffset.x - localSrcollView.contentOffset.x) > abs(self.initialOffset.y - localSrcollView.contentOffset.y){
				scrollDir = .Horizontal
			}
			else{
				scrollDir = .Vertical
			}
		}
		else{
			if self.initialOffset.x == localSrcollView.contentOffset.x {
				scrollDir = .Vertical
			}
			else{
				scrollDir = .Horizontal
			}
		}
		if scrollDir == .Horizontal{
			if self.initialOffset.x > localSrcollView.contentOffset.x {
				scrollDir = .Left
			}
			else if self.initialOffset.x < localSrcollView.contentOffset.x {
				scrollDir = .Right
			}
			else {
				scrollDir = .None
			}
		}
		else{
			if self.initialOffset.y > localSrcollView.contentOffset.y {
				scrollDir = .Up
			}
			else if self.initialOffset.y < localSrcollView.contentOffset.y{
				scrollDir = .Down
			}
			else{
				scrollDir = .None
			}
		}
		return scrollDir
	}
	
	func scrollTo(point : CGPoint){
		self.locked = false
		self.scrollEnabled = false
		UIView.animateWithDuration(self.transitionTime, animations: {
			self.contentOffset = point
			}, completion: {(finished) in
				self.locked = true
				self.scrollEnabled = true
		})
	}
}


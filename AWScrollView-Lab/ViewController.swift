//
//  ViewController.swift
//  FlatTomatoEffect
//
//  Created by Alex Ling on 8/11/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{
	
	let themeColor = UIColor.grayColor()
	
	let screenWidth = UIScreen.mainScreen().bounds.size.width
	let screenHeight = UIScreen.mainScreen().bounds.size.height
	
	var initialOffset : CGPoint = CGPoint()
	var scrollView : UIScrollView!
	var locked : Bool = false
	
	enum ScrollDirection {
		case Horizontal
		case Vertical
		
		case Up
		case Down
		
		case Left
		case Right
		
		case None
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.scrollView = UIScrollView(frame: CGRectMake(0, 0, self.screenWidth, self.screenHeight))
		self.scrollView.backgroundColor = self.themeColor
		self.scrollView.contentOffset = CGPointMake(self.screenWidth/2, self.screenHeight/2)
		self.scrollView.contentSize = CGSizeMake(2 * self.screenWidth, 2 * self.screenHeight)
		self.scrollView.delegate = self
		self.scrollView.showsHorizontalScrollIndicator = false
		self.scrollView.showsVerticalScrollIndicator = false
		self.scrollView.directionalLockEnabled = true
		self.scrollView.bounces = false
		
		self.locked = true
		
		let mainView = UIView(frame: CGRectMake(self.screenWidth/2, self.screenHeight/2, self.screenWidth, self.screenHeight))
		mainView.backgroundColor = self.themeColor
		
		let image = UIImageView(frame: CGRectMake(screenWidth/4, screenWidth/4, screenWidth/2, screenWidth/2))
		image.image = UIImage(named: "yuno")
		mainView.addSubview(image)
		
		let label = UILabel(frame: CGRectMake(0, 0.75 * screenHeight, screenWidth, 0.25 * screenHeight))
		label.backgroundColor = UIColor.clearColor()
		label.textColor = UIColor.whiteColor()
		label.textAlignment = NSTextAlignment.Center
		label.text = "This is the main view"
		label.font = UIFont.systemFontOfSize(30)
		mainView.addSubview(label)
		
		let tapRec = UITapGestureRecognizer(target: self, action: Selector("mainViewTapped"))
		mainView.addGestureRecognizer(tapRec)
		
		self.scrollView.addSubview(mainView)

		self.labelToSrollView(CGRectMake(self.screenWidth/2, self.screenHeight/4, self.screenWidth, 30), text: "Something up here 👇", fontSize: 30)
		self.labelToSrollView(CGRectMake(self.screenWidth/2, 7 * self.screenHeight/4, self.screenWidth, 30), text: "Something down here 👆", fontSize: 30)
		self.labelToSrollView(CGRectMake(0, self.screenHeight, self.screenWidth/2, 30), text: "Something left 👉", fontSize: 20)
		self.labelToSrollView(CGRectMake(1.5 * self.screenWidth, self.screenHeight, self.screenWidth/2, 30), text: "Something right 👈", fontSize: 20)
		
		self.view.addSubview(self.scrollView)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func mainViewTapped(){
		self.scrollTo(CGPointMake(self.screenWidth/2, self.screenHeight/2))
	}
	
	func scrollViewWillBeginDragging(scrollView: UIScrollView) {
		self.initialOffset = self.scrollView.contentOffset
	}
	
	func scrollViewDidScroll(scrollView: UIScrollView) {
		if (self.locked){
			let direction : ScrollDirection = self.determineScrollDirection(scrollView)
			
			if direction == .Up {
				var offset = self.initialOffset
				if self.initialOffset.x.closeTo(self.screenWidth/2) {
					if self.initialOffset.y.closeTo(self.screenHeight) || self.initialOffset.y.closeTo(self.screenHeight/2) {
						offset = CGPointMake(self.screenWidth/2, self.initialOffset.y - self.screenHeight/2)
					}
				}
				self.scrollTo(offset)
			}
				
			else if direction == .Down {
				var offset = self.initialOffset
				if self.initialOffset.x.closeTo(self.screenWidth/2) {
					if self.initialOffset.y.closeTo(0) || self.initialOffset.y.closeTo(self.screenHeight/2) {
						offset = CGPointMake(self.screenWidth/2, self.initialOffset.y + self.screenHeight/2)
						
					}
				}
				self.scrollTo(offset)
			}
				
			else if direction == .Left {
				var offset = self.initialOffset
				if self.initialOffset.y.closeTo(self.screenHeight/2) {
					if self.initialOffset.x.closeTo(self.screenWidth) || self.initialOffset.x.closeTo(self.screenWidth/2) {
						offset = CGPointMake(self.initialOffset.x - self.screenWidth/2, self.screenHeight/2)
					}
				}
				self.scrollTo(offset)
			}
				
			else if direction == .Right {
				var offset = self.initialOffset
				if self.initialOffset.y.closeTo(self.screenHeight/2) {
					if self.initialOffset.x.closeTo(0) || self.initialOffset.y.closeTo(self.screenHeight/2) {
						offset = CGPointMake(self.initialOffset.x + self.screenWidth/2, self.screenHeight/2)
					}
				}
				self.scrollTo(offset)
			}
		}
	}
	
	func determineScrollDirection(srcollView : UIScrollView) -> ScrollDirection {
		var scrollDir : ScrollDirection
		if self.initialOffset.x != scrollView.contentOffset.x && self.initialOffset.y != scrollView.contentOffset.y {
			if abs(self.initialOffset.x - scrollView.contentOffset.x) > abs(self.initialOffset.y - scrollView.contentOffset.y){
				scrollDir = .Horizontal
			}
			else{
				scrollDir = .Vertical
			}
		}
		else{
			if self.initialOffset.x == scrollView.contentOffset.x {
				scrollDir = .Vertical
			}
			else{
				scrollDir = .Horizontal
			}
		}
		if scrollDir == .Horizontal{
			if self.initialOffset.x > srcollView.contentOffset.x {
				scrollDir = .Left
			}
			else if self.initialOffset.x < scrollView.contentOffset.x {
				scrollDir = .Right
			}
			else {
				scrollDir = .None
			}
		}
		else{
			if self.initialOffset.y > scrollView.contentOffset.y {
				scrollDir = .Up
			}
			else if self.initialOffset.y < scrollView.contentOffset.y{
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
		self.scrollView.scrollEnabled = false
		UIView.animateWithDuration(0.5, animations: {
			self.scrollView.contentOffset = point
			}, completion: {(finished) in
				self.locked = true
				self.scrollView.scrollEnabled = true
		})
	}
	
	func labelToSrollView(frame : CGRect, text : String, fontSize : CGFloat){
		let label = UILabel(frame: frame)
		label.backgroundColor = UIColor.clearColor()
		label.textColor = UIColor.whiteColor()
		label.textAlignment = NSTextAlignment.Center
		label.text = text
		label.font = UIFont.systemFontOfSize(fontSize)
		self.scrollView.addSubview(label)
	}
}

extension CGFloat{
	func closeTo (anotherFloat : CGFloat) -> Bool{
		return abs(self - anotherFloat) < 1
	}
}


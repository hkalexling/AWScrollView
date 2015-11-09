//
//  TestViewController.swift
//  AWScrollView-Lab
//
//  Created by Alex Ling on 8/11/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

	@IBOutlet weak var awScrollView: AWScrollView!
	
	let screenWidth = UIScreen.mainScreen().bounds.size.width
	let screenHeight = UIScreen.mainScreen().bounds.size.height
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.awScrollView.backgroundColor = UIColor.grayColor()
		
        self.awScrollView.setUp()
		
		self.customize()
    }
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
	func customize(){
		
		let image = UIImageView(frame: CGRectMake(self.screenWidth - self.screenHeight/8, self.screenHeight/8, self.screenHeight/4, self.screenHeight/4))
		image.image = UIImage(named: "yuno")
		self.awScrollView.addSubview(image)
		
		let dogeImage = UIImageView(frame: CGRectMake(self.screenWidth - self.screenHeight/8, self.screenHeight * 15/8 - self.screenHeight/4, self.screenHeight/4, self.screenHeight/4))
		dogeImage.image = UIImage(named: "doge")
		self.awScrollView.addSubview(dogeImage)

		self.labelToSrollView(CGRectMake(self.screenWidth - self.screenHeight/8, self.screenHeight * 3/8 + 30, self.screenHeight/4, 30), text: "By @hkalexling", fontSize: 17)
		self.labelToSrollView(CGRectMake(0, self.screenHeight - 50, self.screenWidth/2, 100), text: "Open source with WTFPL license", fontSize: 17)
		self.labelToSrollView(CGRectMake(self.screenWidth * 1.5, self.screenHeight - 50, self.screenWidth/2, 100), text: "Pull requests are most welcome :)", fontSize: 17)
		
		self.labelToSrollView(CGRectMake(self.screenWidth/2 + 50, 2 * self.screenHeight - 60, self.screenHeight/4, 30), text: "Wow", fontSize: 17)
		self.labelToSrollView(CGRectMake(self.screenWidth + 50, 2 * self.screenHeight - 130, self.screenHeight/4, 30), text: "So ScollView", fontSize: 17)
		self.labelToSrollView(CGRectMake(self.screenWidth - 220, 2 * self.screenHeight - 200, self.screenHeight/4, 30), text: "Much fancy", fontSize: 17)
		
		self.buttonToMainView(CGPointMake(self.screenWidth/2, self.screenHeight/2 - 50), selectorString: "top", color: UIColor.whiteColor())
		self.buttonToMainView(CGPointMake(self.screenWidth/2 - 50, self.screenHeight/2), selectorString: "left", color: UIColor.whiteColor())
		self.buttonToMainView(CGPointMake(self.screenWidth/2 + 50, self.screenHeight/2), selectorString: "right", color: UIColor.whiteColor())
		self.buttonToMainView(CGPointMake(self.screenWidth/2, self.screenHeight/2 + 50), selectorString: "down", color: UIColor.whiteColor())
	}
	
	func top(){
		self.awScrollView.scrollTo(self.awScrollView.upPoint)
	}
	
	func left(){
		self.awScrollView.scrollTo(self.awScrollView.leftPoint)
	}
	
	func right(){
		self.awScrollView.scrollTo(self.awScrollView.rightPoint)
	}
	
	func down(){
		self.awScrollView.scrollTo(self.awScrollView.downPoint)
	}
	
	func labelToSrollView(frame : CGRect, text : String, fontSize : CGFloat){
		let label = UILabel(frame: frame)
		label.backgroundColor = UIColor.clearColor()
		label.textColor = UIColor.whiteColor()
		label.textAlignment = NSTextAlignment.Center
		label.text = text
		label.lineBreakMode = .ByWordWrapping
		label.numberOfLines = 0
		label.font = UIFont.systemFontOfSize(fontSize)
		self.awScrollView.addSubview(label)
	}
	
	func buttonToMainView(position : CGPoint, selectorString : String, color : UIColor){
		let button = UIButton(frame: CGRectMake(position.x - 15, position.y - 15, 30, 30))
		button.layer.cornerRadius = button.frame.width/2
		button.clipsToBounds = true
		button.addTarget(self, action: Selector(selectorString), forControlEvents: .TouchDown)
		button.backgroundColor = color
		button.layer.masksToBounds = false
		button.layer.shadowOffset = CGSize(width: 8, height: 8)
		button.layer.shadowColor = UIColor.darkGrayColor().CGColor
		button.layer.shadowOpacity = 1
		self.awScrollView.mainView.addSubview(button)
	}
}

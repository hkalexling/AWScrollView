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
		
		//Set up AWScrollView
        self.awScrollView.setUp()
		self.awScrollView.backgroundColor = UIColor.blackColor()
		
		//Optional
		self.customize()
    }
	
	func customize(){
		let image = UIImageView(frame: CGRectMake(screenWidth/4, screenWidth/4, screenWidth/2, screenWidth/2))
		image.image = UIImage(named: "yuno")
		self.awScrollView.mainView.addSubview(image)
		
		let label = UILabel(frame: CGRectMake(0, 0.75 * screenHeight, screenWidth, 0.25 * screenHeight))
		label.backgroundColor = UIColor.clearColor()
		label.textColor = UIColor.whiteColor()
		label.textAlignment = NSTextAlignment.Center
		label.text = "This is the main view"
		label.font = UIFont.systemFontOfSize(30)
		self.awScrollView.mainView.addSubview(label)
		
		self.labelToSrollView(CGRectMake(self.screenWidth/2, self.screenHeight/4, self.screenWidth, 30), text: "Something up here 👇", fontSize: 30)
		self.labelToSrollView(CGRectMake(self.screenWidth/2, 7 * self.screenHeight/4, self.screenWidth, 30), text: "Something down here 👆", fontSize: 30)
		self.labelToSrollView(CGRectMake(0, self.screenHeight, self.screenWidth/2, 30), text: "Something left 👉", fontSize: 20)
		self.labelToSrollView(CGRectMake(1.5 * self.screenWidth, self.screenHeight, self.screenWidth/2, 30), text: "Something right 👈", fontSize: 20)
	}
	
	func labelToSrollView(frame : CGRect, text : String, fontSize : CGFloat){
		let label = UILabel(frame: frame)
		label.backgroundColor = UIColor.clearColor()
		label.textColor = UIColor.whiteColor()
		label.textAlignment = NSTextAlignment.Center
		label.text = text
		label.font = UIFont.systemFontOfSize(fontSize)
		self.awScrollView.addSubview(label)
	}
}

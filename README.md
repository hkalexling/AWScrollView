# AWScrollView
A modified UIScrollView 

The design was inspired by the app [Flat Tomato](https://itunes.apple.com/us/app/flat-tomato-time-management/id719462746?mt=8)

Implemented purely in Swift 2 and all UI elements were setup programmingly.

###Demo GIF:

<img src="https://github.com/hkalexling/AWScrollView-Lab/blob/master/AWScrollView.gif" width="350">

###Installation:

Simplily drag and drog the [AWScrollView.swift](https://github.com/hkalexling/AWScrollView/blob/master/AWScrollView/AWScrollView.swift) file into your project

###Usage:

- In storyboard, drag and drog in a `UIScrollView` into a viewController
- Set the class of the `UIScrollView` to be `AWScrollView`
- Connect the IBOutlet of `AWScrollView` to your view controller class file
- In your `viewDidLoad`, do the following:

        override func viewDidLoad() {
            super.viewDidLoad()
		
		    //Set up AWScrollView
            self.awScrollView.setUp()
            
            //Set the backgroud color to whatever you want
		    self.awScrollView.backgroundColor = UIColor.blackColor()
		
		    //Add other UIView to AWScrollView and its mainView here
		    //eg:
		    self.awScrollView.addSubview(self.yourImageView)
		    self.awScrollView.mainView.addSubview(self.yourLabel)
		    
		    //Customize the duration of transition animation if you want
		    self.awScrollView.transitionTime = 0.8
        }

###Todo:

- [X] Create a reusable `AWScrollView` class
- [ ] Clean the code
- [ ] Customisable content size
- [ ] Make the demo app looks better
- [ ] Objective-C version

###One More Thing

Just FYI, `AW` simplily means "awesome" xD



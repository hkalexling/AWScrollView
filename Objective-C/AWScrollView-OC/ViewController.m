//
//  ViewController.m
//  AWScrollView-OC
//
//  Created by Alex Ling on 9/11/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

#import "ViewController.h"
#import "AWScrollView.h"
#import <UIKit/UIKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet AWScrollView *awScrollView;

@property CGFloat screenWidth;
@property CGFloat screenHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.screenWidth = [UIScreen mainScreen].bounds.size.width;
	self.screenHeight = [UIScreen mainScreen].bounds.size.height;
	
	self.awScrollView.mainView.backgroundColor = [UIColor whiteColor];
	
	self.awScrollView.backgroundColor = [UIColor grayColor];
	[self.awScrollView setUp];
	
	[self customize];
}

- (BOOL)prefersStatusBarHidden{
	return YES;
}

- (void)customize{
	UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(self.screenWidth - self.screenHeight/8, self.screenHeight/8, self.screenHeight/4, self.screenHeight/4)];
	image.image = [UIImage imageNamed:@"yuno"];
	[self.awScrollView addSubview:image];
	
	UIImageView *dogeImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.screenWidth - self.screenHeight/8, self.screenHeight * 15/8 - self.screenHeight/4, self.screenHeight/4, self.screenHeight/4)];
	dogeImage.image = [UIImage imageNamed:@"doge"];
	[self.awScrollView addSubview:dogeImage];
	
	[self labelToScrollView:CGRectMake(self.screenWidth - self.screenHeight/8, self.screenHeight * 3/8 + 30, self.screenHeight/4, 30) text:@"By @hkalexling" fontSize:17];
	[self labelToScrollView:CGRectMake(0, self.screenHeight - 50, self.screenWidth/2, 100) text:@"Open source with WTFPL license" fontSize:17];
	[self labelToScrollView:CGRectMake(self.screenWidth * 1.5, self.screenHeight - 50, self.screenWidth/2, 100) text:@"Pull requests are most welcome :)" fontSize:17];
	
	[self labelToScrollView:CGRectMake(self.screenWidth/2 + 50, 2 * self.screenHeight - 60, self.screenHeight/4, 30) text:@"Wow" fontSize:17];
	[self labelToScrollView:CGRectMake(self.screenWidth + 50, 2 * self.screenHeight - 130, self.screenHeight/4, 30) text:@"So ScollView" fontSize:17];
	[self labelToScrollView:CGRectMake(self.screenWidth - 220, 2 * self.screenHeight - 200, self.screenHeight/4, 30) text:@"Much fancy" fontSize:17];
	
	[self buttonToMainViewWith:CGPointMake(self.screenWidth/2, self.screenHeight/2 - 50) selector:@"top" color:[UIColor whiteColor]];
	[self buttonToMainViewWith:CGPointMake(self.screenWidth/2 - 50, self.screenHeight/2) selector:@"left" color:[UIColor whiteColor]];
	[self buttonToMainViewWith:CGPointMake(self.screenWidth/2 + 50, self.screenHeight/2) selector:@"right" color:[UIColor whiteColor]];
	[self buttonToMainViewWith:CGPointMake(self.screenWidth/2, self.screenHeight/2 + 50) selector:@"down" color:[UIColor whiteColor]];
}

-(void)top{
	[self.awScrollView scrollTo:self.awScrollView.upPoint];
}

-(void)left{
	[self.awScrollView scrollTo:self.awScrollView.leftPoint];
}

-(void)right{
	[self.awScrollView scrollTo:self.awScrollView.rightPoint];
}

-(void)down{
	[self.awScrollView scrollTo:self.awScrollView.downPoint];
}

-(void) labelToScrollView:(CGRect) frame  text:(NSString*)text fontSize:(CGFloat)fontSize{
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.textAlignment = NSTextAlignmentCenter;
	label.text = text;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	label.numberOfLines = 0;
	label.font = [UIFont systemFontOfSize:fontSize];
	[self.awScrollView addSubview:label];
}

-(void)buttonToMainViewWith:(CGPoint) position selector:(NSString*) selectorString color:(UIColor*) color{
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(position.x - 15, position.y - 15, 30, 30)];
	button.layer.cornerRadius = 15;
	button.clipsToBounds = YES;
	[button addTarget:self action:NSSelectorFromString(selectorString) forControlEvents:UIControlEventTouchDown];
	button.backgroundColor = color;
	button.layer.masksToBounds = NO;
	button.layer.shadowOffset = CGSizeMake(8, 8);
	button.layer.shadowColor = [UIColor darkGrayColor].CGColor;
	button.layer.shadowOpacity = 1;
	[self.awScrollView.mainView addSubview:button];
}
@end

//
//  MainView.m
//  FootBall3
//
//  Created by 王登鹏 on 15/11/4.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import "MainTabBar.h"

@interface MainTabBar ()
@end
@implementation MainTabBar
- (void)viewDidLoad {
	[super viewDidLoad];
    
  
    
//	[self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    
	UIStoryboard *secondStoryBoard = nil;
	UIViewController *door = nil;
	secondStoryBoard = [UIStoryboard storyboardWithName:@"HomeViewController" bundle:nil];
	UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
	[self addChildViewController:v];
	secondStoryBoard = [UIStoryboard storyboardWithName:@"MessageViewController" bundle:nil];
	v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"MessageViewController"];
	[self addChildViewController:v];
	secondStoryBoard = [UIStoryboard storyboardWithName:@"ConsulateViewController" bundle:nil];
	v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ConsulateViewController"];
	[self addChildViewController:v];
    secondStoryBoard = [UIStoryboard storyboardWithName:@"MyViewController" bundle:nil];
    v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"MyViewController"];
    [self addChildViewController:v];
    secondStoryBoard = [UIStoryboard storyboardWithName:@"CentreViewController" bundle:nil];
    v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CentreViewController"];
    [self addChildViewController:v];
	secondStoryBoard = [UIStoryboard storyboardWithName:@"BottomViewController" bundle:nil];
	door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"BottomViewController"];
	[self addChildViewController:door];
	UIView *vv = [[door.view subviews] objectAtIndex:0];
	vv.tag = 100;
	[self.view addSubview:vv];
	NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:vv attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
	NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:vv attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
	NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:vv attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
	[self.view addConstraint:c1];
	[self.view addConstraint:c2];
	[self.view addConstraint:c3];
	[self.tabBarController setSelectedIndex:1];
    
}



- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}



@end

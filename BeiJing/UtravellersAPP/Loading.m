//
//  Loading.m
//  FootBall3_B
//
//  Created by 王登鹏 on 15/12/23.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import "Loading.h"
@interface Loading ()
@end
@implementation Loading
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self.navigationController.topViewController.navigationItem.rightBarButtonItem setEnabled:NO];
	[self.navigationController.topViewController.navigationItem.leftBarButtonItem setEnabled:NO];
	UIView *v = [self.tabBarController.view viewWithTag:100];
	for (UIView *vv in [v subviews]) {
		if ([vv isKindOfClass:[UIButton class]]) {
			UIButton *b = (UIButton *)vv;
			[b setEnabled:NO];
		}
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.navigationController.topViewController.navigationItem.rightBarButtonItem setEnabled:YES];
	[self.navigationController.topViewController.navigationItem.leftBarButtonItem setEnabled:YES];
    UIView *v = [self.tabBarController.view viewWithTag:100];
    for (UIView *vv in [v subviews]) {
        if ([vv isKindOfClass:[UIButton class]]) {
            UIButton *b = (UIButton *)vv;
            [b setEnabled:NO];
        }
    }
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
   #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */
@end

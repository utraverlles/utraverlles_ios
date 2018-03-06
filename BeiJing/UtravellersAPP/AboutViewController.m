//
//  AboutViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/8.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "AboutViewController.h"
#import "MsgView7.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//推荐好友
- (IBAction)recommendAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView7" bundle:nil];
    MsgView7 *msgView = (MsgView7*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView7"];
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}
@end

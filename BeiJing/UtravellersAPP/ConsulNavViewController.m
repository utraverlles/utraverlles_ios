//
//  ConsulNavViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/11.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ConsulNavViewController.h"

@interface ConsulNavViewController ()

@end

@implementation ConsulNavViewController

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

@end

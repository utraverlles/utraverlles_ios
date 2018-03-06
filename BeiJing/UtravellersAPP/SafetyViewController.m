//
//  SafetyViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/29.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "SafetyViewController.h"

@interface SafetyViewController ()

@end

@implementation SafetyViewController

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

//修改密码
- (IBAction)passwordAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"PasswordViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PasswordViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

//绑定手机
- (IBAction)phoneAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"PhoneViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PhoneViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

//绑定邮箱
- (IBAction)emailAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"EmailViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"EmailViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}
@end

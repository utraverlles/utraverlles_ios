//
//  PhoneViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/29.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "PhoneViewController.h"

@interface PhoneViewController ()

@end

@implementation PhoneViewController

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

- (IBAction)next:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Phone2ViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"Phone2ViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

//申诉
- (IBAction)RepresentationsAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"RepresentationsViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"RepresentationsViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}
@end

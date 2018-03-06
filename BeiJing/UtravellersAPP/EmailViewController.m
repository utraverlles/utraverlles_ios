//
//  EmailViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/30.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbLable1;


@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString* content = @"You will receive an e-mail containing 1551@qq.com 6 digits test Mail card code";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
    //    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, content.length)];
    NSRange start = [content rangeOfString:@"1551@qq.com"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0 / 255 green:185.0 / 255 blue:0.0 / 255 alpha:1.0] range:start];
    _lbLable1.attributedText = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)next:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Email2ViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"Email2ViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}
@end

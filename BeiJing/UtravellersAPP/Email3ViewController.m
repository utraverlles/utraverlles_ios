//
//  Email3ViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/30.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "Email3ViewController.h"

@interface Email3ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbLable1;

@end

@implementation Email3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString* content = @"You will receive an e-mail containing pbrown@fadeo.gov 6 digits test Mail card code";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
    //    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, content.length)];
    NSRange start = [content rangeOfString:@"pbrown@fadeo.gov"];
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

- (IBAction)ok:(id)sender {
    
}
@end

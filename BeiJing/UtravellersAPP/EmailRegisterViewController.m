//
//  EmailRegisterViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/10.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "EmailRegisterViewController.h"

@interface EmailRegisterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbLable1;
@property (weak, nonatomic) IBOutlet UIImageView *ivSel;

@property (nonatomic, assign) BOOL selected;
@end

@implementation EmailRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString* content = @"Registration is deemed to agree to use APP agreement";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
    //    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, content.length)];
    NSRange start = [content rangeOfString:@"use APP agreement"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0 / 255 green:185.0 / 255 blue:0.0 / 255 alpha:1.0] range:start];
    _lbLable1.attributedText = str;
    
    self.selected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)loginAction:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"PhoneRegisterViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PhoneRegisterViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}


- (IBAction)buttonCallBack:(UIButton *)sender {
    
    [self setSelected:_selected ? NO : YES];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        [_ivSel setHidden:NO];
    }
    else {
        [_ivSel setHidden:YES];
    }
}

@end

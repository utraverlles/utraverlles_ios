//
//  ShowImageView.m
//  DoctorApp
//
//  Created by LuNian on 16/2/16.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ShowImageView.h"

@interface ShowImageView ()

@end

@implementation ShowImageView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    _iv_BigImage.image = _img;
   
    NSLayoutConstraint *c0 = [NSLayoutConstraint constraintWithItem:_iv_BigImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_img.size.width/2];
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:_iv_BigImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_img.size.height/2];
    [_iv_BigImage addConstraint:c0];
    [_iv_BigImage addConstraint:c1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back_Click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

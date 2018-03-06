//
//  EditGroupCell.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/21.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "EditGroupCell.h"
#import "ManageGroupViewController.h"

@implementation EditGroupCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)buttonCallBack:(UIButton *)sender {
    
    _bgView.alpha= 1.0f;
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatCount:1];
    _bgView.alpha= 0.0f;
    [UIView commitAnimations];
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ManageGroupViewController" bundle:nil];
    ManageGroupViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ManageGroupViewController"];  //
    door.delegate = self;
    door.m_dict = _m_dict;
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
}


#pragma ManageGroupDelegate
- (void)editGroupSuccess:(NSString*)pr {
    _lbName.text = pr;
}

@end

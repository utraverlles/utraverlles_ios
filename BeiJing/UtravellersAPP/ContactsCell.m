//
//  ContactsCell.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/26.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ContactsCell.h"
#import "FootBall4_8.h"
#import "OthersViewController.h"

@implementation ContactsCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)chatAction:(UIButton *)sender {
    
    [_delegate chatCallBack];
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FootBall4_8" bundle:nil];
    FootBall4_8 *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FootBall4_8"];  //
    door.m_titleName = _lbName.text;
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
}

- (IBAction)othersAction:(id)sender{
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"OthersViewController" bundle:nil];
    OthersViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"OthersViewController"];  //
    door.m_dict = _m_dict;
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
}
@end

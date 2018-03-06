//
//  FocusCell.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/9.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "FansCell.h"
#import "MsgView9.h"
#import "OthersViewController.h"

@implementation FansCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)focusAction:(UIButton *)sender {
    
    if (_selected) {
        
    }else{
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView9" bundle:nil];
        MsgView9 *msgView = (MsgView9*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView9"];
        msgView.delegate = self;
        msgView.m_titleName = _lbName.text;
        [_superViewCon addChildViewController:msgView];
        [_superViewCon.view addSubview:msgView.view];
    }
}


- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
//        [_ivSel setHidden:NO];
        [_ivUnSel setHidden:YES];
    }
    else {
//        [_ivSel setHidden:YES];
        [_ivUnSel setHidden:NO];
    }
}

- (IBAction)othersAction:(id)sender{
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"OthersViewController" bundle:nil];
    OthersViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"OthersViewController"];  //
    door.m_dict = _m_dict;
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
}

#pragma MsgView9Delegate
- (void)addSuccess{
    self.selected = YES;
}

@end

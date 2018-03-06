//
//  FocusCell.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/9.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "FocusCell.h"
#import "MsgView8.h"
#import "FocusGroup.h"
#import "OthersViewController.h"

@implementation FocusCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)focusAction:(UIButton *)sender {
    
    if (_selected) {
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView8" bundle:nil];
        MsgView8 *msgView = (MsgView8*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView8"];
        msgView.delegate = self;
        [_superViewCon addChildViewController:msgView];
        [_superViewCon.view addSubview:msgView.view];
    }else{
        
    }
}


- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        [_ivSel setHidden:NO];
        [_ivUnSel setHidden:YES];
    }
    else {
        [_ivSel setHidden:YES];
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

#pragma MsgView8Delegate
- (void)chatCallBack {
    
}

- (void)groupCallBack {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FocusGroup" bundle:nil];
    FocusGroup *msgView = (FocusGroup*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"FocusGroup"];
    msgView.delegate = self;
    [_superViewCon addChildViewController:msgView];
    [_superViewCon.view addSubview:msgView.view];
}

- (void)unfollowCallBack {
    
}

#pragma FocusGroupDelegate
- (void)selectGroup:(NSString*)pr {
    
    NSLog(@"pr == %@", pr);
}

@end

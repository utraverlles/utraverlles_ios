//
//  ManageGroupCell.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/22.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ManageGroupCell.h"

@implementation ManageGroupCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)buttonCallBack:(UIButton *)sender {
   
    [_delegate delGroupCell:self];
//    [self setBSel:_bSel ? NO : YES];
}

- (void)setBSel:(BOOL)selected {
    _bSel = selected;
    if (_bSel) {
        [_ivDel setHidden:NO];
    }
    else {
        [_ivDel setHidden:YES];
    }
}
@end

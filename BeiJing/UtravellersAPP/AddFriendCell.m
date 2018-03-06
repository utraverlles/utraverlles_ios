//
//  AddBuddyCell.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/22.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "AddFriendCell.h"

@implementation AddFriendCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)buttonCallBack:(UIButton *)sender {
    
    [self setSelected:_selected ? NO : YES];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        [_ivSel setHidden:NO];
//        _m_cm.sel = @"1";
    }
    else {
        [_ivSel setHidden:YES];
//        _m_cm.sel = @"0";
    }
}
@end

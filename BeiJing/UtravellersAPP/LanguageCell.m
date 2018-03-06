//
//  LanguageCell.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/29.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "LanguageCell.h"

@implementation LanguageCell
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
    }
    else {
        [_ivSel setHidden:YES];
    }
}

@end

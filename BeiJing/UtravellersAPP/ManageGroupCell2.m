//
//  ManageGroupCell.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/22.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ManageGroupCell2.h"

@implementation ManageGroupCell2
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)buttonCallBack:(UIButton *)sender {
    
    NSInteger sid = sender.tag;
    if (sid == -11) {
        [_delegate addCallBack];
    }else if (sid == -22){
        [_delegate delCallBack];
    }else if (sid == -33){
        [_delegate moreCallBack];
    }else if (sid == -44){
        [_delegate lessCallBack];
    }
}
@end

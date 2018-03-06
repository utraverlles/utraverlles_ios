//
//  SearchCellView.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/12.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "SearchCellView.h"
#import "FootBall4_8.h"

@implementation SearchCellView
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)followAction:(UIButton *)sender {
    
    
}

- (IBAction)chatAction:(UIButton *)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FootBall4_8" bundle:nil];
    FootBall4_8 *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FootBall4_8"];  //
    door.m_titleName = _lbName.text;
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
}
@end

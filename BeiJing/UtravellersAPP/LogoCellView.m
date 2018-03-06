//
//  LogoCellView.m
//  UtravellersAPP
//
//  Created by LuNian on 16/11/10.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "LogoCellView.h"
#import "OthersViewController.h"

@implementation LogoCellView
- (void)awakeFromNib {
    [super awakeFromNib];
}


- (IBAction)othersAction:(id)sender{
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"OthersViewController" bundle:nil];
    OthersViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"OthersViewController"];  //
    door.m_dict = _m_dict;
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
}
@end

//
//  FootBall4_8_Cell.m
//  FootBall3
//
//  Created by 王登鹏 on 15/10/28.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import "FootBall4_8_Cell.h"
#import "OthersViewController.h"

@interface FootBall4_8_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *labelView;
- (IBAction)buttonCallBack:(UIButton *)sender;
@end
@implementation FootBall4_8_Cell
- (void)awakeFromNib {
	[super awakeFromNib];
}

- (IBAction)buttonCallBack:(UIButton *)sender {
 
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"OthersViewController" bundle:nil];
    OthersViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"OthersViewController"];  //
//    door.m_dict = _m_dict;
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
    
}

- (void)setContent:(NSString *)content {
	_content = content;
	[_labelView setText:content];
}

@end

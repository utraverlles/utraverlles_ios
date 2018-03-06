//
//  CommentsCellView.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/8.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "CommentsCellView.h"
#import "NoteDetailViewController.h"

@implementation CommentsCellView
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)buttonCallBack:(UIButton *)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NoteDetailViewController" bundle:nil];
    NoteDetailViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"NoteDetailViewController"];  //
    door.m_dict = _m_dict;
    door.m_bbsID = [_m_dict objectForKey:@"uid"];
    door.imageArray = [[NSArray alloc] init];
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
}
@end

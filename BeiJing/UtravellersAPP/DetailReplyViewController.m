//
//  DetailReplyViewController.m
//  SaleApp
//
//  Created by LuNian on 16/5/25.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "DetailReplyViewController.h"
#import "ReplyCommentViewController.h"
//extern NSMutableDictionary *User_Dict;

@interface DetailReplyViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation DetailReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendAction:(id)sender {
    
//    if ([[_m_dict objectForKey:@"userID"] isEqual:[User_Dict objectForKey:@"id"]]) {
//        return;
//    }
    _bgView.alpha= 1.0f;
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatCount:1];
    _bgView.alpha= 0.0f;
    [UIView commitAnimations];
    
//    _listY = _bgView.frame.size.height+5;
//    [_delegate sendReply:self name:[_m_dict objectForKey:@"user_name"] sid:[_m_dict objectForKey:@"userID"]];
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ReplyCommentViewController" bundle:nil];
    ReplyCommentViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ReplyCommentViewController"];  //
    door.delegate = self;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

#pragma mark--
#pragma mark--ReplyCommentViewDelegate
- (void)submitSuccess:(NSString*)content
{
    _listY = _bgView.frame.size.height+5;
    [_delegate sendReply:self name:[_m_dict objectForKey:@"user_name"] sid:[_m_dict objectForKey:@"userID"] content:content];
}
@end

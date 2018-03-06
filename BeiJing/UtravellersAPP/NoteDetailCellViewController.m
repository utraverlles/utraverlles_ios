//
//  TopicDetailCellViewController.m
//  SaleApp
//
//  Created by LuNian on 16/5/9.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "NoteDetailCellViewController.h"
#import "DetailReplyViewController.h"
//#import "UserMenu.h"
#import "ReplyCommentViewController.h"

//extern NSMutableDictionary *User_Dict;

@interface NoteDetailCellViewController ()
@property (weak, nonatomic) IBOutlet UIView *superView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation NoteDetailCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray* childList = [_m_dict objectForKey:@"childList"];
    if (childList) {
        [self createData:childList];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData:(NSDictionary *)dict postID:(NSInteger)postID error:(NSError *)error {
    if (error != nil) {
        return;
    }
    if ([[dict objectForKey:@"code"] intValue] != 0) {
        NSLog(@"error = %@", [dict objectForKey:@"info"]);
        return;
    }
    
    if (postID == 6){
//        _lbCount.text = [NSString stringWithFormat:@"%d", [_lbCount.text intValue]+1];
        [_ivZan setHidden:NO];
        [_btZan setEnabled:NO];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"点赞成功";
        hud.labelFont = [UIFont systemFontOfSize:13];
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
}

- (void)createData:(NSArray *)dataArray {
    if ([dataArray count] == 0) {
        return;
    }
    
//    [_lbXian setHidden:NO];
    UIView *view = nil;
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    view = _listView;
    UIView *s_v = nil;
    if ([[view subviews] count] > 0) {
        s_v = [[view subviews] lastObject];
    }
    else {
        NSArray *a = [view constraints];
        [view removeConstraints:a];
    }
    
    for (int i = 0; i < [dataArray count]; i++) {
        NSDictionary *d = [dataArray objectAtIndex:i];
        NSString* sid = [d objectForKey:@"id"];
        NSString* user_name = [d objectForKey:@"user_name"];
        NSString* userID = [d objectForKey:@"userID"];
        NSString* parent_name = [d objectForKey:@"to_user_name"];
        NSString* parentID = [d objectForKey:@"to_user_id"];
        NSString* content = [d objectForKey:@"content"];
        content = [NSString stringWithFormat:@"%@回复%@:%@", user_name, parent_name, content];
        NSString* add_time = [d objectForKey:@"add_time"];
        NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[add_time floatValue]/1];
        
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NoteDetailViewController" bundle:nil];
        DetailReplyViewController *v = (DetailReplyViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"DetailReplyViewController"];
        [self addChildViewController:v];
        UIView *vv = [[v.view subviews] objectAtIndex:0];
        [view addSubview:vv];
        [viewArray addObject:vv];
        
        v.selfView = vv;
        v.delegate = self;
        v.superViewCon = self;
        v.m_dict = d;
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
        NSRange start = [content rangeOfString:user_name];
        NSRange search;
        search.location = start.location + [user_name length];
        search.length = [content length] - start.location - [user_name length];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:126.0 / 255 green:142.0 / 255 blue:174.0 / 255 alpha:1.0] range:start];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:126.0 / 255 green:142.0 / 255 blue:174.0 / 255 alpha:1.0]
                    range:[content rangeOfString:parent_name options:NSLiteralSearch range:search]];
        v.lbContent.attributedText = str;
        
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            //X居中
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
            //等宽
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
            //距离上一个的高度
            NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
            NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            c4.identifier = @"end";
            [view addConstraint:c1];
            [view addConstraint:c2];
            [view addConstraint:c3];
            [view addConstraint:c4];
            s_v = v;
            k++;
            continue;
        }
        //X居中
        NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        //等宽
        NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        //距离上一个的高度
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        if (s_v != nil) {
            //添加
            c3 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        }
        [view addConstraint:c1];
        [view addConstraint:c2];
        [view addConstraint:c3];
        s_v = v;
        k++;
    }
    NSLayoutConstraint *c1 = [self findLayout:@"end" superView:view];
    [view removeConstraint:c1];
    //让SUPERVIEW的底 = 最后一个VIEW的底
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    c3.identifier = @"end";
    [view addConstraint:c3];
}

- (NSLayoutConstraint *)findLayout:(NSString *)nameID superView:(UIView *)superView {
    NSArray *a = [superView constraints];
    for (NSLayoutConstraint *aa in a) {
        if ([aa.identifier isEqualToString:nameID]) {
            return aa;
        }
    }
    return nil;
}

- (NSString *)compareCurrentTime:(NSDate *)compareDate {
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if ((temp = timeInterval / 60) < 60) {
        result = [NSString stringWithFormat:@"%ld分钟前", temp];
    }
    else if ((temp = temp / 60) < 24) {
        result = [NSString stringWithFormat:@"%ld小时前", temp];
    }
    else if ((temp = temp / 24) < 30) {
        result = [NSString stringWithFormat:@"%ld天前", temp];
    }
    else if ((temp = temp / 30) < 12) {
        result = [NSString stringWithFormat:@"%ld月前", temp];
    }
    else {
        temp = temp / 12;
        result = [NSString stringWithFormat:@"%ld年前", temp];
    }
    return result;
}

- (IBAction)sendAction:(id)sender {
    
//    if ([[_m_dict objectForKey:@"userID"] isEqual:[User_Dict objectForKey:@"id"]]) {
//        return;
//    }
    
//    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"UserMenu" bundle:nil];
//    UserMenu *msgView = (UserMenu*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"UserMenu"];
//    msgView.delegate = self;
//    [_superViewCon addChildViewController:msgView];
//    [_superView addSubview:msgView.view];
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ReplyCommentViewController" bundle:nil];
    ReplyCommentViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ReplyCommentViewController"];  //
    door.delegate = self;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];

    
    _bgView.alpha= 1.0f;
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatCount:1];
    _bgView.alpha= 0.0f;
    [UIView commitAnimations];
    
//    _listY = _listView.frame.origin.y;
//    [_delegate openTextView:self parentName:[_m_dict objectForKey:@"user_name"] parentID:[_m_dict objectForKey:@"userID"] commentID:[_m_dict objectForKey:@"id"]];
}

- (IBAction)zanAction:(id)sender{
    
//    NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//    [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//    [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//    [parameters_ setObject:[_m_dict objectForKey:@"id"] forKey:@"commentID"];
//    
//    WebPostClass *web = [[WebPostClass alloc] init];
//    web.postID = 6;
//    web.showLoadingBool = NO;
//    web.delegate = self;
//    [web getHttpData:@"bbs/addCommentLike" parameters:parameters_];
}

#pragma mark--
#pragma mark--DetailReplyDelegate
- (void)sendReply:(UIViewController*)vc name:(NSString*)name sid:(NSString*)sid
{
    DetailReplyViewController *v = vc;
    _listY = _listView.frame.origin.y + v.selfView.frame.origin.y + v.listY;
    [_delegate openTextView:self parentName:name parentID:sid commentID:[_m_dict objectForKey:@"id"]];
}

- (void)sendReply:(UIViewController*)vc name:(NSString*)name sid:(NSString*)sid content:(NSString*)content
{
    DetailReplyViewController *v = vc;
    _listY = _listView.frame.origin.y + v.selfView.frame.origin.y + v.listY;
    [_delegate sendTextView:self parentName:name parentID:sid commentID:[_m_dict objectForKey:@"id"] content:content];
}

#pragma mark--
#pragma mark--ReplyCommentViewDelegate
- (void)submitSuccess:(NSString*)content
{
    _listY = _listView.frame.origin.y;
    [_delegate sendTextView:self parentName:[_m_dict objectForKey:@"user_name"] parentID:[_m_dict objectForKey:@"userID"] commentID:[_m_dict objectForKey:@"id"] content:content];
}

#pragma mark--
#pragma mark--UserMenuDelegate
- (void)getUserSelect:(NSInteger)sel
{
    switch (sel) {
        case 1://回复
        {
            _listY = _listView.frame.origin.y;
            [_delegate openTextView:self parentName:[_m_dict objectForKey:@"user_name"] parentID:[_m_dict objectForKey:@"userID"] commentID:[_m_dict objectForKey:@"id"]];
        }
            break;
        case 2://举报
        {
            
        }
            break;
        default:
            break;
    }
    
}


@end

//
//  TopicDetailCellViewController.m
//  SaleApp
//
//  Created by LuNian on 16/5/9.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "NoteDetailCell2ViewController.h"
#import "NoteReplyViewController.h"
#import "WebPostClass.h"

//extern NSMutableDictionary *User_Dict;

@interface NoteDetailCell2ViewController ()
@property (weak, nonatomic) IBOutlet UIView *superView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *ivZan;

@end

@implementation NoteDetailCell2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
       
        _lbCount.text = [NSString stringWithFormat:@"%d", [_lbCount.text intValue]+1];
        [_btZan setEnabled:NO];
        
        NSMutableDictionary* udict = _m_dict.mutableCopy;
        [udict setObject:_lbCount.text forKey:@"likeCount"];
        [udict setObject:@"1" forKey:@"is_like"];
        _m_dict = udict;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"点赞成功";
        hud.labelFont = [UIFont systemFontOfSize:13];
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
}


- (IBAction)sendAction:(id)sender {
    
//    if ([[_m_dict objectForKey:@"userID"] isEqual:[User_Dict objectForKey:@"id"]]) {
//        return;
//    }
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NoteDetailViewController" bundle:nil];
    NoteReplyViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"NoteReplyViewController"];  //
    door.m_dict = _m_dict;
    door.m_newsID = _m_newsID;
    door.m_commentID = [_m_dict objectForKey:@"id"];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
    
    _bgView.alpha= 1.0f;
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatCount:1];
    _bgView.alpha= 0.0f;
    [UIView commitAnimations];
    
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





@end

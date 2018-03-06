//
//  FootBall3_1.m
//  FootBall3
//
//  Created by 王登鹏 on 15/10/27.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import "NoteReplyViewController.h"
#import "NoteDetailCellViewController.h"
#import "NoteDetailCell2ViewController.h"
#import "DetailImageViewController.h"
#import "SelectPhoto.h"
#import "MsgView2.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <GPUImage/GPUImage.h>
#import "WebPostClass.h"

#define msgMaxk 100000

//extern NSMutableDictionary *User_Dict;

@interface NoteReplyViewController ()
@property (nonatomic) NSMutableArray *listArray;
@property (nonatomic) NSMutableArray *viewArray;
@property (nonatomic) NSMutableArray *imageArray;
@property (nonatomic) NSMutableDictionary* commentDict;
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic, retain) NSString* pageNum;

@property (weak, nonatomic) IBOutlet UIScrollView *superScrollView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UIView *listView1;
@property (weak, nonatomic) IBOutlet UIView *listView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewY;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeight;
@property (weak, nonatomic) IBOutlet ALAutoResizingTextView *myTextView;
@property (weak, nonatomic) IBOutlet UIView *textViewBG;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet UIControl *controlView;
@property (weak, nonatomic) IBOutlet UILabel *lbNavigationTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTextView;

@property (weak, nonatomic) IBOutlet UIView *listImageView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbFrom;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (nonatomic) NSMutableArray *cellArray;
@property (nonatomic) NoteDetailCellViewController *myNewsDetail;
@property (nonatomic) NoteDetailCellViewController *myReplyDetail;
@property (nonatomic) NSString *myReplyName;
@property (nonatomic) NSString *myReplyID;
@property (nonatomic) NSString *myCommentID;


- (IBAction)back:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)submitAction:(id)sender;
@property (nonatomic) NSDate *lastDate;
@end
@implementation NoteReplyViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    //    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(laterToMoveScrollView:) userInfo:nil repeats:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect rect2 = _myScrollView.bounds;
    myScrollViewFrameH = rect2.size.height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.navigationController.navigationBar setHidden:NO];
    
    self.pageNum = @"10";
    
    self.myReplyName = @"";
    self.myReplyID = @"";
    self.myCommentID = @"";
   
    self.cellArray = [[NSMutableArray alloc] init];
    self.lastDate = [NSDate dateWithTimeIntervalSince1970:0];
    // Do any additional setup after loading the view.
    _myTextView.layer.masksToBounds = YES;
    _myTextView.layer.cornerRadius = 5.0;
    _myTextView.layer.borderWidth = 1.0;
    _myTextView.layer.borderColor = [[UIColor colorWithRed:188 / 255.0 green:188 / 255.0 blue:188 / 255.0 alpha:1.0] CGColor];
    self.listArray = [[NSMutableArray alloc] init];
    self.viewArray = [[NSMutableArray alloc] init];
    
    
    
    //添加手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard:)];
    tapGestureRecognizer.delegate=self;
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [_myScrollView addGestureRecognizer:tapGestureRecognizer];
    
    if (_m_dict) {
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:_m_dict];
        [self createData:arr];
    }
    
//    {
//        NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//        if (User_Dict) {
//            [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//            [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//        }
//        [parameters_ setObject:_m_commentID forKey:@"commentID"];
//        
//        WebPostClass *web = [[WebPostClass alloc] init];
//        web.postID = 3;
//        web.showLoadingBool = YES;
//        web.delegate = self;
//        [web getHttpData:@"news/getCommentInfo" parameters:parameters_];
//    }
    
}



- (void)getData:(NSDictionary *)dict postID:(NSInteger)postID error:(NSError *)error {
    if (error != nil) {
        return;
    }
    if ([[dict objectForKey:@"code"] intValue] != 0) {
        NSLog(@"error = %@", [dict objectForKey:@"info"]);
        return;
    }
    
    
    if (postID == 1){
      
    }
   
    if (postID == 3){
        
        NSDictionary *d = [dict objectForKey:@"data"];
        self.m_dict = d;
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:_m_dict];
        [self createData:arr];
    }
    if (postID == 4){
        
        NSDictionary *d = [dict objectForKey:@"data"];
        NSString *sid = [d objectForKey:@"id"];
        
        NSMutableDictionary* dict = self.commentDict;
        NSMutableArray *a = [[NSMutableArray alloc] init];
        [a addObject:dict];
        
        [_myNewsDetail createData:a];
        
        [_myTextView setText:@""];
        [_myTextView resignFirstResponder];
        
    }
    
    if (postID == 8) {
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    
}



- (void)createData:(NSArray *)dataArray {
//    if ([dataArray count] == 0) {
//        return;
//    }
    UIView *view = nil;
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    view = _listView1;
    
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
        NSString* content = [d objectForKey:@"content"];
        NSString* likeCount = [d objectForKey:@"likeCount"];
        NSString* is_like = [d objectForKey:@"is_like"];
        NSString* userID = [d objectForKey:@"userID"];
        NSString* add_time = [d objectForKey:@"add_time"];
        NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[add_time floatValue]/1];
        NSString* image_path = [d objectForKey:@"image_path"];
        NSString* image = [d objectForKey:@"image"];
        image = [image_path stringByAppendingString:image];
//        NSArray* childList = [d objectForKey:@"childList"];

        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NoteDetailViewController" bundle:nil];
        NoteDetailCellViewController *v = (NoteDetailCellViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"NoteDetailCellViewController"];
        v.m_dict = d;
        [self addChildViewController:v];
        UIView *vv = [[v.view subviews] objectAtIndex:0];
        [view addSubview:vv];
        [viewArray addObject:vv];
        self.myReplyDetail = v;
        _lbTextView.text = [NSString stringWithFormat:@"回复 %@：", user_name];
        
        v.selfView = vv;
        v.delegate = self;
        v.superViewCon = self;
        v.lbName.text = user_name;
        v.lbContent.text = content;
//        v.lbCount.text = [NSString stringWithFormat:@"%@", likeCount];
        if ([is_like intValue]) {
            [v.ivZan setHidden:NO];
            [v.btZan setEnabled:NO];
        }
        v.lbTime.text = [self compareCurrentTime:dt];
        [v.ivLogo sd_setImageWithURL:[NSURL URLWithString:image] completed: ^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (img == nil) {
                [v.ivLogo setImage:[UIImage imageNamed:@"默认头像.png"]];
            }
        }];
        
        if (i == [dataArray count] - 1) {
            [v.lbXian setHidden:YES];
        }
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:10];
            c1.identifier = @"start";
            //等宽
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
            
            NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
            NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
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
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
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
    
    
    if(s_v != nil)
    {
        NSLayoutConstraint *c1 = [self findLayout:@"end" superView:view];
        [view removeConstraint:c1];
        //让SUPERVIEW的底 = 最后一个VIEW的底
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
        c3.identifier = @"end";
        [view addConstraint:c3];
    }
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


- (int)convertToInt:(NSString *)strtemp {
    int strlength = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength + 1) / 2;
}

- (void)textView:(ALAutoResizingTextView *)textView willChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight {
    
    if (oldHeight == 0) {
        return;
    }
    
    CGFloat y0 = _myScrollView.contentOffset.y;
    [_myScrollView setContentOffset:CGPointMake(0, y0 - (oldHeight - newHeight)) animated:YES];
    
    self.textViewHeight.constant = newHeight + 10;
    [self.textViewBG setNeedsLayout];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [self submitAction:nil];
        return NO;
    }
    int count = 0;
    if (textView.text.length > 0) {
        for (int i = 0; i < textView.text.length; i++) {
            unichar c = [textView.text characterAtIndex:i];
            if (c >= 0x4E00 && c <= 0x9FA5) {
                count++;
            }
        }
    }
    int length = [self convertToInt:textView.text];
    
    if (length >= 1000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的内容长度已经超过1000个字" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    else {
        return YES;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    [_lbTextView setHidden:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
}


- (void)closeKeyBoard:(id)sender {
    NSLog(@"closeKeyBoard===");
    
    //    [_myTextView resignFirstResponder];
}

#pragma mark--
#pragma mark--UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if([touch.view isKindOfClass:[UIButton class]])
    {
        UIButton* bt = touch.view;
        if (bt.tag == 1001 || bt.tag == 1002) {
            return NO;
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popClose" object:nil];
    
    return NO;
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

//当键退出时调用
- (void)keyboardDidHide:(NSNotification *)aNotification {

    [_controlView setHidden:YES];
    [_myTextView setText:@""];
    _lbTextView.text = [NSString stringWithFormat:@"回复 %@：", [_m_dict objectForKey:@"user_name"]];
    [_lbTextView setHidden:NO];
    
    //获取键盘的高度
//    NSDictionary *userInfo = [aNotification userInfo];
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];
//    float height = keyboardRect.size.height;

    CGFloat fheight = _myScrollView.contentSize.height - myScrollViewContentH;
    float hh = _myScrollView.contentOffset.y + fheight;
    if (hh + myScrollViewFrameH > _myScrollView.contentSize.height) {
        hh = _myScrollView.contentSize.height - myScrollViewFrameH;
    }
    if (hh < 0) {
        hh = 0;
    }
    [_myScrollView setContentOffset:CGPointMake(0, hh) animated:YES];
    
    _myNewsDetail = nil;

}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    
    NSDictionary *keyboardInfo = aNotification.userInfo;
    CGFloat keyboardEndPoint = CGRectGetMinY([keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]);
    CGFloat keyboardTotalHeight = CGRectGetHeight([keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]);
    CGFloat duration = [keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] floatValue];
    UIViewAnimationOptions animationOptions = [keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    self.textViewY.constant = (keyboardEndPoint != CGRectGetHeight([UIScreen mainScreen].bounds)) ? keyboardTotalHeight : 0.0f;
    [self.textViewBG setNeedsLayout];
    [UIView animateWithDuration:duration delay:0.0f options:animationOptions animations: ^{
        [self.textViewBG layoutIfNeeded];
    } completion:nil];
    

    
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    
//    NSLog(@"keyboardWillShow == %@", aNotification.userInfo);
//    if (showKB) {
//        return;
//    }
//    showKB = YES;
    [_controlView setHidden:NO];
    
    NSDictionary *keyboardInfo = aNotification.userInfo;
    UIViewAnimationCurve animationCurve = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    //    if(animationCurve == 0) return;
    CGFloat keyboardEndPoint = CGRectGetMinY([keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]);
    CGFloat keyboardTotalHeight = CGRectGetHeight([keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]);
    CGFloat duration = [keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] floatValue];
    UIViewAnimationOptions animationOptions = [keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    self.textViewY.constant = (keyboardEndPoint != CGRectGetHeight([UIScreen mainScreen].bounds)) ? keyboardTotalHeight : 0.0f;
    [self.textViewBG setNeedsLayout];
    //    NSLog(@"duration == %f", duration);
    [UIView animateWithDuration:duration delay:0.0f options:animationOptions animations: ^{
        [self.textViewBG layoutIfNeeded];
    } completion:nil];
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float height = keyboardRect.size.height;
//    NSLog(@"keyboardWillShow height == %f", height);
//    CGRect rect1 = _listView.bounds;
//    float h1 = rect1.size.height - myScrollViewH;
//    float hh = h1 + height;
//    if (hh > 0) {
//        
//        [_myScrollView setContentOffset:CGPointMake(0, hh) animated:YES];
//        NSLog(@"hh==%f", hh);
//    }
    
//    NSLog(@"contentSize.height==%f", _myScrollView.contentSize.height);
//    NSLog(@"frameSize.height==%f", _myScrollView.frame.size.height);
//    NSLog(@"height==%f", height);
    
    float h2 = _myNewsDetail.listY + _myNewsDetail.selfView.frame.origin.y + _myNewsDetail.selfView.superview.frame.origin.y;
    float hh = h2 + height - myScrollViewFrameH;
    if (hh < 0) {
        hh = 0;
    }
    
    [_myScrollView setContentOffset:CGPointMake(0, hh) animated:YES];
    
    
    myScrollViewContentH = _myScrollView.contentSize.height;
//    NSLog(@"keyboardWillShow height == %f", _myScrollView.contentSize.height);
//    NSLog(@"hh==%f", hh);
}


- (void)laterToMoveScrollView:(id)timer {
    CGFloat h0 = _myScrollView.contentSize.height;
    CGFloat h1 = _myScrollView.frame.size.height;
    h = h0 - h1;
    if (h<0) {
        return;
    }
    [_myScrollView setContentOffset:CGPointMake(0, h) animated:YES];
}

- (void)laterToMoveScrollView1:(id)timer {
    CGFloat h0 = _myScrollView.contentSize.height;
    CGFloat h1 = _myScrollView.frame.size.height;
    h = h0 - h1;
    if (h<0) {
        return;
    }
    [_myScrollView setContentOffset:CGPointMake(0, h) animated:NO];
}

- (IBAction)close:(id)sender {
    
    [_myTextView resignFirstResponder];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)share:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView2" bundle:nil];
    MsgView2 *msgView = (MsgView2*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView2"];
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}


- (IBAction)submitAction:(id)sender {
    
    /*
    if (!User_Dict) {
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView13" bundle:nil];
        UIViewController *msgView = [secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView13"];
        [self addChildViewController:msgView];
        [self.view addSubview:msgView.view];
        
        return;
    }
    
    if ([_myTextView.text length] == 0) {
        return;
    }
    
    if (!_myNewsDetail){
        
        _myNewsDetail = _myReplyDetail;
        _myReplyName = [_m_dict objectForKey:@"user_name"];
        _myReplyID = [_m_dict objectForKey:@"userID"];
        _myCommentID = [_m_dict objectForKey:@"id"];
    }

    NSString* add_time = [NSString stringWithFormat:@"%lf", ([[NSDate date] timeIntervalSince1970])*1];
    NSString* user_name = [User_Dict objectForKey:@"user_name"];
    NSString* userID = [User_Dict objectForKey:@"id"];
    NSString* parent_name = _myReplyName;
    NSString* parentID = _myReplyID;
    NSString* commentID = _myCommentID;
    NSString* content = [_myTextView text];

    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:add_time forKey:@"add_time"];
    [dict setObject:user_name forKey:@"user_name"];
    [dict setObject:userID forKey:@"userID"];
    [dict setObject:parent_name forKey:@"to_user_name"];
    [dict setObject:parentID forKey:@"to_user_id"];
    [dict setObject:content forKey:@"content"];
    [dict setObject:commentID forKey:@"id"];
    
    self.commentDict = dict;
    
    
    {
        NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
        [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
        [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
        [parameters_ setObject:_m_newsID forKey:@"bbsID"];
        [parameters_ setObject:content forKey:@"content"];
        [parameters_ setObject:commentID forKey:@"parent_id"];
        if ([parentID length] > 0) {
            [parameters_ setObject:parentID forKey:@"toUserID"];
        }
        
        WebPostClass *web = [[WebPostClass alloc] init];
        web.postID = 4;
        web.showLoadingBool = YES;
        web.delegate = self;
        [web getHttpData:@"bbs/addComment" parameters:parameters_];
    }
    */

    
}

- (IBAction)closeAction:(id)sender{
    
    //    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)okMsgView{
    
}

- (void)openTextView:(UIViewController*)vc parentName:(NSString*)parentName parentID:(NSString*)parentID commentID:(NSString*)commentID
{
    _myNewsDetail = vc;
    _myReplyName = parentName;
    _myReplyID = parentID;
    _myCommentID = commentID;
    _lbTextView.text = [NSString stringWithFormat:@"回复 %@：", _myReplyName];
    
    [_myTextView becomeFirstResponder];
}

@end

//
//  FootBall3_1.m
//  FootBall3
//
//
#import "FootBall4_8.h"
#import "FootBall4_8_Cell.h"
#import "FootBall4_8_image_Cell.h"
#import "ChatSetViewController.h"
#import "SelectPhoto.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <GPUImage/GPUImage.h>


#define msgMaxk 100000


@interface FootBall4_8 ()
@property (nonatomic) NSMutableArray *listArray;
@property (nonatomic) NSMutableArray *viewArray;
@property (nonatomic, retain) NSString* mPatientLogo;
@property (nonatomic, retain) NSString* mPatientName;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewY;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeight;
@property (weak, nonatomic) IBOutlet ALAutoResizingTextView *myTextView;
@property (weak, nonatomic) IBOutlet UIView *textViewBG;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet UIControl *controlView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleName;

@property (nonatomic) NSMutableArray *cellArray;
- (IBAction)back:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)submitAction:(id)sender;
@property (nonatomic) NSDate *lastDate;
@property (nonatomic, retain) NSString* pageNum;

@end
@implementation FootBall4_8

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    CGRect rect2 = _myScrollView.bounds;
    myScrollViewH = rect2.size.height;
//    NSLog(@"rect2.size.height==%f", rect2.size.height);
}


- (void)viewDidLoad {
	[super viewDidLoad];
    
//    [self.navigationController.navigationBar setHidden:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataChat:) name:@"updataChat" object:nil];
    
    self.pageNum = @"10";
    pageLastID = @"0";
    pageFirstID = @"0";
    self.mPatientLogo = @"";
    self.mPatientName = @"";
    m_patienIcon = @"";
	self.cellArray = [[NSMutableArray alloc] init];
	self.lastDate = [NSDate dateWithTimeIntervalSince1970:0];
	// Do any additional setup after loading the view.
//    [_myTextView close];
    [_myTextView layoutSubviews];
//    _myTextView.heightConstraint = _textHeight;
	_myTextView.layer.masksToBounds = YES;
	_myTextView.layer.cornerRadius = 5.0;
	_myTextView.layer.borderWidth = 1.0;
	_myTextView.layer.borderColor = [[UIColor colorWithRed:188 / 255.0 green:188 / 255.0 blue:188 / 255.0 alpha:1.0] CGColor];
//    _myTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
	self.listArray = [[NSMutableArray alloc] init];
	self.viewArray = [[NSMutableArray alloc] init];

    self.lbTitleName.text = _m_titleName;
    /*
	//[self.navigationController.navigationBar setTranslucent:YES];
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWillShow:)
	                                             name:UIKeyboardDidShowNotification
	                                           object:nil];
	//增加监听，当键退出时收出消息
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWillHide:)
	                                             name:UIKeyboardDidHideNotification
	                                           object:nil];
    */
    
    
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
    
    
    //添加手势
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard:)];
//    tapGestureRecognizer.cancelsTouchesInView = NO;
//    [_listView addGestureRecognizer:tapGestureRecognizer];
    
    
    {
//        NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//        [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//        [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//        [parameters_ setObject:_m_otherUserID forKey:@"otherUserID"];
//        [parameters_ setObject:_pageNum forKey:@"pageNum"];
//        [parameters_ setObject:@"0" forKey:@"pageType"];
//        [parameters_ setObject:@"0" forKey:@"pageID"];
//        
//        WebPostClass *web = [[WebPostClass alloc] init];
//        web.postID = 10;
//        web.showLoadingBool = YES;
//        web.delegate = self;
//        [web getHttpData:@"userSpace/getUserMsgLog" parameters:parameters_];
    }
    
    //测试
    if (self.m_historyD)
    {
        NSDictionary *d = _m_historyD;
        NSString* name = [d objectForKey:@"name"];
        NSString* portrait = [d objectForKey:@"portrait"];
        NSString* content = [d objectForKey:@"content"];
        NSString* uid = [d objectForKey:@"uid"];
        
        NSMutableArray *a = [[NSMutableArray alloc] init];
        NSDictionary *dic = @{ @"content":content, @"group":@"2", @"logo":portrait, @"username":name, @"date":[NSDate date], @"id":uid};
        [a addObject:dic];
        
        [self createOldData:a];
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(laterToMoveScrollView1:) userInfo:nil repeats:NO];
    }
}




- (void)updataChat:(NSNotification *)sender {
    
    
    NSDictionary* d1 = sender.userInfo;
    if (d1 == nil) {
        return;
    }
//    NSLog(@"updataChat data == %@", d1);
    
    NSString* uid = [d1 objectForKey:@"id"];
    int isImage = [[d1 objectForKey:@"isImage"] intValue];
    NSString* image_path = [d1 objectForKey:@"image_path"];
    NSString* image = [d1 objectForKey:@"image"];
    image = [image_path stringByAppendingString:image];
    NSString* content = [d1 objectForKey:@"content"];
    if (isImage == 1) {
        content = [image_path stringByAppendingString:content];
    }
    NSString* user_id = [d1 objectForKey:@"userID"];
    NSString* username = [d1 objectForKey:@"user_name"];
    NSString *nowTime = [d1 objectForKey:@"add_time"];
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[nowTime floatValue]/1];
    
    if (![user_id isEqual:_m_otherUserID]) {
        return;
    }
    
    NSMutableArray *a = [[NSMutableArray alloc] init];
    NSNumber *group = [NSNumber numberWithInt:2+2*isImage];
    NSDictionary *dic = @{ @"content":content, @"group":group, @"logo":image, @"username":username, @"date":dt, @"id":uid};
    [a addObject:dic];
    
    [self createData:a];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(laterToMoveScrollView:) userInfo:nil repeats:NO];
    
//    [_listArray addObject:dic];

    
//    NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//    [parameters_ setObject:[NSString stringWithFormat:@"%@", [User_Dict objectForKey:@"userid"]] forKey:@"userid"];
//    [parameters_ setObject:[NSString stringWithFormat:@"%@", [User_Dict objectForKey:@"token"]] forKey:@"token"];
//    [parameters_ setObject:m_patientId forKey:@"patientId"];
//    WebPostClass *web = [[WebPostClass alloc] init];
//    web.postID = msgMaxk + [_listArray count];
//    web.showLoadingBool = NO;
//    web.delegate = self;
//    [web getHttpData:@"inquiry/getPatientInfo" parameters:parameters_];
    
}


- (void)getData:(NSDictionary *)dict postID:(NSInteger)postID error:(NSError *)error {
    
    if (postID == 11) {
        bLoad = NO;
    }
    if (error != nil) {
        return;
    }
    if ([[dict objectForKey:@"code"] intValue] != 0) {
        NSLog(@"error = %@", [dict objectForKey:@"info"]);
        return;
    }
    
//    if (postID >= msgMaxk) {
//        
//        NSMutableDictionary *dic = [_listArray objectAtIndex:postID - msgMaxk -1];
//        
//        NSDictionary *d = [dict objectForKey:@"data"];
//        [dic setObject:[d objectForKey:@"logo"] forKey:@"logo"];
//        [dic setObject:[d objectForKey:@"username"] forKey:@"username"];
//        
//        NSMutableArray* Array = [[NSMutableArray alloc] init];
//        [Array addObject:dic];
//        NSLog(@"Array == %d", [Array count]);
//        [self createData:Array];
//        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(laterToMoveScrollView:) userInfo:nil repeats:NO];
//    }
    
    if (postID == 2){
        NSDictionary *d = [dict objectForKey:@"data"];
        self.mPatientLogo = [d objectForKey:@"logo"];
        self.mPatientName = [d objectForKey:@"username"];
    }
    
    if (postID == 10){
        
        NSMutableArray *a = [[NSMutableArray alloc] init];
        NSDictionary *d = [dict objectForKey:@"data"];
        NSArray *list = [d objectForKey:@"list"];
        for (int i = 0; i < [list count]; i ++) {
            NSDictionary *d1 = [list objectAtIndex:i];
            NSString* uid = [d1 objectForKey:@"id"];
            int isImage = [[d1 objectForKey:@"isImage"] intValue];
            NSString* image_path = [d1 objectForKey:@"image_path"];
            NSString* image = [d1 objectForKey:@"image"];
            image = [image_path stringByAppendingString:image];
            NSString* content = [d1 objectForKey:@"content"];
            if (isImage == 1) {
                content = [image_path stringByAppendingString:content];
            }
            NSString* user_id = [d1 objectForKey:@"user_id"];
            NSString* username = [d1 objectForKey:@"user_name"];
            NSString *nowTime = [d1 objectForKey:@"time"];
            NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[nowTime floatValue]/1];
            int theSender = 0;
            
            if (theSender == 2) {//（自己）
                NSNumber *group = [NSNumber numberWithInt:1+2*isImage];
                NSDictionary *dic = @{ @"content":content, @"group":group, @"logo":image, @"username":username, @"date":dt, @"id":uid};
                [a addObject:dic];
            }
            if (theSender == 1) {// 对方
                NSNumber *group = [NSNumber numberWithInt:2+2*isImage];
                NSDictionary *dic = @{ @"content":content, @"group":group, @"logo":image, @"username":username, @"date":dt, @"id":uid};
                [a addObject:dic];
            }
        }
        [self createOldData:a];
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(laterToMoveScrollView1:) userInfo:nil repeats:NO];
    }
    if (postID == 11){
        
        NSMutableArray *a = [[NSMutableArray alloc] init];
        NSDictionary *d = [dict objectForKey:@"data"];
        NSArray *list = [d objectForKey:@"list"];
        for (int i = 0; i < [list count]; i ++) {
            NSDictionary *d1 = [list objectAtIndex:i];
            NSString* uid = [d1 objectForKey:@"id"];
            int isImage = [[d1 objectForKey:@"isImage"] intValue];
            NSString* image_path = [d1 objectForKey:@"image_path"];
            NSString* image = [d1 objectForKey:@"image"];
            image = [image_path stringByAppendingString:image];
            NSString* content = [d1 objectForKey:@"content"];
            if (isImage == 1) {
                content = [image_path stringByAppendingString:content];
            }
            NSString* user_id = [d1 objectForKey:@"user_id"];
            NSString* username = [d1 objectForKey:@"user_name"];
            NSString *nowTime = [d1 objectForKey:@"time"];
            NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[nowTime floatValue]/1];
            int theSender = 0;
//            if ([user_id isEqual:[User_Dict objectForKey:@"id"]]) {
//                theSender = 2;
//            }else{
//                theSender = 1;
//            }
            
            if (theSender == 2) {//（自己）
                NSNumber *group = [NSNumber numberWithInt:1+2*isImage];
                NSDictionary *dic = @{ @"content":content, @"group":group, @"logo":image, @"username":username, @"date":dt, @"id":uid};
                [a addObject:dic];
            }
            if (theSender == 1) {// 对方
                NSNumber *group = [NSNumber numberWithInt:2+2*isImage];
                NSDictionary *dic = @{ @"content":content, @"group":group, @"logo":image, @"username":username, @"date":dt, @"id":uid};
                [a addObject:dic];
            }
        }
        [self createMoreData:a];

        bMore = YES;
        if ([a count] == 0) {
            bLoad = YES;
        }
//        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(laterToMoveScrollView1:) userInfo:nil repeats:NO];
    }
    
    if (postID == 8) {
//        [self.navigationController popViewControllerAnimated:YES];

    }
    
}

- (NSString *)compareCurrentTime:(NSDate *)compareDate {
    NSDateFormatter *forTime = [[NSDateFormatter alloc]init];
    [forTime setDateFormat:@"YYYY-MM-dd"];
    NSString *today = [forTime stringFromDate:[NSDate date]];
    //    NSLog(@"today==%@", today);
    NSDateFormatter *forTime1 = [[NSDateFormatter alloc]init];
    [forTime1 setDateFormat:@"YYYY-MM-dd"];
    NSString *day1 = [forTime1 stringFromDate:compareDate];
    //    NSLog(@"day1==%@", day1);
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        if ([today isEqual:day1]) {
            result = [NSString stringWithFormat:@"今天"];
        }
        else {
            result = [NSString stringWithFormat:@"昨天"];
        }
    }
    else if ((temp = timeInterval / 60) < 60) {
        if ([today isEqual:day1]) {
            result = [NSString stringWithFormat:@"今天"];
        }
        else {
            result = [NSString stringWithFormat:@"昨天"];
        }
    }
    else if ((temp = temp / 60) < 24) {
        if ([today isEqual:day1]) {
            result = [NSString stringWithFormat:@"今天"];
        }
        else {
            result = [NSString stringWithFormat:@"昨天"];
        }
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

//上传图片
- (void)getImageKey:(NSString *)key imgName:timeString postID:(NSInteger)postID {

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
   
   // NSLog(@"oldHeight==%f  newHeight==%f", oldHeight, newHeight);
	if (oldHeight == 0) {
		return;
	}
    
//	CGRect r = textView.frame;
//	NSLog(@"%f", r.size.height);
//	UIView *v0 = textView.superview;
//	UIView *v1 = v0.superview;//当前的VIEW
//	UIScrollView *v3 = (UIScrollView *)v1.superview;
//	CGFloat y0 = v3.contentOffset.y;
//	[v3 setContentOffset:CGPointMake(0, y0 - (oldHeight - newHeight)) animated:YES];
    
//	CGFloat h0 = _myScrollView.contentSize.height;
//	CGFloat h1 = _myScrollView.frame.size.height;
//	h = h0 - h1;
//	[_myScrollView setContentOffset:CGPointMake(0, h) animated:YES];
//	CGFloat y0 = _myScrollView.contentOffset.y;
//	CGFloat yy = y0 - (oldHeight - newHeight);
//	if (yy < 0) {
//		yy = 0;
//	}
//	[_myScrollView setContentOffset:CGPointMake(0, yy) animated:YES];
    
    CGFloat y0 = _myScrollView.contentOffset.y;
    [_myScrollView setContentOffset:CGPointMake(0, y0 - (oldHeight - newHeight)) animated:YES];
    
//    self.textViewY.constant += (newHeight - oldHeight);
//    [self.textViewBG setNeedsLayout];
    
     self.textViewHeight.constant = newHeight + 20;
     [self.textViewBG setNeedsLayout];
    //    NSLog(@"duration == %f", duration);
//    [UIView animateWithDuration:duration delay:0.0f options:animationOptions animations: ^{
//        [self.textViewBG layoutIfNeeded];
//    } completion:nil];
    
//    NSLog(@"h==%f", _myTextView.heightConstraint.constant);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
//    NSLog(@"replacementText==%@", text);
//    NSLog(@"range location==%d length==%d", range.location, range.length);
    
	if ([text isEqualToString:@"\n"]) {
//		NSMutableArray *a = [[NSMutableArray alloc] init];
//		NSNumber *group = [NSNumber numberWithInt:1];
//		NSDictionary *dic = @{ @"content":[_myTextView text], @"group":group };
//		[a addObject:dic];
//		[self createData:a];
//		[_myTextView setText:@""];
//		[_myTextView resignFirstResponder];
//		return NO;
        
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
    
	if (length >= 140) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的内容长度已经超过140个字" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
		[alert show];
		return NO;
	}
	else {
		return YES;
	}
	return YES;
}



//当键退出时调用
- (void)keyboardDidHide:(NSNotification *)aNotification {
    
    [_controlView setHidden:YES];
    //[_myScrollView setScrollEnabled:YES];
    CGFloat h0 = _myScrollView.contentSize.height;
    CGFloat h1 = _myScrollView.frame.size.height;
    float hh = h0 - h1;
    //[_myScrollView setScrollEnabled:NO];
    if (hh > 0) {
        [_myScrollView setContentOffset:CGPointMake(0, hh) animated:YES];
    }
}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    
    NSDictionary *keyboardInfo = aNotification.userInfo;
    CGFloat keyboardEndPoint = CGRectGetMinY([keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]);
    CGFloat keyboardTotalHeight = CGRectGetHeight([keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]);
    CGFloat duration = [keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] floatValue];
    UIViewAnimationOptions animationOptions = [keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    self.textViewY.constant = (keyboardEndPoint != CGRectGetHeight([UIScreen mainScreen].bounds)) ? keyboardTotalHeight : 0.0f;
//    self.textViewY.constant = 0;
    [self.textViewBG setNeedsLayout];
    [UIView animateWithDuration:duration delay:0.0f options:animationOptions animations: ^{
        [self.textViewBG layoutIfNeeded];
    } completion:nil];
    
//    NSLog(@"self.textViewY.constant==%f", self.textViewY.constant);
//	CGFloat h0 = _myScrollView.contentSize.height;
//	CGFloat h1 = _myScrollView.frame.size.height;
//	h = h0 - h1;
//    if (h<0) {
//        return;
//    }
//	[_myScrollView setContentOffset:CGPointMake(0, h) animated:YES];
    
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    
//    NSLog(@"keyboardWillShow == %@", aNotification.userInfo);
//    if (!_controlView.isHidden) {
//        return;
//    }
    [_controlView setHidden:NO];
    
    NSDictionary *keyboardInfo = aNotification.userInfo;
    UIViewAnimationCurve animationCurve = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
//    if(animationCurve != 0) return;
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
//    NSDictionary *userInfo = [aNotification userInfo];
//    
//    NSValue *aValue1 = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGRect keyboardRect1 = [aValue1 CGRectValue];
//    int height1 = keyboardRect1.size.height;
//    
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];
//    int height = keyboardRect.size.height;
    
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    CGRect rect1 = _listView.bounds;
    CGRect rect2 = _myScrollView.bounds;
   
    float h1 = rect1.size.height - myScrollViewH;
    float hh = h1 + height;
    if (hh > 0) {
        [_myScrollView setContentOffset:CGPointMake(0, hh) animated:YES];
//        NSLog(@"rect1.size.height==%f", rect1.size.height);
//        NSLog(@"rect2.size.height==%f", rect2.size.height);
//        NSLog(@"rect3.size.height==%f", rect3.size.height);
//        NSLog(@"hh==%f", hh);
    }
    
    
    
//    if (height1 == height) {
//        CGRect rect1 = _listView.bounds;
//        CGRect rect2 = _myScrollView.bounds;
//        float h1 = rect1.size.height - rect2.size.height;
//        float hh = h1 + height;
//        if (hh > 0) {
//            [_myScrollView setContentOffset:CGPointMake(0, hh) animated:YES];
//        }
////        [_myScrollView setContentOffset:CGPointMake(0, hh) animated:YES];
//    }else{
//        float hh = height-height1;
//        [_myScrollView setContentOffset:CGPointMake(0, _myScrollView.contentOffset.y+hh) animated:YES];
//    }
    
//    [_myScrollView setContentOffset:CGPointMake(0, _myScrollView.contentOffset.y-height) animated:YES];

    
//	CGFloat h0 = _myScrollView.contentSize.height;
//	CGFloat h1 = _myScrollView.frame.size.height;
//	h = h0 - h1;
//    if (h<0) {
//        return;
//    }
//	[_myScrollView setContentOffset:CGPointMake(0, h) animated:YES];
}


- (void)closeKeyBoard:(id)sender {
        NSLog(@"closeKeyBoard===");
    [_myTextView resignFirstResponder];
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


- (void)createData:(NSArray *)dataArray {
    if ([dataArray count] == 0) {
        return;
    }
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
        //football1
        NSDictionary *d = [dataArray objectAtIndex:i];
        NSNumber *group = [d objectForKey:@"group"];
        NSString* record = [d objectForKey:@"record"];
        NSDate *date = [d objectForKey:@"date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *date_c = [cal components:unitFlags fromDate:_lastDate toDate:date options:0];
        int sec = [date_c hour] * 3600 + [date_c minute] * 60 + [date_c second];
        NSLog(@"second = %d", sec);
        NSString *dateString = nil;
        NSString *dateS1 = [self compareCurrentTime:date];
        if ([dateS1 isEqual:@"今天"]) {
            [formatter setDateFormat:@"HH:mm"];
            dateString = [formatter stringFromDate:date];
        }else if([dateS1 isEqual:@"昨天"]){
            [formatter setDateFormat:@"HH:mm"];
            dateString = [formatter stringFromDate:date];
            dateString = [NSString stringWithFormat:@"昨天 %@", dateString];
        }else{
            [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            dateString = [formatter stringFromDate:date];
        }
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FootBall4_8_Cell" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FootBall4_8_Cell"];
        if ([group intValue] > 2) {
            FootBall4_8_image_Cell *vv = (FootBall4_8_image_Cell *)[v.view viewWithTag:[group intValue]];
            vv.superViewCon = self;
            vv.m_otherUserID = _m_otherUserID;
            vv.group = [group integerValue];
            [self addChildViewController:v];
            [view addSubview:vv];
            [viewArray addObject:vv];
            if (abs(sec) > 60) {
                vv.dateLabel.text = dateString;
                self.lastDate = date;
            }
            else {
                vv.dateHeight = 0;
                [vv.dateLabel setHidden:YES];
            }
            
            [vv.logImage sd_setImageWithURL:[NSURL URLWithString:[d objectForKey:@"logo"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            if([d objectForKey:@"content"])
            {
                [vv.image sd_setImageWithURL:[NSURL URLWithString:[d objectForKey:@"content"]] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image == nil) {
                    }
                }];
                
            }
            if([d objectForKey:@"img"])
            {
                [vv.image setImage:[d objectForKey:@"img"]];
            }
            if (vv.group == 4) {
                vv.nameLabel.text = [d objectForKey:@"username"];
            }
            
        }
        else {
            FootBall4_8_Cell *vv = (FootBall4_8_Cell *)[v.view viewWithTag:[group intValue]];
            vv.superViewCon = self;
            vv.group = [group integerValue];
            [self addChildViewController:v];
            [view addSubview:vv];
            [viewArray addObject:vv];
            if (abs(sec) > 60) {
                vv.dateLabel.text = dateString;
                self.lastDate = date;
            }
            else {
                vv.dateHeight = 0;
                [vv.dateLabel setHidden:YES];
            }
            
            [vv.logImage sd_setImageWithURL:[NSURL URLWithString:[d objectForKey:@"logo"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            vv.content = [d objectForKey:@"content"];
            if (vv.group == 2) {
                vv.nameLabel.text = [d objectForKey:@"username"];
            }
            
        }
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            //X居中
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:30];
            //等宽
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
            //距离上一个的高度
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
    NSLayoutConstraint *c1 = [self findLayout:@"end" superView:view];
    [view removeConstraint:c1];
    //让SUPERVIEW的底 = 最后一个VIEW的底
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
    c3.identifier = @"end";
    [view addConstraint:c3];
}


- (void)createOldData:(NSArray *)dataArray {
	if ([dataArray count] == 0) {
		return;
	}
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
	for (int i = [dataArray count]-1; i >= 0; i--) {
		//football1
		NSDictionary *d = [dataArray objectAtIndex:i];
        NSString* uid = [d objectForKey:@"id"];
		NSNumber *group = [d objectForKey:@"group"];
        NSString* record = [d objectForKey:@"record"];
		NSDate *date = [d objectForKey:@"date"];
		NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
		NSCalendar *cal = [NSCalendar currentCalendar];
		unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
		NSDateComponents *date_c = [cal components:unitFlags fromDate:_lastDate toDate:date options:0];
		int sec = [date_c hour] * 3600 + [date_c minute] * 60 + [date_c second];
		NSLog(@"second = %d", sec);
		NSString *dateString = nil;
        NSString *dateS1 = [self compareCurrentTime:date];
        if ([dateS1 isEqual:@"今天"]) {
            [formatter setDateFormat:@"HH:mm"];
            dateString = [formatter stringFromDate:date];
        }else if([dateS1 isEqual:@"昨天"]){
            [formatter setDateFormat:@"HH:mm"];
            dateString = [formatter stringFromDate:date];
            dateString = [NSString stringWithFormat:@"昨天 %@", dateString];
        }else{
            [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            dateString = [formatter stringFromDate:date];
        }
//        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//        dateString = [formatter stringFromDate:date];
//        NSLog(@"dateString == %@", dateString);
		UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FootBall4_8_Cell" bundle:nil];
		UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FootBall4_8_Cell"];
		if ([group intValue] > 2) {
			FootBall4_8_image_Cell *vv = (FootBall4_8_image_Cell *)[v.view viewWithTag:[group intValue]];
            vv.superViewCon = self;
            vv.m_otherUserID = _m_otherUserID;
			vv.group = [group integerValue];
			[self addChildViewController:v];
			[view addSubview:vv];
			[viewArray addObject:vv];
            if (abs(sec) > 60) {
                vv.dateLabel.text = dateString;
                self.lastDate = date;
            }
            else {
                vv.dateHeight = 0;
                [vv.dateLabel setHidden:YES];
            }
            
            [vv.logImage sd_setImageWithURL:[NSURL URLWithString:[d objectForKey:@"logo"]] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image == nil) {
                    [vv.logImage setImage:[UIImage imageNamed:@"默认头像.png"]];
                }
            }];
            if([d objectForKey:@"content"])
            {
                [vv.image sd_setImageWithURL:[NSURL URLWithString:[d objectForKey:@"content"]] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image == nil) {
                    }
                }];
//                NSLog(@"[d objectForKey] == %@", [d objectForKey:@"content"]);
            }
            if([d objectForKey:@"img"])
            {
                [vv.image setImage:[d objectForKey:@"img"]];
            }
            if (vv.group == 4) {
                vv.nameLabel.text = [d objectForKey:@"username"];
            }
            
		}
		else {
			FootBall4_8_Cell *vv = (FootBall4_8_Cell *)[v.view viewWithTag:[group intValue]];
            vv.superViewCon = self;
            vv.group = [group integerValue];
			[self addChildViewController:v];
			[view addSubview:vv];
			[viewArray addObject:vv];
            if (abs(sec) > 60) {
                vv.dateLabel.text = dateString;
                self.lastDate = date;
            }
            else {
                vv.dateHeight = 0;
                [vv.dateLabel setHidden:YES];
            }
            
             [vv.logImage setImage:[UIImage imageNamed:[d objectForKey:@"logo"]]];//测试
//            [vv.logImage sd_setImageWithURL:[NSURL URLWithString:[d objectForKey:@"logo"]] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                if (image == nil) {
//                    [vv.logImage setImage:[UIImage imageNamed:@"默认头像.png"]];
//                }
//            }];
            vv.content = [d objectForKey:@"content"];
            if (vv.group == 2) {
                vv.nameLabel.text = [d objectForKey:@"username"];
            }
            
		}
        
        
        if (i == [dataArray count]-1) {
            pageLastID = uid;
        }
	}
    
	int k = 0;
	for (UIView *v in viewArray) {
		if (s_v == nil) {
			//X居中
			NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:5];
            c1.identifier = @"start";
			//等宽
			NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
			//距离上一个的高度
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
	NSLayoutConstraint *c1 = [self findLayout:@"end" superView:view];
	[view removeConstraint:c1];
	//让SUPERVIEW的底 = 最后一个VIEW的底
	NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
	c3.identifier = @"end";
	[view addConstraint:c3];
}



- (void)createMoreData:(NSArray *)dataArray {
    if ([dataArray count] == 0) {
        return;
    }
    UIView *view = nil;
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    view = _listView;
    
    UIView *s_v = nil;
    if ([[view subviews] count] > 0) {
        s_v = [[view subviews] firstObject];
    }
    else {
        NSArray *a = [view constraints];
        [view removeConstraints:a];
    }
    
//    NSLog(@"[dataArray count] == %d", [dataArray count]);
    for (int i = 0; i < [dataArray count]; i ++) {
        //football1
        NSDictionary *d = [dataArray objectAtIndex:i];
        NSString* uid = [d objectForKey:@"id"];
        NSNumber *group = [d objectForKey:@"group"];
        NSString* content = [d objectForKey:@"content"];
//        NSString* record = [d objectForKey:@"record"];
        NSDate *date = [d objectForKey:@"date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *date_c = [cal components:unitFlags fromDate:_lastDate toDate:date options:0];
        int sec = [date_c hour] * 3600 + [date_c minute] * 60 + [date_c second];
        NSLog(@"second = %d", sec);
        NSString *dateString = nil;
        NSString *dateS1 = [self compareCurrentTime:date];
        if ([dateS1 isEqual:@"今天"]) {
            [formatter setDateFormat:@"HH:mm"];
            dateString = [formatter stringFromDate:date];
        }else if([dateS1 isEqual:@"昨天"]){
            [formatter setDateFormat:@"HH:mm"];
            dateString = [formatter stringFromDate:date];
            dateString = [NSString stringWithFormat:@"昨天 %@", dateString];
        }else{
            [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            dateString = [formatter stringFromDate:date];
        }
        //        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        //        dateString = [formatter stringFromDate:date];
        //        NSLog(@"dateString == %@", dateString);
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FootBall4_8_Cell" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FootBall4_8_Cell"];
        if ([group intValue] > 2) {
            FootBall4_8_image_Cell *vv = (FootBall4_8_image_Cell *)[v.view viewWithTag:[group intValue]];
            vv.superViewCon = self;
            vv.m_otherUserID = _m_otherUserID;
            vv.group = [group integerValue];
            [self addChildViewController:v];
//            [view addSubview:vv];
            [view insertSubview:vv atIndex:0];
            [viewArray insertObject:vv atIndex:0];
            if (abs(sec) > 60) {
                vv.dateLabel.text = dateString;
                self.lastDate = date;
            }
            else {
                vv.dateHeight = 0;
                [vv.dateLabel setHidden:YES];
            }
            
            [vv.logImage sd_setImageWithURL:[NSURL URLWithString:[d objectForKey:@"logo"]] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image == nil) {
                    [vv.logImage setImage:[UIImage imageNamed:@"默认头像.png"]];
                }
            }];
            if([d objectForKey:@"content"])
            {
                [vv.image sd_setImageWithURL:[NSURL URLWithString:[d objectForKey:@"content"]] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image == nil) {
                    }else{
//                        CGSize size = image.size;
//                        float scale = size.height / size.width;
//                        float width = [UIScreen mainScreen].bounds.size.width/2;
//                        float height = width * scale;
//                        if (size.width > width) {
//                            NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:vv.image attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
//                            [vv.image addConstraint:c3];
//                        }
                    }
                }];
                //                NSLog(@"[d objectForKey] == %@", [d objectForKey:@"content"]);
            }
            if([d objectForKey:@"img"])
            {
                [vv.image setImage:[d objectForKey:@"img"]];
//                CGSize size = image.size;
//                float scale = size.height / size.width;
//                float width = [UIScreen mainScreen].bounds.size.width/2;
//                float height = width * scale;
//                if (size.width > width) {
//                    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:vv.image attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
//                    [vv.image addConstraint:c3];
//                }
            }
            if (vv.group == 4) {
                vv.nameLabel.text = [d objectForKey:@"username"];
            }
            
        }
        else {
            FootBall4_8_Cell *vv = (FootBall4_8_Cell *)[v.view viewWithTag:[group intValue]];
            vv.superViewCon = self;
            vv.group = [group integerValue];
            [self addChildViewController:v];
            [view insertSubview:vv atIndex:0];
            [viewArray insertObject:vv atIndex:0];
            if (abs(sec) > 60) {
                vv.dateLabel.text = dateString;
                self.lastDate = date;
            }
            else {
                vv.dateHeight = 0;
                [vv.dateLabel setHidden:YES];
            }
            
            [vv.logImage sd_setImageWithURL:[NSURL URLWithString:[d objectForKey:@"logo"]] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image == nil) {
                    [vv.logImage setImage:[UIImage imageNamed:@"默认头像.png"]];
                }
            }];
            vv.content = [d objectForKey:@"content"];
            if (vv.group == 2) {
                vv.nameLabel.text = [d objectForKey:@"username"];
            }
            
        }
        
        
        pageLastID = uid;
    }
    
    if(s_v != nil)
    {
        NSLayoutConstraint *c1 = [self findLayout:@"start" superView:view];
        [view removeConstraint:c1];
        
        UIView *v = [viewArray lastObject];
        //距离上一个的高度
        NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:s_v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
        [view addConstraint:c4];
        
        s_v = nil;
        
        int k = 0;
        for (UIView *v in viewArray) {
            if (s_v == nil) {
                //X居中
                NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
                //等宽
                NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
                NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
                //距离上一个的高度
                NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:5];
                c4.identifier = @"start";
                [view addConstraint:c1];
                [view addConstraint:c2];
                [view addConstraint:c3];
                [view addConstraint:c4];
                s_v = v;
                k++;
                continue;
            }
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            //等宽
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
            //距离上一个的高度
            NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
            [view addConstraint:c1];
            [view addConstraint:c2];
            [view addConstraint:c4];
            s_v = v;
            k++;
        }
        
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*
    if (bMore) {
        [scrollView setContentOffset:CGPointMake(0, scrollView.contentSize.height-fHeight) animated:NO];
        bMore = NO;
    }else{
        fHeight = scrollView.contentSize.height;
        if (scrollView.contentOffset.y < -1 && !bLoad) {
            bLoad = YES;
            NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
            [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
            [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
            [parameters_ setObject:_m_otherUserID forKey:@"otherUserID"];
            [parameters_ setObject:_pageNum forKey:@"pageNum"];
            [parameters_ setObject:@"2" forKey:@"pageType"];
            [parameters_ setObject:pageLastID forKey:@"pageID"];
            
            WebPostClass *web = [[WebPostClass alloc] init];
            web.postID = 11;
            web.showLoadingBool = YES;
            web.delegate = self;
            [web getHttpData:@"userSpace/getUserMsgLog" parameters:parameters_];
        }
    }
     */
}



- (IBAction)back:(id)sender {
    
//    NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//    [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//    [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//    [parameters_ setObject:_m_otherUserID forKey:@"otherUserID"];
//    
//    WebPostClass *web = [[WebPostClass alloc] init];
//    web.postID = 8;
//    web.showLoadingBool = NO;
//    web.delegate = self;
//    [web getHttpData:@"userSpace/msgIsRead" parameters:parameters_];
    
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rightAction:(id)sender {
	UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FootBall4_4" bundle:nil];
	UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FootBall4_4"];
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
	[self.navigationController pushViewController:door animated:YES];
}


- (void)getFilePath:(NSString *)filePath postID:(NSInteger)postID
{
    NSLog(@"filePath == %@", filePath);
    
//    NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//    [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//    [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//    [parameters_ setObject:_m_otherUserID forKey:@"otherUserID"];
//    [parameters_ setObject:@"1" forKey:@"isImage"];
//    [parameters_ setObject:filePath forKey:@"content"];
//    
//    WebPostClass *web = [[WebPostClass alloc] init];
//    web.postID = 1;
//    web.showLoadingBool = YES;
//    web.delegate = self;
//    [web getHttpData:@"userSpace/sendUserMsg" parameters:parameters_];
}

- (void)changePhotos:(UIImage *)img {
	NSLog(@"图片已经选择");
	NSMutableArray *a = [[NSMutableArray alloc] init];
	NSNumber *group = [NSNumber numberWithInt:3];
    
//    NSString* image_path = [User_Dict objectForKey:@"image_path"];
//    NSString* image = [User_Dict objectForKey:@"image"];
//    image = [image_path stringByAppendingString:image];
    NSString* image = @"1111";
	NSDictionary *dic = @{ @"img":img, @"group":group, @"logo":image, @"date":[NSDate date] };
	[a addObject:dic];
	[self createData:a];

    
//    NSString* filePath = @"uploadfile/user/";
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
//    NSString *dateString = [formatter stringFromDate:date];
//    NSString *fileName = [NSString stringWithFormat:@"%@_sale.png", dateString];
//    filePath = [filePath stringByAppendingString:fileName];
//    
//    WebPostClass *web = [[WebPostClass alloc] init];
//    web.postID = 20;
//    web.showLoadingBool = YES;
//    web.delegate = self;
//    [web updateImageAliyun:@"login/getOssSign" image:img filePath:filePath parameters:nil];
    
    
    [_myTextView setText:@""];
    [_myTextView resignFirstResponder];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(laterToMoveScrollView:) userInfo:nil repeats:NO];
    
//    NSLog(@"img.size.width==%f  img.size.height==%f", img.size.width, img.size.height);
}

- (IBAction)selectPhoto:(id)sender {
	SelectPhoto *v = [[SelectPhoto alloc] init];
	v.delegate = self;
	[self addChildViewController:v];
	[self.view addSubview:v.view];
}

- (IBAction)submitAction:(id)sender {
    
    if ([_myTextView.text length] == 0) {
        return;
    }
	NSMutableArray *a = [[NSMutableArray alloc] init];
	NSNumber *group = [NSNumber numberWithInt:1];
//    NSString* image_path = [User_Dict objectForKey:@"image_path"];
//    NSString* image = [User_Dict objectForKey:@"image"];
//    image = [image_path stringByAppendingString:image];
    NSString* image = @"1111";
	NSDictionary *dic = @{ @"content":[_myTextView text], @"group":group, @"logo":image, @"date":[NSDate date] };
	[a addObject:dic];
	[self createData:a];
    
//    NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//    [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//    [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//    [parameters_ setObject:_m_otherUserID forKey:@"otherUserID"];
//    [parameters_ setObject:@"0" forKey:@"isImage"];
//    [parameters_ setObject:_myTextView.text forKey:@"content"];
//    
//    WebPostClass *web = [[WebPostClass alloc] init];
//    web.postID = 1;
//    web.showLoadingBool = YES;
//    web.delegate = self;
//    [web getHttpData:@"userSpace/sendUserMsg" parameters:parameters_];
    
    [_myTextView setText:@""];
    [_myTextView resignFirstResponder];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(laterToMoveScrollView:) userInfo:nil repeats:NO];
    
}

- (IBAction)setAction:(id)sender{
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ChatSetViewController" bundle:nil];
    ChatSetViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ChatSetViewController"];  //
    door.m_titleName = _m_titleName;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

- (IBAction)closeAction:(id)sender{
 
//    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)okMsgView{
    
}

@end

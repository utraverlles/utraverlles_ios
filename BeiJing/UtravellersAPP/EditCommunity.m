//
//
//
#import "EditCommunity.h"
#import "SelectPhoto.h"
#import "NSString+JSON.h"
#import "IdentifierValidator.h"

#define  LoadingTAG 985

//extern NSMutableDictionary *User_Dict;

@interface EditCommunity () <MBProgressHUDDelegate>
@property (nonatomic) MBProgressHUD *HUD;
- (IBAction)addImageAction:(id)sender;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *fontCountLabel;
- (IBAction)submitAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet ALAutoResizingTextView *myTextView;
@property (weak, nonatomic) IBOutlet UIView *imageSuperView;
@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
@property (nonatomic) NSInteger imageIndex;
@property (weak, nonatomic) IBOutlet UILabel *imageCount;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIControl *controView;
@property (nonatomic) NSMutableArray *imageArray;
@property (nonatomic) NSMutableArray *imagePathArray;
- (IBAction)controViewAction:(UIControl *)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *myFirendsLabel;
@property (nonatomic) NSString *cityString;
@end
@implementation EditCommunity
- (void)viewDidLoad {
	[super viewDidLoad];
    
	// Do any additional setup after loading the view.
	//增加监听，当键盘出现或改变时收出消息
	self.imageArray = [[NSMutableArray alloc] init];
    self.imagePathArray = [[NSMutableArray alloc] init];
    
	_myTextView.layer.masksToBounds = YES;
	_myTextView.layer.cornerRadius = 5.0;
	_myTextView.layer.borderWidth = 1.0;
	_myTextView.layer.borderColor = [[UIColor colorWithRed:236.0 / 255 green:236.0 / 255 blue:236.0 / 255 alpha:1.0] CGColor];
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWillShow:)
	                                             name:UIKeyboardWillShowNotification
	                                           object:nil];
	//增加监听，当键退出时收出消息
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWillHide:)
	                                             name:UIKeyboardWillHideNotification
	                                           object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resetImage {
	[_addImageButton setHidden:NO];
	_imageIndex = 0;
	[_imageCount setText:[NSString stringWithFormat:@"(%ld/6)", (long)_imageIndex]];
	NSArray *a = [_imageSuperView subviews];
	for (int i = 0; i < 6; i++) {
		UIImageView *image = [a objectAtIndex:i];
		[image setImage:[[UIImage alloc] init]];
	}
	UIImageView *image = [a objectAtIndex:0];
	NSLayoutConstraint *c1 = [self findLayout:@"buttonX" superView:_imageSuperView];
	[_imageSuperView removeConstraint:c1];
	NSLayoutConstraint *c2 = [self findLayout:@"buttonY" superView:_imageSuperView];
	[_imageSuperView removeConstraint:c2];
	c1 = [NSLayoutConstraint constraintWithItem:_addImageButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:image attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
	c1.identifier = @"buttonX";
	[_imageSuperView addConstraint:c1];
	c2 = [NSLayoutConstraint constraintWithItem:_addImageButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:image attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
	c2.identifier = @"buttonY";
	[_imageSuperView addConstraint:c2];
	[_imageArray removeAllObjects];
	_myTextView.text = @"";
}


- (void)textViewDidChange:(UITextView *)textView {
	NSInteger number = [textView.text length];
	if (number > 0) {
		[_submitButton setEnabled:YES];
	}
	else {
		[_submitButton setEnabled:NO];
	}
	if (number > 140) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于140" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		textView.text = [textView.text substringToIndex:140];
		number = 140;
	}
	self.fontCountLabel.text = [NSString stringWithFormat:@"%d/140", number];
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

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
	[_controView setHidden:NO];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
	[_controView setHidden:YES];
}

- (void)changePhotos:(UIImage *)img {
	NSLog(@"已经选择了图片");
	NSArray *a = [_imageSuperView subviews];
	UIImageView *image = [a objectAtIndex:_imageIndex];
	[image setImage:img];
	_imageIndex++;
    
    for (int i = 0; i < _imageIndex; i ++) {
        UIButton* bt = [_imageSuperView viewWithTag:(i+10)];
        [bt setHidden:NO];
    }
    
	[_imageCount setText:[NSString stringWithFormat:@"(%ld/6)", (long)_imageIndex]];
	if (_imageIndex == 6) {
		[_addImageButton setHidden:YES];
		[_imageArray addObject:img];
    }else{
        image = [a objectAtIndex:_imageIndex];
        NSLayoutConstraint *c1 = [self findLayout:@"buttonX" superView:_imageSuperView];
        [_imageSuperView removeConstraint:c1];
        NSLayoutConstraint *c2 = [self findLayout:@"buttonY" superView:_imageSuperView];
        [_imageSuperView removeConstraint:c2];
        c1 = [NSLayoutConstraint constraintWithItem:_addImageButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:image attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        c1.identifier = @"buttonX";
        [_imageSuperView addConstraint:c1];
        c2 = [NSLayoutConstraint constraintWithItem:_addImageButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:image attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        c2.identifier = @"buttonY";
        [_imageSuperView addConstraint:c2];
        [_imageArray addObject:img];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(laterToMoveScrollView:) userInfo:nil repeats:NO];
    /*
    //==
    NSString* filePath = @"uploadfile/user/";
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *dateString = [formatter stringFromDate:date];
    NSString *fileName = [NSString stringWithFormat:@"%@_%lu_sale.png", dateString, _imageIndex];
    filePath = [filePath stringByAppendingString:fileName];
    
    WebPostClass *web = [[WebPostClass alloc] init];
    web.postID = 10;
    web.showLoadingBool = YES;
    web.delegate = self;
    [web updateImageAliyun:@"login/getOssSign" image:img filePath:filePath parameters:nil];
    //==
    */
}

- (void)getFilePath:(NSString *)filePath postID:(NSInteger)postID
{
    NSLog(@"filePath == %@", filePath);
    [_imagePathArray addObject:filePath];
    
    
    //==
//    if ([_imagePathArray count] == [_imageArray count])
//    {
//        NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//        [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//        [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//        [parameters_ setObject:_myTextView.text forKey:@"content"];
//        if ([_imagePathArray count] > 0) {
//            [parameters_ setObject:[NSString jsonStringWithArray:_imagePathArray] forKey:@"image"];
//        }
//        
//        WebPostClass *web = [[WebPostClass alloc] init];
//        web.postID = 1;
//        web.showLoadingBool = YES;
//        web.delegate = self;
//        [web getHttpData:@"bbs/add" parameters:parameters_];
//    }
}


- (IBAction)addImageAction:(id)sender {

    SelectPhoto *v = [[SelectPhoto alloc] init];
    v.delegate = self;
    [self addChildViewController:v];
    [self.view addSubview:v.view];
}


- (IBAction)delImageAction:(UIButton*)sender {
    
    NSInteger ii = sender.tag - 10;
    
    [_imageArray removeObjectAtIndex:ii];
//    [_imagePathArray removeObjectAtIndex:ii];
    
    NSArray *a = [_imageSuperView subviews];
    for (int i = 0; i < 6; i ++) {
        UIButton* bt = [_imageSuperView viewWithTag:(i+10)];
        [bt setHidden:YES];
        UIImageView *image = [a objectAtIndex:i];
        [image setImage:nil];
    }
    for (int i = 0; i < [_imageArray count]; i ++) {
        UIButton* bt = [_imageSuperView viewWithTag:(i+10)];
        [bt setHidden:NO];
        UIImageView *image = [a objectAtIndex:i];
        [image setImage:[_imageArray objectAtIndex:i]];
    }
    
    _imageIndex--;
    [_imageCount setText:[NSString stringWithFormat:@"(%ld/6)", (long)_imageIndex]];
    
    UIImageView *image = [a objectAtIndex:_imageIndex];
    NSLayoutConstraint *c1 = [self findLayout:@"buttonX" superView:_imageSuperView];
    [_imageSuperView removeConstraint:c1];
    NSLayoutConstraint *c2 = [self findLayout:@"buttonY" superView:_imageSuperView];
    [_imageSuperView removeConstraint:c2];
    c1 = [NSLayoutConstraint constraintWithItem:_addImageButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:image attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    c1.identifier = @"buttonX";
    [_imageSuperView addConstraint:c1];
    c2 = [NSLayoutConstraint constraintWithItem:_addImageButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:image attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    c2.identifier = @"buttonY";
    [_imageSuperView addConstraint:c2];
    
    [_addImageButton setHidden:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(laterToMoveScrollView:) userInfo:nil repeats:NO];
    
}

- (void)laterToMoveScrollView:(id)timer {
    CGFloat h0 = _scrollView.contentSize.width;
    CGFloat h1 = _scrollView.frame.size.width;
    CGFloat h = h0 - h1;
    if (h<0) {
        h = 0;
    }
    [_scrollView setContentOffset:CGPointMake(h, 0) animated:YES];
}

- (void)formatString:(NSString *)s {
	NSRange range;
	range = [s rangeOfString:@"\n"];
	if (range.location != NSNotFound) {
		NSLog(@"found at location = %d, length = %d", range.location, range.length);
		NSRange range2 = NSMakeRange(range.location, s.length - range.length);
		NSString *ss = [s substringWithRange:range2];
		NSLog(@"1");
		//[self formatString:[s substringWithRange:range]];
	}
	else {
		NSLog(@"Not Found");
	}
}

- (IBAction)helpAction:(UIButton*)sender {
    
    if (bHelp) {
        bHelp = NO;
        [sender setImage:[UIImage imageNamed:@"hlpe未选中"] forState:0];
    }else{
        bHelp = YES;
        [sender setImage:[UIImage imageNamed:@"hlpe选中"] forState:0];
    }
}

- (IBAction)submitAction:(id)sender {
	
	//网络请求
	if ([_myTextView.text length] == 0) {
        [IdentifierValidator showCancelAlert:self msg:@"内容不能为空"];
		return;
	}
    
    //==
	NSString *text = _myTextView.text;
	NSString *s = @"";
	for (int i = 0; i < 140; i++) {
		s = [s stringByAppendingString:@"\n"];
	}
	for (int i = 139; i > 2; i--) {
		NSString *ss = [s substringToIndex:i];
		text = [text stringByReplacingOccurrencesOfString:ss withString:@"\n\n"];
	}
	//去除两端空格
	NSString *temp = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	//去除两端空格和回车
	text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	/*
    NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
    [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
    [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
    [parameters_ setObject:text forKey:@"content"];
    if ([_imagePathArray count] > 0) {
        [parameters_ setObject:[NSString jsonStringWithArray:_imagePathArray] forKey:@"image"];
    }
    
    WebPostClass *web = [[WebPostClass alloc] init];
    web.postID = 1;
    web.showLoadingBool = YES;
    web.delegate = self;
    [web getHttpData:@"bbs/add" parameters:parameters_];
    //==
    */
    
    //==
//    if ([_imageArray count] > 0) {
//        for (UIImage* img in  _imageArray) {
//            NSString* filePath = @"uploadfile/user/";
//            NSDate *date = [NSDate date];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//            [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
//            NSString *dateString = [formatter stringFromDate:date];
//            NSString *fileName = [NSString stringWithFormat:@"%@_%lu_sale.png", dateString, _imageIndex];
//            filePath = [filePath stringByAppendingString:fileName];
//            
//            WebPostClass *web = [[WebPostClass alloc] init];
//            web.postID = 10;
//            web.showLoadingBool = YES;
//            web.delegate = self;
//            [web updateImageAliyun:@"login/getOssSign" image:img filePath:filePath parameters:nil];
//        }
//    }else{
//        NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//        [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//        [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//        [parameters_ setObject:text forKey:@"content"];
//        if ([_imagePathArray count] > 0) {
//            [parameters_ setObject:[NSString jsonStringWithArray:_imagePathArray] forKey:@"image"];
//        }
//        
//        WebPostClass *web = [[WebPostClass alloc] init];
//        web.postID = 1;
//        web.showLoadingBool = YES;
//        web.delegate = self;
//        [web getHttpData:@"bbs/add" parameters:parameters_];
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
	if (postID == 1) {
		
        [_delegate submitSuccess];
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (IBAction)controViewAction:(UIControl *)sender {
	[_myTextView resignFirstResponder];
}

@end

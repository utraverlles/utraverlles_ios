//
//  FootBall3_1.m
//  FootBall3
//
//
#import "NewsDetailViewController.h"
#import "NoteDetailCellViewController.h"
#import "NoteDetailCell2ViewController.h"
#import "DetailImageViewController.h"
#import "SelectPhoto.h"
//#import "FixCommunity.h"
#import "MsgView1.h"
#import "MsgView2.h"
//#import "MsgView15.h"
#import "STEmojiKeyboard.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <GPUImage/GPUImage.h>
#import "WebPostClass.h"

#define msgMaxk 100000


@interface NewsDetailViewController ()
@property (nonatomic) NSMutableArray *listArray;
@property (nonatomic) NSMutableArray *viewArray;
//@property (nonatomic) NSMutableArray *imageArray;
@property (nonatomic) NSMutableDictionary* commentDict;
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic, retain) NSString* pageNum;

@property (weak, nonatomic) IBOutlet UIScrollView *superScrollView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UIView *listView1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewY;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeight;
@property (weak, nonatomic) IBOutlet ALAutoResizingTextView *myTextView;
@property (weak, nonatomic) IBOutlet UIView *textViewBG;
@property (weak, nonatomic) IBOutlet UIView *textViewBG1;
@property (weak, nonatomic) IBOutlet UIView *textViewBG2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet UIControl *controlView;
@property (weak, nonatomic) IBOutlet UILabel *lbNavigationTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTextView;
@property (weak, nonatomic) IBOutlet UIImageView *ivTextView;
@property (weak, nonatomic) IBOutlet UILabel *lbXian;
@property (weak, nonatomic) IBOutlet UIImageView *ivEmoji;

@property (weak, nonatomic) IBOutlet UIView *listImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbFrom;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UILabel *lbHitsCount;
@property (weak, nonatomic) IBOutlet UILabel *lbCommentCount;
@property (weak, nonatomic) IBOutlet UILabel *lbLikeCount;
@property (weak, nonatomic) IBOutlet UIImageView *ivZan;
@property (weak, nonatomic) IBOutlet UIButton *btZan;
@property (weak, nonatomic) IBOutlet UIButton *btEdit;

@property (strong, nonatomic) STEmojiKeyboard *keyboard;

@property (nonatomic) NSMutableArray *cellArray;
@property (nonatomic) NoteDetailCellViewController *myNewsDetail;
@property (nonatomic) NSString *myReplyName;
@property (nonatomic) NSString *myReplyID;
@property (nonatomic) NSString *myCommentID;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;

- (IBAction)back:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)submitAction:(id)sender;
@property (nonatomic) NSDate *lastDate;
@end
@implementation NewsDetailViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
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
    
    
    {
//        NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//        if (User_Dict) {
//            [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//            [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//        }
//        [parameters_ setObject:_m_bbsID forKey:@"bbsID"];
//        [parameters_ setObject:@"10" forKey:@"pageNum"];
//        [parameters_ setObject:@"0" forKey:@"pageType"];
//        [parameters_ setObject:@"0" forKey:@"pageID"];
//        [parameters_ setObject:@"1" forKey:@"type"];
//        
//        WebPostClass *web = [[WebPostClass alloc] init];
//        web.postID = 3;
//        web.showLoadingBool = NO;
//        web.delegate = self;
//        [web getHttpData:@"bbs/getCommentList" parameters:parameters_];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
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
//    _myTextView.layer.masksToBounds = YES;
//    _myTextView.layer.cornerRadius = 5.0;
//    _myTextView.layer.borderWidth = 1.0;
//    _myTextView.layer.borderColor = [[UIColor colorWithRed:188 / 255.0 green:188 / 255.0 blue:188 / 255.0 alpha:1.0] CGColor];
    //    self.listArray = [[NSMutableArray alloc] init];
    self.viewArray = [[NSMutableArray alloc] init];
    
    _keyboard = [STEmojiKeyboard keyboard];
    
    
    
    
    //添加手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard:)];
    tapGestureRecognizer.delegate=self;
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [_myScrollView addGestureRecognizer:tapGestureRecognizer];
    
    //    UITapGestureRecognizer* showTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGes:)];
    //    showTap.delegate=self;//设置代理
    //    [_listView addGestureRecognizer:showTap];
    
    
    {
//        if ([[_m_dict objectForKey:@"user_id"] isEqual:[User_Dict objectForKey:@"id"]]) {
//            [_btEdit setHidden:NO];
//        }
//        
//        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
//        [dict setObject:_m_dict forKey:@"data"];
//        [dict setObject:@"0" forKey:@"code"];
//        [self getData:dict postID:1 error:nil];
    }
    
    {
//        NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//        if (User_Dict) {
//            [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//            [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//        }
//        [parameters_ setObject:_m_bbsID forKey:@"bbsID"];
//        [parameters_ setObject:_pageNum forKey:@"pageNum"];
//        [parameters_ setObject:@"0" forKey:@"pageType"];
//        [parameters_ setObject:@"0" forKey:@"pageID"];
//        [parameters_ setObject:@"0" forKey:@"type"];
//        
//        WebPostClass *web = [[WebPostClass alloc] init];
//        web.postID = 2;
//        web.showLoadingBool = YES;
//        web.delegate = self;
//        [web getHttpData:@"bbs/getCommentList" parameters:parameters_];
    }
    
    
    {
        NSMutableArray *photos = [[NSMutableArray alloc] init];
        NSMutableArray *thumbs = [[NSMutableArray alloc] init];
        for (int i = 0; i < [_imageArray count]; i ++) {
            //        NSString* image_path = [_imageArray objectAtIndex:i];
            //        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:image_path]]];
            //        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:image_path]]];
            UIImage* image_ = [_imageArray objectAtIndex:i];
            [photos addObject:[MWPhoto photoWithImage:image_]];
            [thumbs addObject:[MWPhoto photoWithImage:image_]];
        }
        self.photos = photos;
        self.thumbs = thumbs;
        
        if ([_imageArray count] == 1) {
            imageWidth = (self.view.bounds.size.width-20)/1;
        }else if ([_imageArray count] == 2){
            imageWidth = (self.view.bounds.size.width-20-(2-1)*10)/2;
        }else{
            imageWidth = (self.view.bounds.size.width-20-(3-1)*10)/3;
        }
        if ([_imageArray count] == 0) {
            [_viewHeight setConstant:0];
        }else{
            if ([_imageArray count] <= 3) {
                [_viewHeight setConstant:imageWidth*1+(1-1)*10];
                [_viewWidth setConstant:imageWidth*[_imageArray count]+([_imageArray count]-1)*10];
            }else{
                [_viewHeight setConstant:imageWidth*2+(2-1)*10];
                if ([_imageArray count] == 4)
                    [_viewWidth setConstant:imageWidth*2+(2-1)*10];
                else
                    [_viewWidth setConstant:imageWidth*3+(3-1)*10];
            }
        }
    }
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
        NSDictionary *d = [dict objectForKey:@"data"];
        NSString* sid = [d objectForKey:@"id"];
        NSString* content = [d objectForKey:@"content"];
        NSString* image_path = [d objectForKey:@"image_path"];
        NSArray* image = [d objectForKey:@"image"];
        NSString* add_time = [d objectForKey:@"add_time"];
        NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[add_time floatValue]/1];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        add_time = [formatter stringFromDate:dt];
        NSString* status = [d objectForKey:@"status"];
        NSString* type = [d objectForKey:@"type"];
        NSString* user_id = [d objectForKey:@"user_id"];
        NSString* user_name = [d objectForKey:@"user_name"];
        NSString* user_image = [d objectForKey:@"user_image"];
        user_image = [image_path stringByAppendingString:user_image];
        NSString* likeCount = [d objectForKey:@"likeCount"];
        NSString* commentCount = [d objectForKey:@"commentCount"];
        NSString* hitsCount = [d objectForKey:@"hitsCount"];
        NSString* is_like = [d objectForKey:@"is_like"];
        NSString* is_comment = [d objectForKey:@"is_comment"];
        NSString* style_list = [d objectForKey:@"style_list"];
        NSString* style_content = [d objectForKey:@"style_content"];
        NSMutableArray* imageArr = [[NSMutableArray alloc] init];
        for (NSString* s in image) {
            NSString* ss = [[image_path stringByAppendingString:s] stringByAppendingString:style_content];
            [imageArr addObject:ss];
        }
        
        
        _lbName.text = user_name;
        _lbContent.text = content;
        _lbTime.text = add_time;
        _lbHitsCount.text = hitsCount;
        _lbCommentCount.text = commentCount;
        _lbLikeCount.text = likeCount;
        if ([is_like intValue]) {
            [_ivZan setHidden:NO];
            [_btZan setEnabled:NO];
        }
        [_ivLogo sd_setImageWithURL:[NSURL URLWithString:user_image] completed: ^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (img == nil) {
                [_ivLogo setImage:[UIImage imageNamed:@"默认头像.png"]];
            }
        }];
        
        
//        [self createImage:imageArr];
    }
    if (postID == 2){
        
        NSDictionary *d = [dict objectForKey:@"data"];
        NSArray * arr = [d objectForKey:@"list"];
        [self createData:arr];
        
    }
    if (postID == 3){
        
    }
    if (postID == 4){
        
        NSDictionary *d = [dict objectForKey:@"data"];
        NSString *sid = [d objectForKey:@"id"];
        
        
        
        if (_myNewsDetail) {
            
            NSMutableDictionary* dict = self.commentDict;
            NSMutableArray *a = [[NSMutableArray alloc] init];
            [a addObject:dict];
            
            [_myNewsDetail createData:a];
            
        }else{
            
            NSMutableDictionary* dict = self.commentDict;
            NSMutableDictionary* udict = dict.mutableCopy;
            [udict setObject:sid forKey:@"id"];
            dict = udict;
            
            NSMutableArray *a = [[NSMutableArray alloc] init];
            [a addObject:dict];
            
            [self createNewData:a];
            
        }
        
        [_myTextView setText:@""];
        [_myTextView resignFirstResponder];
        
    }
    
    if (postID == 5){
        
        NSDictionary *d = [dict objectForKey:@"data"];
        NSString *sid = [d objectForKey:@"id"];
        
        NSMutableDictionary* dict = self.commentDict;
        NSMutableArray *a = [[NSMutableArray alloc] init];
        [a addObject:dict];
        
        [_myNewsDetail createData:a];
        _myNewsDetail = nil;
    }
    
    
    if (postID == 6){
        _lbLikeCount.text = [NSString stringWithFormat:@"%d", [_lbLikeCount.text intValue]+1];
        [_ivZan setHidden:NO];
        [_btZan setEnabled:NO];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"点赞成功";
        hud.labelFont = [UIFont systemFontOfSize:13];
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateCommunity" object:nil];
    }
    
    
    if (postID == 7) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateCommunity" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if (postID == 8) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

- (void)createImage:(NSArray *)dataArray{
    if ([dataArray count] == 0) {
        return;
    }
    
    //先清除原来的VIEW
    UIView *view = _listImageView;
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    _imageArray = viewArray;
    
    UIView *s_v = nil;
    if ([[view subviews] count] > 0) {
        s_v = [[view subviews] lastObject];
    }
    else {
        NSArray *a = [view constraints];
        [view removeConstraints:a];
    }
    for (int i = 0; i < [dataArray count]; i++) {
        
        NSString* img = [dataArray objectAtIndex:i];
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NoteDetailViewController" bundle:nil];
        DetailImageViewController *v = (DetailImageViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"DetailImageViewController"];
        [self addChildViewController:v];
        UIView *vv = [[v.view subviews] objectAtIndex:0];
        [view addSubview:vv];
        v.superViewCon = self;
        [viewArray addObject:vv];
        
        [v.ivLogo sd_setImageWithURL:[NSURL URLWithString:img] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil) {
                [self updateImage:image];
            }
        }];
        
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            //X居中
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            //等宽
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
            //距离上一个的高度
            NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
            [view addConstraint:c1];
            [view addConstraint:c2];
            [view addConstraint:c4];
            s_v = v;
            k++;
            continue;
        }
        NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        //等宽
        NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        //距离上一个的高度
        NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        [view addConstraint:c1];
        [view addConstraint:c2];
        [view addConstraint:c4];
        s_v = v;
        k++;
    }
    
    if(s_v != nil)
    {
        NSLayoutConstraint *c1 = [self findLayout:@"end" superView:view];
        [view removeConstraint:c1];
        //让SUPERVIEW的底 = 最后一个VIEW的底
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        c3.identifier = @"end";
        [view addConstraint:c3];
    }
    
}

- (void)updateImage:(UIImage *)img{
    
    NSMutableArray *viewArray = _imageArray;
    for (UIView *v in viewArray) {
        
        UIImageView *vv = [[v subviews] objectAtIndex:0];
        if (vv.image == img) {
            CGSize size = img.size;
            float scale = size.height / size.width;
            float height = [UIScreen mainScreen].bounds.size.width * scale;
            NSLayoutConstraint *sizeCon = [self findLayout:@"Height" superView:v];
            [sizeCon setConstant:height];
        }
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
        if (s_v.tag == 1025) {
            [s_v removeFromSuperview];
            s_v = [[view subviews] lastObject];
        }
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
        
        
        if (s_v == nil && i == 0) {
            pageFirstID = sid;
        }
        pageLastID = sid;
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:20];
            c1.identifier = @"start";
            //等宽
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
            
            NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
            NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
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
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
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
    
    if ([dataArray count] >= [_pageNum integerValue]) {
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LoadMore" bundle:nil];
        UIViewController *v = (UIViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"LoadMore"];
        UIView *vv = [[v.view subviews] objectAtIndex:0];
        [view addSubview:vv];
        
        vv.tag = 1024;
        [[[vv subviews] objectAtIndex:0] setHidden:NO];
        [[[vv subviews] objectAtIndex:1] setHidden:YES];
        [[[vv subviews] objectAtIndex:2] setHidden:YES];
        
        NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:vv attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        //等宽
        NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:vv attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        //距离上一个的高度
        NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:vv attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [view addConstraint:c1];
        [view addConstraint:c2];
        [view addConstraint:c4];
        s_v = vv;
    }
    
    
    if(s_v != nil)
    {
        NSLayoutConstraint *c1 = [self findLayout:@"end" superView:view];
        [view removeConstraint:c1];
        //让SUPERVIEW的底 = 最后一个VIEW的底
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
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



- (void)createNewData:(NSArray *)dataArray {
    
    if ([dataArray count] == 0) {
        return;
    }
    
    UIView *view = _listView1;
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    
    UIView *s_v = nil;
    if ([[view subviews] count] > 0) {
        s_v = [[view subviews] firstObject];
    }
    else {
        NSArray *a = [view constraints];
        [view removeConstraints:a];
    }
    
    for (int i = 0; i < [dataArray count]; i++) {
        NSDictionary *d = [dataArray objectAtIndex:i];
//        NSString* sid = [d objectForKey:@"id"];
//        NSString* user_name = [d objectForKey:@"user_name"];
        NSString* content = [d objectForKey:@"content"];
//        NSString* likeCount = [d objectForKey:@"likeCount"];
//        NSString* userID = [d objectForKey:@"userID"];
//        NSString* add_time = [d objectForKey:@"add_time"];
//        NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[add_time floatValue]/1];
//        NSString* image_path = [d objectForKey:@"image_path"];
//        NSString* image = [d objectForKey:@"image"];
//        image = [image_path stringByAppendingString:image];
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NoteDetailViewController" bundle:nil];
        NoteDetailCellViewController *v = (NoteDetailCellViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"NoteDetailCellViewController"];
        v.m_dict = d;
        [self addChildViewController:v];
        UIView *vv = [[v.view subviews] objectAtIndex:0];
        [view insertSubview:vv atIndex:i];
        [viewArray addObject:vv];
        
        v.selfView = vv;
        v.delegate = self;
        v.superViewCon = self;
//        v.lbName.text = user_name;
        v.lbContent.text = content;
//        v.lbCount.text = likeCount;
//        v.lbTime.text = [self compareCurrentTime:dt];
//        [v.ivLogo sd_setImageWithURL:[NSURL URLWithString:image] completed: ^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (img == nil) {
//                [v.ivLogo setImage:[UIImage imageNamed:@"默认头像.png"]];
//            }
//        }];
        
//        if (i == 0) {
//            pageFirstID = sid;
//        }
        
    }
    
    if(s_v != nil)
    {
        NSLayoutConstraint *c1 = [self findLayout:@"start" superView:view];
        [view removeConstraint:c1];
        
        UIView *v = [viewArray lastObject];
        //距离上一个的高度
        NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:s_v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [view addConstraint:c4];
        
        s_v = nil;
        
        int k = 0;
        for (UIView *v in viewArray) {
            if (s_v == nil) {
                //X居中
                NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
                //等宽
                NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
                //距离上一个的高度
                NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
                c4.identifier = @"start";
                [view addConstraint:c1];
                [view addConstraint:c2];
                [view addConstraint:c4];
                s_v = v;
                k++;
                continue;
            }
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            //等宽
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
            //距离上一个的高度
            NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            [view addConstraint:c1];
            [view addConstraint:c2];
            [view addConstraint:c4];
            s_v = v;
            k++;
        }
    }else{
        
        int k = 0;
        for (UIView *v in viewArray) {
            if (s_v == nil) {
                
                NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
                c1.identifier = @"start";
                //等宽
                NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
                
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
        
        if(s_v != nil)
        {
            NSLayoutConstraint *c1 = [self findLayout:@"end" superView:view];
            [view removeConstraint:c1];
            //让SUPERVIEW的底 = 最后一个VIEW的底
            NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            c3.identifier = @"end";
            [view addConstraint:c3];
        }
    }
    
    
    
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
    [_ivTextView setHidden:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == _superScrollView) {
        return;
    }
    if (scrollView.contentOffset.y < 0){
        {
            
//                {
//                UIView *view = _listView1;
//                NSArray *subArray = [view subviews];
//                for (UIView *v in subArray) {
//                    [v removeFromSuperview];
//                }
            
//                NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//                if (User_Dict) {
//                    [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//                    [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//                }
//                [parameters_ setObject:_m_bbsID forKey:@"bbsID"];
//                [parameters_ setObject:_pageNum forKey:@"pageNum"];
//                [parameters_ setObject:@"0" forKey:@"pageType"];
//                [parameters_ setObject:@"0" forKey:@"pageID"];
//                [parameters_ setObject:@"0" forKey:@"type"];
//                
//                WebPostClass *web = [[WebPostClass alloc] init];
//                web.postID = 2;
//                web.showLoadingBool = YES;
//                web.delegate = self;
//                [web getHttpData:@"bbs/getCommentList" parameters:parameters_];
//            }
            
        }
    }
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == _superScrollView) {
        
        CGFloat pageWidth = scrollView.frame.size.width;
        self.pageIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        return;
    }
    
    if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height){
        
        UIView *view = _listView1;
        if ([[view subviews] count] > 0) {
            UIView *vv = [[view subviews] lastObject];
            if (vv.tag == 1024) {
                vv.tag = 1025;
//                [[[vv subviews] objectAtIndex:0] setHidden:YES];
//                [[[vv subviews] objectAtIndex:1] setHidden:NO];
//                [[[vv subviews] objectAtIndex:2] setHidden:YES];
                
                
//                NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//                if (User_Dict) {
//                    [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//                    [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//                }
//                [parameters_ setObject:_m_bbsID forKey:@"bbsID"];
//                [parameters_ setObject:_pageNum forKey:@"pageNum"];
//                [parameters_ setObject:@"2" forKey:@"pageType"];
//                [parameters_ setObject:pageLastID forKey:@"pageID"];
//                [parameters_ setObject:@"0" forKey:@"type"];
//                
//                WebPostClass *web = [[WebPostClass alloc] init];
//                web.postID = 2;
//                web.showLoadingBool = YES;
//                web.delegate = self;
//                [web getHttpData:@"bbs/getCommentList" parameters:parameters_];
                
            }
        }
        
    }
    
}


- (IBAction)tabAction:(UIButton *)sender {
    
    CGFloat scrollViewWidth = _superScrollView.contentSize.width;
    self.pageIndex = sender.tag - 10;
    [_superScrollView setContentOffset:CGPointMake(scrollViewWidth / 2.0 * self.pageIndex, 0) animated:YES];
    
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
    _lbTextView.text = @"COMMENT";
    [_lbTextView setHidden:NO];
    [_ivTextView setHidden:NO];
    [_textViewBG1 setHidden:NO];
    [_textViewBG2 setHidden:YES];
    
    //获取键盘的高度
    //    NSDictionary *userInfo = [aNotification userInfo];
    //    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //    CGRect keyboardRect = [aValue CGRectValue];
    //    float height = keyboardRect.size.height;
    
    if (_myNewsDetail)
    {
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
    }else{
        
        int fheight = _myScrollView.contentSize.height - myScrollViewContentH;
        if(fheight > 0)
        {
            float hh = _listView1.frame.origin.y - 40;
            if (hh + myScrollViewFrameH > _myScrollView.contentSize.height) {
                hh = _myScrollView.contentSize.height - myScrollViewFrameH;
            }
            if (hh < 0) {
                hh = 0;
            }
            [_myScrollView setContentOffset:CGPointMake(0, hh) animated:YES];
        }
        
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
    [self.textViewBG setNeedsLayout];
    [UIView animateWithDuration:duration delay:0.0f options:animationOptions animations: ^{
        [self.textViewBG layoutIfNeeded];
    } completion:nil];
    
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    
    if(!_controlView.isHidden) return;
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
    
    if (_myNewsDetail) {
        
        float h2 = _myNewsDetail.listY + _myNewsDetail.selfView.frame.origin.y + _myNewsDetail.selfView.superview.frame.origin.y;
        float hh = h2 + height - myScrollViewFrameH;
        if (hh < 0) {
            hh = 0;
        }
        
        [_myScrollView setContentOffset:CGPointMake(0, hh) animated:YES];
    }else{
        float h1 = 0;
        if (_myScrollView.contentSize.height < myScrollViewFrameH) {
            if (_myScrollView.contentSize.height + height < myScrollViewFrameH) {
                h1 = 0;
            }else if (_myScrollView.contentSize.height + height >= myScrollViewFrameH) {
                h1 = _myScrollView.contentSize.height + height - myScrollViewFrameH;
            }
        }else{
            
            h1 = height;
        }
        
        float hh = _myScrollView.contentOffset.y + h1;
        [_myScrollView setContentOffset:CGPointMake(0, hh) animated:YES];
    }
    
    
    myScrollViewContentH = _myScrollView.contentSize.height;
    //    NSLog(@"keyboardWillShow height == %f", _myScrollView.contentSize.height);
    
}

- (void)closeKeyBoard:(id)sender {
    NSLog(@"closeKeyBoard===");
    
    //    [_myTextView resignFirstResponder];
}

//- (void)showGes:(id)sender {
//    NSLog(@"showGes===");
//
//}

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

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}



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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//表情
- (IBAction)emojiAction:(UIButton *)button {
    
    if (button.tag == 1){
        self.myTextView.inputView = nil;
        [_ivEmoji setImage:[UIImage imageNamed:@"表情"]];
    }
    else{
        [_keyboard setTextView:self.myTextView];
        [_ivEmoji setImage:[UIImage imageNamed:@"btn_keyboard"]];
    }
    [self.myTextView reloadInputViews];
    button.tag = (button.tag+1)%2;
//    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[button.tag]] forState:UIControlStateNormal];
    [_myTextView becomeFirstResponder];
}

//分享
- (IBAction)shareAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView2" bundle:nil];
    MsgView2 *msgView = (MsgView2*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView2"];
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}

//点赞
- (IBAction)likesAction:(UIButton*)sender {
    
    _bLikes = _bLikes ? NO : YES;
    if (_bLikes) {
        [sender setImage:[UIImage imageNamed:@"圆圈收藏icon红色"] forState:0];
    }else{
        [sender setImage:[UIImage imageNamed:@"圆圈icon002"] forState:0];
    }
}

//收藏
- (IBAction)collectAction:(id)sender {
    
    _bCollect = _bCollect ? NO : YES;
    if (_bCollect) {
        [sender setImage:[UIImage imageNamed:@"圆圈收藏icon橙色"] forState:0];
    }else{
        [sender setImage:[UIImage imageNamed:@"圆圈icon004"] forState:0];
    }
}

- (IBAction)rightAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView1" bundle:nil];
    MsgView1 *msgView = (MsgView1*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView1"];
    msgView.delegate = self;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}

- (void)changePhotos:(UIImage *)img {
    NSLog(@"图片已经选择");
    NSMutableArray *a = [[NSMutableArray alloc] init];
    NSNumber *group = [NSNumber numberWithInt:3];
    NSDictionary *dic = @{ @"img":img, @"group":group, @"logo":@"11111", @"date":[NSDate date] };
    [a addObject:dic];
    [self createData:a];
    [_myTextView setText:@""];
    [_myTextView resignFirstResponder];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(laterToMoveScrollView:) userInfo:nil repeats:NO];
    
    //    NSMutableArray *array = [[NSMutableArray alloc] init];
    //    [array addObject:img];
    //    WebPostClass *web = [[WebPostClass alloc] init];
    //    web.delegate = self;
    //    [web updateImage:array];
    
    NSLog(@"img.size.width==%f  img.size.height==%f", img.size.width, img.size.height);
}

- (IBAction)selectPhoto:(id)sender {
    SelectPhoto *v = [[SelectPhoto alloc] init];
    v.delegate = self;
    [self addChildViewController:v];
    [self.view addSubview:v.view];
}

- (IBAction)submitAction:(id)sender {
    
    
//    if (!User_Dict) {
//        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView13" bundle:nil];
//        UIViewController *msgView = [secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView13"];
//        [self addChildViewController:msgView];
//        [self.view addSubview:msgView.view];
//        
//        return;
//    }
    
    if ([_myTextView.text length] == 0) {
        return;
    }
    
    
    if (_myNewsDetail) {
        
        NSString* add_time = [NSString stringWithFormat:@"%lf", ([[NSDate date] timeIntervalSince1970])*1];
//        NSString* user_name = [User_Dict objectForKey:@"user_name"];
//        NSString* userID = [User_Dict objectForKey:@"id"];
        NSString* parent_name = _myReplyName;
        NSString* parentID = _myReplyID;
        NSString* commentID = _myCommentID;
        NSString* content = [_myTextView text];
        
        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
        [dict setObject:add_time forKey:@"add_time"];
//        [dict setObject:user_name forKey:@"user_name"];
//        [dict setObject:userID forKey:@"userID"];
        [dict setObject:parent_name forKey:@"to_user_name"];
        [dict setObject:parentID forKey:@"to_user_id"];
        [dict setObject:content forKey:@"content"];
        [dict setObject:commentID forKey:@"id"];
        
        self.commentDict = dict;
        
        
        {
//            NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//            [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//            [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//            [parameters_ setObject:_m_bbsID forKey:@"bbsID"];
//            [parameters_ setObject:content forKey:@"content"];
//            [parameters_ setObject:commentID forKey:@"parent_id"];
//            if ([parentID length] > 0) {
//                [parameters_ setObject:parentID forKey:@"toUserID"];
//            }
//            
//            WebPostClass *web = [[WebPostClass alloc] init];
//            web.postID = 4;
//            web.showLoadingBool = YES;
//            web.delegate = self;
//            [web getHttpData:@"bbs/addComment" parameters:parameters_];
            
           
            NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
            [parameters_ setObject:@"0" forKey:@"code"];
            NSMutableDictionary *data_ = [[NSMutableDictionary alloc] init];
            [data_ setObject:@"0" forKey:@"id"];
            [parameters_ setObject:data_ forKey:@"data"];
            [self getData:parameters_ postID:4 error:nil];
        }
        
    }else{
        
        NSString* add_time = [NSString stringWithFormat:@"%lf", ([[NSDate date] timeIntervalSince1970])*1];
//        NSString* image_path = [User_Dict objectForKey:@"image_path"];
//        NSString* image = [User_Dict objectForKey:@"image"];
//        NSString* user_name = [User_Dict objectForKey:@"user_name"];
//        NSString* userID = [User_Dict objectForKey:@"id"];
        NSString* content = [_myTextView text];
        NSString* likeCount = @"0";
        NSString* is_like = @"0";
        
        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
        [dict setObject:add_time forKey:@"add_time"];
//        [dict setObject:image_path forKey:@"image_path"];
//        [dict setObject:image forKey:@"image"];
//        [dict setObject:user_name forKey:@"user_name"];
        [dict setObject:@"Dylan Stanley" forKey:@"user_name"];
//        [dict setObject:userID forKey:@"userID"];
        [dict setObject:content forKey:@"content"];
        [dict setObject:likeCount forKey:@"likeCount"];
        [dict setObject:is_like forKey:@"is_like"];
        
        self.commentDict = dict;
        
        {
//            NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//            [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//            [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//            [parameters_ setObject:_m_bbsID forKey:@"bbsID"];
//            [parameters_ setObject:content forKey:@"content"];
//            
//            WebPostClass *web = [[WebPostClass alloc] init];
//            web.postID = 4;
//            web.showLoadingBool = YES;
//            web.delegate = self;
//            [web getHttpData:@"bbs/addComment" parameters:parameters_];
            
            NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
            [parameters_ setObject:@"0" forKey:@"code"];
            NSMutableDictionary *data_ = [[NSMutableDictionary alloc] init];
            [data_ setObject:@"0" forKey:@"id"];
            [parameters_ setObject:data_ forKey:@"data"];
            [self getData:parameters_ postID:4 error:nil];
        }
    }
    
    
}


- (IBAction)zanAction:(id)sender{
    
//    if (!User_Dict) {
//        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView13" bundle:nil];
//        UIViewController *msgView = [secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView13"];
//        [self addChildViewController:msgView];
//        [self.view addSubview:msgView.view];
//        
//        return;
//    }
//    
//    NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//    [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//    [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//    [parameters_ setObject:_m_bbsID forKey:@"bbsID"];
//    
//    WebPostClass *web = [[WebPostClass alloc] init];
//    web.postID = 6;
//    web.showLoadingBool = NO;
//    web.delegate = self;
//    [web getHttpData:@"bbs/addLike" parameters:parameters_];
}


- (IBAction)editAction:(UIButton *)sender {
    
//    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView15" bundle:nil];
//    MsgView15 *msgView = (MsgView15*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView15"];
//    msgView.delegate = self;
//    [self addChildViewController:msgView];
//    [self.view addSubview:msgView.view];
    [_textViewBG1 setHidden:YES];
    [_textViewBG2 setHidden:NO];
    [_myTextView becomeFirstResponder];
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

- (void)sendTextView:(UIViewController*)vc parentName:(NSString*)parentName parentID:(NSString*)parentID commentID:(NSString*)commentID content:(NSString*)content
{
    
    _myNewsDetail = vc;
    _myReplyName = parentName;
    _myReplyID = parentID;
    _myCommentID = commentID;
   
    NSString* add_time = [NSString stringWithFormat:@"%lf", ([[NSDate date] timeIntervalSince1970])*1];
    //        NSString* user_name = [User_Dict objectForKey:@"user_name"];
    //        NSString* userID = [User_Dict objectForKey:@"id"];
    NSString* parentName0 = _myReplyName;
    NSString* parentID0 = _myReplyID;
    NSString* commentID0 = _myCommentID;
    NSString* content0 = content;
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:add_time forKey:@"add_time"];
    //        [dict setObject:user_name forKey:@"user_name"];
    [dict setObject:@"Dylan Stanley" forKey:@"user_name"];
    //        [dict setObject:userID forKey:@"userID"];
    [dict setObject:parentName0 forKey:@"to_user_name"];
//    [dict setObject:parentID0 forKey:@"to_user_id"];
//    [dict setObject:commentID0 forKey:@"id"];
    [dict setObject:content0 forKey:@"content"];
    
    self.commentDict = dict;
    
    
    {
        //            NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
        //            [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
        //            [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
        //            [parameters_ setObject:_m_bbsID forKey:@"bbsID"];
        //            [parameters_ setObject:content forKey:@"content"];
        //            [parameters_ setObject:commentID forKey:@"parent_id"];
        //            if ([parentID length] > 0) {
        //                [parameters_ setObject:parentID forKey:@"toUserID"];
        //            }
        //
        //            WebPostClass *web = [[WebPostClass alloc] init];
        //            web.postID = 4;
        //            web.showLoadingBool = YES;
        //            web.delegate = self;
        //            [web getHttpData:@"bbs/addComment" parameters:parameters_];
        
        
        NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
        [parameters_ setObject:@"0" forKey:@"code"];
        NSMutableDictionary *data_ = [[NSMutableDictionary alloc] init];
        [data_ setObject:@"0" forKey:@"id"];
        [parameters_ setObject:data_ forKey:@"data"];
        [self getData:parameters_ postID:5 error:nil];
    }
}


#pragma MsgView15Delegate
- (void)editNote
{
//    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FixCommunity" bundle:nil];
//    FixCommunity *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FixCommunity"];  //
//    door.delegate = self;
//    door.m_dict = _m_dict;
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    [self.navigationController pushViewController:door animated:YES];
}

- (void)delNote
{
//    NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//    [parameters_ setObject:[User_Dict objectForKey:@"id"] forKey:@"userID"];
//    [parameters_ setObject:[User_Dict objectForKey:@"token"] forKey:@"token"];
//    [parameters_ setObject:_m_bbsID forKey:@"bbsID"];
//    
//    WebPostClass *web = [[WebPostClass alloc] init];
//    web.postID = 7;
//    web.showLoadingBool = YES;
//    web.delegate = self;
//    [web getHttpData:@"bbs/delete" parameters:parameters_];
}

#pragma FixCommunityDelegate
- (void)fixSuccess:(NSString*)content imgArr:(NSArray*)imgArr
{
    NSMutableDictionary* d = _m_dict.mutableCopy;
    [d setObject:content forKey:@"content"];
    [d setObject:imgArr forKey:@"image"];
    _m_dict = d;
    
    UIView *view = _listImageView;
    NSArray *subArray = [view subviews];
    for (UIView *v in subArray) {
        [v removeFromSuperview];
    }
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:_m_dict forKey:@"data"];
    [dict setObject:@"0" forKey:@"code"];
    [self getData:dict postID:1 error:nil];
}




#pragma UICollectionView
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_imageArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"imageCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //    NSString* image_path = [_imageArray objectAtIndex:indexPath.row];
    //    UIImageView* ivLogo = (UIImageView*)[cell viewWithTag:2000];
    //    [ivLogo sd_setImageWithURL:[NSURL URLWithString:image_path] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        if (image == nil) {
    //        }
    //    }];
    UIImage* image_ = [_imageArray objectAtIndex:indexPath.row];
    UIImageView* ivLogo = (UIImageView*)[cell viewWithTag:2000];
    [ivLogo setImage:image_];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(imageWidth-2, imageWidth-2);
}

//定义每个UICollectionView 的 margin
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    //    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ShowImage" bundle:nil];
    //    ShowImage *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ShowImage"];
    //    door.m_list = _imageArray;
    //    door.row = indexPath.row;
    //    [self.navigationController pushViewController:door animated:YES];
    
    // Browser
    //    MWPhoto *photo, *thumb;
    BOOL displayActionButton = NO;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = NO;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:indexPath.row];
    
    // Reset selections
    if (displaySelectionButtons) {
        _selections = [NSMutableArray new];
        for (int i = 0; i < _photos.count; i++) {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
    }
    
    // Push
    [self.navigationController pushViewController:browser animated:YES];
    //    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    //    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:nc animated:YES completion:nil];
    
}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

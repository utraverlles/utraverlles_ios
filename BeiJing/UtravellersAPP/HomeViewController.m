//
//  HomeViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/14.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "HomeViewController.h"
#import "CommunityCellViewController.h"
#import "EditCommunity.h"
#import "RefreshImage.h"
#import "EditGroupViewController.h"
#import "SelectCityViewController.h"
#import "HomeSearchViewController.h"
#import "MsgView12.h"
#import "WMPlayer.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet RefreshImage *ivRefresh;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;

@property (nonatomic) NSArray *listArray;
@property (nonatomic) WMPlayer *wmPlayer;
@property (nonatomic) UIViewController *currentVC;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EditCommunity:) name:@"EditCommunity" object:nil];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    //关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeTheVideo:)
                                                 name:@"closeTheVideo"
                                               object:nil];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
     
    self.listArray = @[@{@"id":@"1", @"video":@{@"cover":@"http://vimg2.ws.126.net/image/snapshot/2016/10/0/3/VC2OAUG03.jpg",@"mp4_url":@"http://flv2.bn.netease.com/videolib3/1610/18/fHtPu8349/SD/fHtPu8349-mobile.mp4"}},
                      @{@"id":@"1"}, @{@"id":@"1"}, @{@"id":@"1"}];
    
    [self createData:_listArray];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    {
        BOOL isFirstLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLogin"];
        if (!isFirstLogin) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLogin"];
            
            UIStoryboard* secondStoryBoard = [UIStoryboard storyboardWithName:@"LoginViewController" bundle:nil];
            UIViewController *msgView = (UIViewController*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.navigationController addChildViewController:msgView];
            [self.navigationController.view addSubview:msgView.view];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)videoDidFinished:(NSNotification *)notice{
    CommunityCellViewController* currentCell = (CommunityCellViewController*)_currentVC;
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [_wmPlayer removeFromSuperview];
}

-(void)fullScreenBtnClick:(NSNotification *)notice{
    
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        [self toCell];
    }
}

-(void)closeTheVideo:(NSNotification *)obj{
    CommunityCellViewController* currentCell = (CommunityCellViewController*)_currentVC;
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
}


/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    
    if (_wmPlayer==nil||_wmPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            
            if (_wmPlayer.isFullscreen) {
                [self toCell];
            }
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            if (_wmPlayer.fullScreenBtn.selected == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
            
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            if (_wmPlayer.fullScreenBtn.selected == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
            
        }
            break;
        default:
            break;
    }
}


-(void)toCell{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
//    VideoCell *currentCell = [self currentCell];
    CommunityCellViewController* currentCell = (CommunityCellViewController*)_currentVC;
    
    [_wmPlayer removeFromSuperview];
//    NSLog(@"row = %ld",currentIndexPath.row);
    [UIView animateWithDuration:0.5f animations:^{
        _wmPlayer.transform = CGAffineTransformIdentity;
        _wmPlayer.frame = currentCell.backgroundIV.bounds;
        _wmPlayer.playerLayer.frame =  _wmPlayer.bounds;
        
        [currentCell.backgroundIV addSubview:_wmPlayer];
        [currentCell.backgroundIV bringSubviewToFront:_wmPlayer];
        
        [_wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmPlayer).with.offset(0);
            make.right.equalTo(_wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_wmPlayer).with.offset(0);
            
        }];
        
        [_wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_wmPlayer).with.offset(5);
            
        }];
        
        
    }completion:^(BOOL finished) {
        _wmPlayer.isFullscreen = NO;
        _wmPlayer.fullScreenBtn.selected = NO;
//        [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
    }];
    
}
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
    [_wmPlayer removeFromSuperview];
    
    _wmPlayer.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.5 animations:^{
        if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
            _wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
            _wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        _wmPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _wmPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.height,self.view.frame.size.width);
        
        [[UIApplication sharedApplication].keyWindow addSubview:_wmPlayer];
        [_wmPlayer bringSubviewToFront:_wmPlayer.bottomView];
        
        [_wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.view.frame.size.width-40);
            make.width.mas_equalTo(self.view.frame.size.height);
        }];
        
        [_wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_wmPlayer).with.offset((-self.view.frame.size.height/2));
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_wmPlayer).with.offset(5);
            
        }];
    } completion:^(BOOL finished) {
       
        _wmPlayer.isFullscreen = YES;
        _wmPlayer.fullScreenBtn.selected = YES;
        [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
    }];
    
    
//    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
//        _wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
//    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
//        _wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
//    }
//    _wmPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    _wmPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.height,self.view.frame.size.width);
    
//    [_wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(40);
//        make.top.mas_equalTo(self.view.frame.size.width-40);
//        make.width.mas_equalTo(self.view.frame.size.height);
//    }];
//    
//    [_wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_wmPlayer).with.offset((-self.view.frame.size.height/2));
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(30);
//        make.top.equalTo(_wmPlayer).with.offset(5);
//        
//    }];
    
    
//    [[UIApplication sharedApplication].keyWindow addSubview:_wmPlayer];
//    _wmPlayer.isFullscreen = YES;
//    _wmPlayer.fullScreenBtn.selected = YES;
//    [_wmPlayer bringSubviewToFront:_wmPlayer.bottomView];
    
}

//编辑帖子
- (void)EditCommunity:(NSNotification *)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"EditCommunity" bundle:nil];
    EditCommunity *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"EditCommunity"];  //
    door.delegate = self;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

//编辑组
- (IBAction)groupAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView12" bundle:nil];
    MsgView12 *msgView = (MsgView12*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView12"];
    msgView.delegate = self;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}

//选择城市
- (IBAction)selectAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"SelectCityViewController" bundle:nil];
    SelectCityViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectCityViewController"];  //
    door.delegate = self;
    door.m_titleName = _lbCity.text;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

//搜索
- (IBAction)searchAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"HomeSearchViewController" bundle:nil];
    HomeSearchViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"HomeSearchViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

- (void)createData:(NSArray *)dataArray {
    //    if ([dataArray count] == 0) {
    //        return;
    //    }
    
    UIView *view = _listView;
    
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    
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
        NSDictionary* video = [d objectForKey:@"video"];

        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"CommunityCellViewController" bundle:nil];
        CommunityCellViewController *v = (CommunityCellViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"CommunityCellViewController"];
        v.delegate = self;
        v.superViewCon = self;
        v.videoDict = video;
        v.imageArray = @[[UIImage imageNamed:@"美女图"], [UIImage imageNamed:@"美女图"], [UIImage imageNamed:@"美女图"], [UIImage imageNamed:@"美女图"]];
        [self addChildViewController:v];
        UIView *vv = [[v.view subviews] objectAtIndex:0];
        [view addSubview:vv];
        [viewArray addObject:vv];
        
         v.m_dict = d;
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
           
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
            
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
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
        NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
        
        NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
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

- (NSLayoutConstraint *)findLayout:(NSString *)nameID superView:(UIView *)superView {
    NSArray *a = [superView constraints];
    for (NSLayoutConstraint *aa in a) {
        if ([aa.identifier isEqualToString:nameID]) {
            return aa;
        }
    }
    return nil;
}

     
#pragma mark -
#pragma mark implement )scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"scrollView.contentOffset.y == %f", scrollView.contentOffset.y);
    if(scrollView.contentOffset.y < 0)
    {
//       [_ivRefresh startAnimation];
    }
    
    if (_wmPlayer != nil) {

        if (_wmPlayer.superview) {
            CommunityCellViewController* currentCell = (CommunityCellViewController*)_currentVC;
            
            CGRect rectInSuperview = [currentCell.backgroundIV convertRect:currentCell.backgroundIV.frame toView:self.view];
//             NSLog(@"rectInview1 = %@",NSStringFromCGRect(rectInSuperview));
            
//            CGRect rectInTableView = [self.table rectForRowAtIndexPath:currentIndexPath];
//            CGRect rectInSuperview = [self.table convertRect:rectInTableView toView:[self.table superview]];
//            NSLog(@"rectInSuperview = %@",NSStringFromCGRect(rectInSuperview));
//            
            if (rectInSuperview.origin.y<-currentCell.backgroundIV.frame.size.height
                ||rectInSuperview.origin.y>self.view.frame.size.height-kNavbarHeight-kTabBarHeight) {//往上拖动
                [self releaseWMPlayer];
                [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView.contentOffset.y < 0)
    {
      [_topHeight setConstant:138+25];
    }
}

#pragma mark -
#pragma mark implement CommunityCellDelegate
- (void)playVideo:(UIViewController*)vc
{
    _currentVC = vc;
    CommunityCellViewController* currentCell = (CommunityCellViewController*)vc;
    NSDictionary* video = currentCell.videoDict;
    NSString* mp4_url = [video objectForKey:@"mp4_url"];
    
    if (_wmPlayer) {
        [_wmPlayer removeFromSuperview];
        [_wmPlayer setVideoURLStr:mp4_url];
        [_wmPlayer.player play];
        
    }else{
        _wmPlayer = [[WMPlayer alloc]initWithFrame:currentCell.backgroundIV.bounds videoURLStr:mp4_url];
        [_wmPlayer.player play];
        
    }
   
    [currentCell.backgroundIV addSubview:_wmPlayer];
    [currentCell.backgroundIV bringSubviewToFront:_wmPlayer];
    [currentCell.playBtn.superview sendSubviewToBack:currentCell.playBtn];
}

#pragma mark -
#pragma mark implement EditCommunityDelegate
- (void)submitSuccess
{
    
}

#pragma MsgView12Delegate
- (void)editGroupCallBack
{
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"EditGroupViewController" bundle:nil];
    EditGroupViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"EditGroupViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

#pragma SelectCityDelegate
- (void)cityCallBack:(NSString*)str
{
    [_lbCity setText:str];
}


-(void)releaseWMPlayer{
    [_wmPlayer.player.currentItem cancelPendingSeeks];
    [_wmPlayer.player.currentItem.asset cancelLoading];
         
    [_wmPlayer.player pause];
    [_wmPlayer removeFromSuperview];
    [_wmPlayer.playerLayer removeFromSuperlayer];
    [_wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    _wmPlayer = nil;
    _wmPlayer.player = nil;
    _wmPlayer.currentItem = nil;
         
    _wmPlayer.playOrPauseBtn = nil;
    _wmPlayer.playerLayer = nil;
    _currentVC = nil;
}
@end

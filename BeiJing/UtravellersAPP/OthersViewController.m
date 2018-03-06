//
//  OthersViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/11/4.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "OthersViewController.h"
#import "CommunityCellViewController.h"
#import "FocusGroup.h"
#import "MsgView14.h"
#import "MsgView15.h"
#import "FootBall4_8.h"

@interface OthersViewController ()
@property (weak, nonatomic) IBOutlet UIView *listView;

@property (nonatomic) NSArray *listArray;
@property (weak, nonatomic) IBOutlet UIImageView *ivBg;
@property (weak, nonatomic) IBOutlet UIView *addView;
@property (weak, nonatomic) IBOutlet UIView *followingView;
@property (weak, nonatomic) IBOutlet UIButton *btAdd;
@property (weak, nonatomic) IBOutlet UIButton *btFollow;

@end

@implementation OthersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listArray = @[@{@"id":@"1"}, @{@"id":@"1"}, @{@"id":@"1"}, @{@"id":@"1"}];
    
    [self createData:_listArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addFollowAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FocusGroup" bundle:nil];
    FocusGroup *msgView = (FocusGroup*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"FocusGroup"];
    msgView.delegate = self;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}

- (IBAction)followingAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView14" bundle:nil];
    MsgView14 *msgView = (MsgView14*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView14"];
    msgView.delegate = self;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}

- (IBAction)chatAction:(id)sender {
 
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FootBall4_8" bundle:nil];
    FootBall4_8 *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FootBall4_8"];  //
    door.m_titleName = @"Dylan Stanley";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

- (IBAction)rightAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView15" bundle:nil];
    MsgView15 *msgView = (MsgView15*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView15"];
    msgView.delegate = self;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
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
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"CommunityCellViewController" bundle:nil];
        CommunityCellViewController *v = (CommunityCellViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"CommunityCellViewController"];
        v.superViewCon = self;
        v.imageArray = @[[UIImage imageNamed:@"美女图"], [UIImage imageNamed:@"美女图"], [UIImage imageNamed:@"美女图"], [UIImage imageNamed:@"美女图"]];
        [self addChildViewController:v];
        UIView *vv = [[v.view subviews] objectAtIndex:0];
        [view addSubview:vv];
        [viewArray addObject:vv];
        
        v.m_dict = d;
        [v.btOthers setEnabled:NO];
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
            
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
            //距离上一个的高度
            NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:10];
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


#pragma FocusGroupDelegate
- (void)selectGroup:(NSString*)pr {
    
    NSLog(@"pr == %@", pr);
    
    [_addView setHidden:YES];
    [_followingView setHidden:NO];
    [_btAdd setEnabled:NO];
    [_btFollow setEnabled:YES];
}

#pragma MsgView14Delegate
- (void)groupCallBack {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FocusGroup" bundle:nil];
    FocusGroup *msgView = (FocusGroup*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"FocusGroup"];
    msgView.delegate = self;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}

- (void)unfollowCallBack {
    
    [_addView setHidden:NO];
    [_followingView setHidden:YES];
    [_btAdd setEnabled:YES];
    [_btFollow setEnabled:NO];
}

@end

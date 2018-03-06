//
//  ManageGroupViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/21.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ManageGroupViewController.h"
#import "ManageGroupCell.h"
#import "ManageGroupCell2.h"
#import "AddFriendViewController.h"
#import "MsgView3.h"
#import "MsgView13.h"

@interface ManageGroupViewController ()
@property (weak, nonatomic) IBOutlet UIView *listView;

@property (nonatomic) NSMutableArray *listArray;
//@property (nonatomic) NSMutableArray *list2Array;
@property (nonatomic) NSMutableArray *friendArray;
@end

@implementation ManageGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.friendArray = [[NSMutableArray alloc] init];

    
    self.listArray = [[NSMutableArray alloc] init];
    [_listArray addObjectsFromArray:@[@{@"name":@"Angola", @"portrait":@"6", @"uid":@"1"},
                                      @{@"name":@"Antigua and Barbuda", @"portrait":@"7", @"uid":@"2"},
                                      @{@"name":@"Argentina", @"portrait":@"大头像", @"uid":@"3"},
                                      @{@"name":@"Argentina", @"portrait":@"8", @"uid":@"4"},
                                      @{@"name":@"Argentina", @"portrait":@"9", @"uid":@"5"},
                                      @{@"name":@"Angola", @"portrait":@"10", @"uid":@"1"},
                                      @{@"name":@"Antigua and Barbuda", @"portrait":@"12", @"uid":@"2"},
                                      @{@"name":@"Argentina", @"portrait":@"13", @"uid":@"3"},
                                      @{@"name":@"Angola", @"portrait":@"15", @"uid":@"1"},
                                      @{@"name":@"Antigua and Barbuda", @"portrait":@"3", @"uid":@"2"},
                                      @{@"name":@"Argentina", @"portrait":@"4", @"uid":@"3"}]];
    
    
    
    [self createData:_listArray];
    
    NSString* name = [_m_dict objectForKey:@"name"];
    _lbName.text = name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//编辑组名
- (IBAction)editAction:(id)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView13" bundle:nil];
    MsgView13 *msgView = (MsgView13*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView13"];
    msgView.delegate = self;
    msgView.m_titleName = _lbName.text;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}

- (void)createData :(NSArray *)dataArray {
    
    UIView *view = _listView;
    NSArray *subArray = [view subviews];
    for (UIView *v in subArray) {
        [v removeFromSuperview];
    }
    
    UIView *s_v = nil;
    if ([[view subviews] count] > 0) {
        s_v = [[view subviews] lastObject];
    }
    else {
        NSArray *a = [view constraints];
        [view removeConstraints:a];
    }
    
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    
    
    int col = 4;
    float space = 0;
    float wid = self.view.bounds.size.width/col;
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    [newArray addObject:@{@"uid":@"-1"}];
    [newArray addObject:@{@"uid":@"-2"}];
    NSInteger count = [dataArray count];
    if (bFull) {
        [newArray addObjectsFromArray:dataArray];
        if (count > col*2-2){
            [newArray addObject:@{@"uid":@"-4"}];
        }
    }else{
        if (count > col*2-2) {
            for (int i = 0; i < col*2-3; i++){
                [newArray addObject:[dataArray objectAtIndex:i]];
            }
            [newArray addObject:@{@"uid":@"-3"}];
        }else{
            [newArray addObjectsFromArray:dataArray];
        }
    }
  
    [_friendArray removeAllObjects];
    for (int i = 0; i < [newArray count]; i++) {
        NSDictionary* d = [newArray objectAtIndex:i];
        NSString* sid = [d objectForKey:@"uid"];
        NSString* name = [d objectForKey:@"name"];
        NSString* portrait = [d objectForKey:@"portrait"];
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ManageGroupViewController" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ManageGroupCell"];
       
        if ([sid intValue] < 0) {
            ManageGroupCell2 *vv = (ManageGroupCell2 *)[v.view viewWithTag:[sid integerValue]];
            [self addChildViewController:v];
            [view addSubview:vv];
            [viewArray addObject:vv];
            
            vv.delegate = self;
            vv.superViewCon = self;
            vv.m_dict = d;
        }else{
            ManageGroupCell *vv = (ManageGroupCell *)[v.view viewWithTag:1];
            [self addChildViewController:v];
            [view addSubview:vv];
            [viewArray addObject:vv];
            [_friendArray addObject:vv];
            
            vv.delegate = self;
            vv.superViewCon = self;
            
            vv.m_dict = d;
            vv.lbTitle.text = name;
            [vv.ivLogo setImage:[UIImage imageNamed:portrait]];
            if (iDelect) {
                vv.bSel = YES;
            }
        }

    }
    
   
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            
            NSLayoutConstraint *c0 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            [v addConstraint:c0];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:space];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
            [view addConstraint:c1];
            [view addConstraint:c2];
            s_v = v;
            k++;
            continue;
        }
        
        if (k % col == 0) {
            NSLayoutConstraint *c0 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            [v addConstraint:c0];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:space];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            
            [view addConstraint:c1];
            [view addConstraint:c2];
        }else{
            NSLayoutConstraint *c0 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            [v addConstraint:c0];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            
            [view addConstraint:c1];
            [view addConstraint:c2];
        }
        
        s_v = v;
        k++;
    }
    
    if(s_v != nil)
    {
        NSLayoutConstraint *c1 = [self findLayout:@"end" superView:view];
        [view removeConstraint:c1];
        //让SUPERVIEW的底 = 最后一个VIEW的底
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:20];
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


#pragma ManageCellDelegate
-(void)delGroupCell:(UIView*)vv
{
    if (iDelect == 1){
        NSMutableArray* a = [[NSMutableArray alloc] init];
        [a addObject:((ManageGroupCell*)vv).m_dict];
        [_listArray removeObjectsInArray:a];
        
        [self createData:_listArray];
    }
}

#pragma ManageCell2Delegate
-(void)addCallBack
{
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"AddFriendViewController" bundle:nil];
    AddFriendViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"AddFriendViewController"];  //
    door.delegate = self;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

-(void)delCallBack
{
    if (iDelect == 0) {
        iDelect = 1;
        for (ManageGroupCell *vv in _friendArray) {
            vv.bSel = YES;
        }
    }else if(iDelect == 1){
        iDelect = 0;
        for (ManageGroupCell *vv in _friendArray) {
            vv.bSel = NO;
        }
//        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView3" bundle:nil];
//        MsgView3 *msgView = (MsgView3*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView3"];
//        msgView.delegate = self;
//        [self addChildViewController:msgView];
//        [self.view addSubview:msgView.view];
    }
}

-(void)moreCallBack
{
    bFull = YES;
    [self createData:_listArray];
}

-(void)lessCallBack
{
    bFull = NO;
    [self createData:_listArray];
}

#pragma MsgView3Delegate
- (void)delectCallBack
{
    NSMutableArray* a = [[NSMutableArray alloc] init];
    for (ManageGroupCell *vv in _friendArray) {
        if (vv.bSel) {
            [a addObject:vv.m_dict];
        }
    }
    [_listArray removeObjectsInArray:a];
    
    [self createData:_listArray];
}

- (void)cancelCallBack
{
    for (ManageGroupCell *vv in _friendArray) {
        vv.bSel = NO;
    }
}

#pragma MsgView13Delegate
- (void)editGroup:(NSString*)pr
{
    _lbName.text = pr;
    [_delegate editGroupSuccess:pr];
}

#pragma AddBuddyDelegate
- (void)addFriendCallBack:(NSArray*)arr
{
    [_listArray addObjectsFromArray: arr];
    
    [self createData:_listArray];
}

@end

//
//  ConsulateViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/14.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ConsulateViewController.h"
#import "ConsulateCellView.h"
#import "SelectStates.h"
#import "MsgView11.h"
#import "RegionViewController.h"
#import "SelectLocalView.h"
#import "NewsDetailViewController.h"

@interface ConsulateViewController ()
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UILabel *lbSelect1;
@property (weak, nonatomic) IBOutlet UILabel *lbSelect2;

@property (nonatomic) NSArray *listArray;
@end

@implementation ConsulateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listArray  = @[@{@"name":@"Angola", @"portrait":@"1", @"uid":@"1"},
                        @{@"name":@"Antigua and Barbuda", @"portrait":@"1", @"uid":@"2"},
                        @{@"name":@"Argentina", @"portrait":@"1", @"uid":@"3"},
                        @{@"name":@"Argentina", @"portrait":@"1", @"uid":@"4"},
                        @{@"name":@"Argentina", @"portrait":@"1", @"uid":@"5"},
                        @{@"name":@"Argentina", @"portrait":@"1", @"uid":@"3"}];
    
    [self createData:_listArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)statesAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"SelectStates" bundle:nil];
    SelectStates *msgView = (SelectStates*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectStates"];
    msgView.delegate = self;
    [self.navigationController addChildViewController:msgView];
    [self.navigationController.view addSubview:msgView.view];
}

- (IBAction)telAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView11" bundle:nil];
    MsgView11 *msgView = (MsgView11*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView11"];
    msgView.delegate = self;
    [self.navigationController addChildViewController:msgView];
    [self.navigationController.view addSubview:msgView.view];
}

- (IBAction)webAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"WebsiteViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"WebsiteViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

//选择国家
- (IBAction)select1Action:(id)sender {
 
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"RegionViewController" bundle:nil];
    RegionViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"RegionViewController"];  //
    door.delegate = self;
    door.iType = 1;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

//选择地区
- (IBAction)select2Action:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"SelectLocalView" bundle:nil];
    SelectLocalView *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectLocalView"];
    v.delegate = self;
    [self addChildViewController:v];
    [self.view addSubview:v.view];
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
        NSString* s = [d objectForKey:@"portrait"];
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ConsulateViewController" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ConsulateCellView"];
        ConsulateCellView *vv = (ConsulateCellView *)[v.view viewWithTag:[s intValue]];
        vv.delegate = self;
        vv.superViewCon = self;
        vv.m_dict = d;
        
        [self addChildViewController:v];
        [view addSubview:vv];
        [viewArray addObject:vv];
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
            
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
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
        NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        
        NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
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

- (void)laterToMoveScrollView:(id)timer {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NewsDetailViewController" bundle:nil];
    NewsDetailViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"NewsDetailViewController"];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

#pragma SelectStatesDelegate
- (void)okCallBack:(NSInteger) row {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ConsulNavViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ConsulNavViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

#pragma SelectStatesDelegate
- (void)okSuccess {
    
    
}

#pragma RegionDelegate
- (void)regionCallBack:(NSString*)str {
    
    _lbSelect1.text = str;
    
//    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(laterToMoveScrollView:) userInfo:nil repeats:NO];
}

#pragma mark -
#pragma mark SelectLocalView delegate
- (void)selectArea:(NSString *)areaStr
{
    _lbSelect2.text = areaStr;
}
@end

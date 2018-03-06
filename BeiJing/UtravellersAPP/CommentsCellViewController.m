//
//  CommentsCellViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/8.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "CommentsCellViewController.h"
#import "CommentsCellView.h"
#import "OthersViewController.h"

@interface CommentsCellViewController ()
@property (weak, nonatomic) IBOutlet UIView *listView;

@end

@implementation CommentsCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *arr = @[_m_dict];
    [self createData:arr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)othersAction:(id)sender{
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"OthersViewController" bundle:nil];
    OthersViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"OthersViewController"];  //
    door.m_dict = _m_dict;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
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
        NSString* s = [d objectForKey:@"portrait"];
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"CommentsViewController" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CommentsCellView"];
        CommentsCellView *vv = (CommentsCellView *)[v.view viewWithTag:[s intValue]];
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
@end

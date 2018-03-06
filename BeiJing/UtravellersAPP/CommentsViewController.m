//
//  CommentsViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/8.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentsCellViewController.h"

@interface CommentsViewController ()
@property (weak, nonatomic) IBOutlet UIView *listView;

@property (nonatomic) NSArray *listArray;
@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listArray  = @[@{@"name":@"Angola", @"portrait":@"1", @"uid":@"1"},
                                      @{@"name":@"Antigua and Barbuda", @"portrait":@"2", @"uid":@"2"},
                                      @{@"name":@"Argentina", @"portrait":@"1", @"uid":@"3"},
                                      @{@"name":@"Argentina", @"portrait":@"2", @"uid":@"4"},
                                      @{@"name":@"Argentina", @"portrait":@"1", @"uid":@"5"},
                                      @{@"name":@"Argentina", @"portrait":@"2", @"uid":@"3"}];
    
    [self createData:_listArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"CommentsViewController" bundle:nil];
        CommentsCellViewController *v = (CommentsCellViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"CommentsCellViewController"];
        v.superViewCon = self;
        v.m_dict = d;
        [self addChildViewController:v];
        UIView *vv = [[v.view subviews] objectAtIndex:0];
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


@end

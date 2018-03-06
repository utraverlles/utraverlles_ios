//
//  MyPostViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/9.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "MyPostViewController.h"
#import "CommunityCellViewController.h"

@interface MyPostViewController ()
@property (weak, nonatomic) IBOutlet UIView *View1;
@property (weak, nonatomic) IBOutlet UIView *listView;

@property (nonatomic,strong) UISearchController *searchController;//搜索VC
@property (nonatomic) NSArray *listArray;
@end

@implementation MyPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    [_View1 addSubview:_searchController.searchBar];
    
    self.listArray = @[@{@"id":@"1"}, @{@"id":@"1"}, @{@"id":@"1"}, @{@"id":@"1"}];
    
    [self createData:_listArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    if (self.searchController.active)
    {
        [_searchController setActive:NO];
    }
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
        NSString* sid = [d objectForKey:@"id"];
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"CommunityCellViewController" bundle:nil];
        CommunityCellViewController *v = (CommunityCellViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"CommunityCellViewController"];
        v.superViewCon = self;
        v.imageArray = @[[UIImage imageNamed:@"default_photo"], [UIImage imageNamed:@"default_photo"], [UIImage imageNamed:@"default_photo"], [UIImage imageNamed:@"default_photo"]];
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




#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {

}

- (void)willDismissSearchController:(UISearchController *)searchController {
    
    NSLog(@"willDismissSearchController ==>");
}
@end

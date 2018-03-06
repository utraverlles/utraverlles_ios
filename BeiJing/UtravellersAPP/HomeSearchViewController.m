//
//  HomeSearchViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/11.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "HomeSearchViewController.h"
#import "CommunityCellViewController.h"
#import "SearchCellView.h"
#import "LogoCellView.h"

@interface HomeSearchViewController ()
@property (weak, nonatomic) IBOutlet UIView *listView1;
@property (weak, nonatomic) IBOutlet UIView *listView2;
@property (weak, nonatomic) IBOutlet UIView *listTopView1;
@property (weak, nonatomic) IBOutlet UIScrollView *superScrollView;
@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UILabel *lbSelection;

- (IBAction)tabAction:(UIButton *)sender;
@property (nonatomic) NSMutableArray *list1Array;
@property (nonatomic) NSMutableArray *list2Array;
@property (nonatomic) NSMutableArray *tableArray;
@property (nonatomic) NSMutableArray *logoArray;
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic, retain) NSString* pageNum;
@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableArray = [[NSMutableArray alloc] init];
    self.logoArray = [[NSMutableArray alloc] init];
    
    self.list1Array = [[NSMutableArray alloc] init];
    [_list1Array addObjectsFromArray:@[@{@"portrait":@"1",@"name":@"aaa",@"title":@"haha",@"uid":@"1",@"buddy":@"0"},
                                       @{@"portrait":@"2",@"name":@"花无缺",@"title":@"haha1",@"uid":@"2",@"buddy":@"0"},
                                       @{@"portrait":@"3",@"name":@"东方不败",@"title":@"haha2",@"uid":@"3",@"buddy":@"1"},
                                       @{@"portrait":@"4",@"name":@"任我行",@"title":@"haha3",@"uid":@"4",@"buddy":@"1"},
                                       @{@"portrait":@"5",@"name":@"逍遥王",@"title":@"haha4",@"uid":@"5",@"buddy":@"0"},
                                       @{@"portrait":@"6",@"name":@"aasdsd",@"title":@"haha5",@"uid":@"6",@"buddy":@"0"},
                                       @{@"portrait":@"15",@"name":@"足球",@"title":@"haha",@"uid":@"15",@"buddy":@"1"},
                                       @{@"portrait":@"16",@"name":@"58赶集",@"title":@"haha",@"uid":@"16",@"buddy":@"0"},
                                       @{@"portrait":@"17",@"name":@"搜房网",@"title":@"haha",@"uid":@"17",@"buddy":@"0"},
                                       @{@"portrait":@"18",@"name":@"欧弟",@"title":@"haha",@"uid":@"18",@"buddy":@"0"}]];
    
    self.list2Array = [[NSMutableArray alloc] init];
    [_list2Array addObjectsFromArray:@[@{@"portrait":@"1",@"name":@"aaa",@"title":@"haha",@"uid":@"1",@"buddy":@"0"},
                                      @{@"portrait":@"2",@"name":@"花无缺",@"title":@"haha1",@"uid":@"2",@"buddy":@"0"},
                                      @{@"portrait":@"3",@"name":@"东方不败",@"title":@"haha2",@"uid":@"3",@"buddy":@"1"},
                                      @{@"portrait":@"4",@"name":@"任我行",@"title":@"haha3",@"uid":@"4",@"buddy":@"1"},
                                      @{@"portrait":@"5",@"name":@"逍遥王",@"title":@"haha4",@"uid":@"5",@"buddy":@"0"},
                                      @{@"portrait":@"6",@"name":@"aasdsd",@"title":@"haha5",@"uid":@"6",@"buddy":@"0"},
                                      @{@"portrait":@"15",@"name":@"足球",@"title":@"haha",@"uid":@"15",@"buddy":@"1"},
                                      @{@"portrait":@"16",@"name":@"58赶集",@"title":@"haha",@"uid":@"16",@"buddy":@"0"},
                                      @{@"portrait":@"17",@"name":@"搜房网",@"title":@"haha",@"uid":@"17",@"buddy":@"0"},
                                      @{@"portrait":@"18",@"name":@"欧弟",@"title":@"haha",@"uid":@"18",@"buddy":@"0"}]];
    
    [_tfSearch addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    NSString* content = @"Selection based on nationality and language";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
    //    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, content.length)];
    NSRange start = [content rangeOfString:@"nationality"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0 / 255 green:185.0 / 255 blue:0.0 / 255 alpha:1.0] range:start];
    start = [content rangeOfString:@"language"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0 / 255 green:185.0 / 255 blue:0.0 / 255 alpha:1.0] range:start];
    _lbSelection.attributedText = str;
    
    {
        [self createTopData:_list1Array];
        [self createList1Data:_list1Array];
        [self createList2Data:_list2Array];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTopData:(NSArray *)dataArray {
    
    if ([dataArray count] == 0) {
        return;
    }
    
    UIView *view = _listTopView1;
    //清空
    NSArray *subArray = [view subviews];
    for (UIView *v in subArray) {
        [v removeFromSuperview];
    }
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    UIView *s_v = nil;
    if ([[view subviews] count] > 0) {
        s_v = [[view subviews] lastObject];
    }
    else {
        NSArray *a = [view constraints];
        [view removeConstraints:a];
    }
    
//    float widthRadius = 40.0;
    NSInteger count = [dataArray count];
//    if (count > 3) {
//        count = 3;
//    }
    for (int i = 0; i < count; i++) {
        NSDictionary *d = [dataArray objectAtIndex:i];
        NSString* logImage = [d objectForKey:@"portrait"];
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"HomeSearchViewController" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"LogoCellView"];
        LogoCellView *vv = (LogoCellView *)[v.view viewWithTag:1];
        vv.delegate = self;
        vv.superViewCon = self;
        vv.m_dict = d;
        
        [self addChildViewController:v];
        [view addSubview:vv];
        [viewArray addObject:vv];
        
        [vv.ivLogo setImage:[UIImage imageNamed:logImage]];
//        [vv sd_setImageWithURL:[NSURL URLWithString:logImage] placeholderImage:[UIImage imageNamed:@"login_icon.png"]];
//        vv.layer.cornerRadius = widthRadius / 2;
//        vv.layer.masksToBounds = YES;
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            
//            NSLayoutConstraint *c11 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:widthRadius];
//            NSLayoutConstraint *c22 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:widthRadius];
//            [v addConstraint:c11];
//            [v addConstraint:c22];
            
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:12];
            NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:12];
            c4.identifier = @"end";
            [view addConstraint:c1];
            [view addConstraint:c2];
            [view addConstraint:c4];
            s_v = v;
            k++;
            continue;
        }
        
//        NSLayoutConstraint *c11 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:widthRadius];
//        NSLayoutConstraint *c22 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:widthRadius];
//        [v addConstraint:c11];
//        [v addConstraint:c22];
        
        NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeTrailing multiplier:1 constant:12];
        [view addConstraint:c1];
        [view addConstraint:c2];
        s_v = v;
        k++;
    }
    
    if (s_v) {
        NSLayoutConstraint *c1 = [self findLayout:@"end" superView:view];
        [view removeConstraint:c1];
        //让SUPERVIEW的底 = 最后一个VIEW的底
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeTrailing multiplier:1 constant:12];
        c3.identifier = @"end";
        [view addConstraint:c3];
    }
}

- (void)createList1Data:(NSArray *)dataArray {
 
    UIView *view = _listView1;
    //清空
    NSArray *subArray = [view subviews];
    for (UIView *v in subArray) {
        [v removeFromSuperview];
    }
    
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
        NSString* sid = [d objectForKey:@"uid"];
        NSString* portrait = [d objectForKey:@"portrait"];
        NSString* name = [d objectForKey:@"name"];

        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"CommunityCellViewController" bundle:nil];
        CommunityCellViewController *v = (CommunityCellViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"CommunityCellViewController"];
        v.superViewCon = self;
        v.m_dict = d;
        v.imageArray = [[NSArray alloc] init];
        [self addChildViewController:v];
        UIView *vv = [[v.view subviews] objectAtIndex:0];
        [view addSubview:vv];
        [viewArray addObject:vv];
        
        [v.ivLogo setImage:[UIImage imageNamed:portrait]];
        [v.lbName setText:name];
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

- (void)createList2Data:(NSArray *)dataArray {
    
    UIView *view = _listView2;
    //清空
    NSArray *subArray = [view subviews];
    for (UIView *v in subArray) {
        [v removeFromSuperview];
    }
    
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
    
//    @{@"portrait":@"2",@"name":@"花无缺",@"title":@"haha1",@"uid":@"2",@"buddy":@"0"},
    for (int i = 0; i < [dataArray count]; i++) {
        NSDictionary *d = [dataArray objectAtIndex:i];
        NSString* sid = [d objectForKey:@"uid"];
        NSString* portrait = [d objectForKey:@"portrait"];
        NSString* name = [d objectForKey:@"name"];
        NSString* title = [d objectForKey:@"title"];
        NSString* buddy = [d objectForKey:@"buddy"];
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"HomeSearchViewController" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SearchCellView"];
        SearchCellView *vv = (SearchCellView *)[v.view viewWithTag:1];
        vv.delegate = self;
        vv.superViewCon = self;
        vv.m_dict = d;
        
        [self addChildViewController:v];
        [view addSubview:vv];
        [viewArray addObject:vv];
        
        [vv.ivLogo setImage:[UIImage imageNamed:portrait]];
        [vv.lbName setText:name];
        [vv.lbTitle setText:title];
        if ([buddy intValue]) {
            [vv.followView setHidden:NO];
            [vv.chatView setHidden:YES];
        }else{
            [vv.followView setHidden:YES];
            [vv.chatView setHidden:NO];
        }
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
        NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
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

- (IBAction)back:(id)sender {
    
    if (_bSearch) {
        _bSearch = NO;
        [_tfSearch resignFirstResponder];
        _tfSearch.text = @"";
        if (_pageIndex == 0)
        {
            [_tableView setHidden:YES];
            [self createTopData:_list1Array];
            [self createList1Data:_list1Array];
        }
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"SelectionViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectionViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}


- (IBAction)tabAction:(UIButton *)sender {
    CGFloat scrollViewWidth = _superScrollView.contentSize.width;
    self.pageIndex = sender.tag - 10;
    [_superScrollView setContentOffset:CGPointMake(scrollViewWidth / 2.0 * self.pageIndex, 0) animated:YES];
    switch (sender.tag) {
        case 10:
        {
        }
            break;
        case 11:
        {
        }
            break;
        case 12:
        {
        }
            break;
        default:
            break;
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _superScrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        self.pageIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        return;
    }
}

- (void)setPageIndex:(NSInteger)pageIndex {
    _pageIndex = pageIndex;
    NSArray *a = [_tabView subviews];
    UIColor *c1 = [UIColor colorWithRed:109 / 255.0 green:113 / 255.0 blue:125 / 255.0 alpha:1.0];
    UIColor *c2 = [UIColor colorWithRed:255 / 255.0 green:185 / 255.0 blue:0 / 255.0 alpha:1.0];
    for (UIView *v in a) {
        if(v.tag != 333)
        {
            UILabel *v1 = [[v subviews] objectAtIndex:0];
            UIImageView *v2 = [[v subviews] objectAtIndex:1];
            [v1 setTextColor:c1];
            [v2 setHidden:YES];
        }
    }
    NSArray *thisView = [[a objectAtIndex:pageIndex] subviews];
    UILabel *v1 = [thisView objectAtIndex:0];
    UIImageView *v2 = [thisView objectAtIndex:1];
    [v1 setTextColor:c2];
    [v2 setHidden:NO];
    
    //先清除原来的VIEW
    UIView *view = nil;
    switch (_pageIndex) {
        case 0:
        {
            view = _listView1;
        }
            break;
        case 1:
        {
            view = _listView2;
        }
            break;
        default:
            break;
    }
    
}


#pragma mark--
#pragma mark--UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {

    if (_pageIndex == 0)
    {
        _bSearch = YES;
        [_tableView setHidden:NO];
        [_tableArray removeAllObjects];
        [_tableView reloadData];
        
        {
            UIView *view = _listTopView1;
            //清空
            NSArray *subArray = [view subviews];
            for (UIView *v in subArray) {
                [v removeFromSuperview];
            }
        }
        {
            UIView *view = _listView1;
            //清空
            NSArray *subArray = [view subviews];
            for (UIView *v in subArray) {
                [v removeFromSuperview];
            }
        }
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField.text length] == 0) {
        return YES;
    }
    
    if (_pageIndex == 0) {
        [_tableView setHidden:YES];
    }
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 0) {
        
        if (_pageIndex == 0) {
            [self updateSearchResultsForSearchList1:textField.text];
        }
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 32;
}


#pragma mark--
#pragma mark--UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSDictionary *d = [_tableArray objectAtIndex:row];
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString* name = [d objectForKey:@"name"];
    UILabel* lbName = [cell viewWithTag:1001];
    lbName.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [_tableView setHidden:YES];
    [_tfSearch resignFirstResponder];
}



#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
-(void)updateSearchResultsForSearchList1:(NSString *)search {
    NSString *searchText = search;
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.list1Array.count; i++) {
        NSDictionary *d = _list1Array[i];
        NSString *storeString = [d objectForKey:@"name"];
        
        NSRange storeRange = NSMakeRange(0, storeString.length);
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            
            [tempResults addObject:d];
        }
        
    }
    
    [self createTopData:tempResults];
    [self createList1Data:tempResults];

    
    [_tableArray removeAllObjects];
    [_tableArray addObjectsFromArray:tempResults];
    
    //刷新表格
    [self.tableView reloadData];
}
@end

//
//  AddBuddyViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/22.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "AddFriendViewController.h"
#import "AddFriendCell.h"
#import "ContactModel.h"
#import "ContactDataHelper.h"//根据拼音A~Z~#进行排序的tool
//#import "ContactTableViewCell.h"

@interface AddFriendViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton* btSave;
@property (weak, nonatomic) IBOutlet UILabel* lbSave;
@property (nonatomic,strong) NSArray *serverDataArr;//数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
//@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@property (nonatomic,strong) UISearchController *searchController;//搜索VC
@end

@implementation AddFriendViewController

#pragma mark - dataArr(模拟从服务器获取到的数据)
- (NSArray *)serverDataArr{
    if (!_serverDataArr) {
        _serverDataArr=@[@{@"portrait":@"1",@"name":@"aaa",@"title":@"haha",@"uid":@"1"},
                         @{@"portrait":@"2",@"name":@"花无缺",@"title":@"haha1",@"uid":@"2"},
                         @{@"portrait":@"3",@"name":@"东方不败",@"title":@"haha2",@"uid":@"3"},
                         @{@"portrait":@"4",@"name":@"任我行",@"title":@"haha3",@"uid":@"4"},
                         @{@"portrait":@"5",@"name":@"逍遥王",@"title":@"haha4",@"uid":@"5"},
                         @{@"portrait":@"6",@"name":@"aasdsd",@"title":@"haha5",@"uid":@"6"},
                         @{@"portrait":@"13",@"name":@"百草堂",@"title":@"haha6",@"uid":@"7"},
                         @{@"portrait":@"8",@"name":@"三味书屋",@"title":@"haha",@"uid":@"8"},
                         @{@"portrait":@"9",@"name":@"彩彩",@"title":@"haha",@"uid":@"9"},
                         @{@"portrait":@"10",@"name":@"陈晨",@"title":@"haha",@"uid":@"10"},
                         @{@"portrait":@"11",@"name":@"ddddss",@"title":@"haha",@"uid":@"11"},
                         @{@"portrait":@"12",@"name":@"xxxx",@"title":@"haha",@"uid":@"12"},
                         @{@"portrait":@"7",@"name":@"哥哥",@"title":@"haha",@"uid":@"13"},
                         @{@"portrait":@"14",@"name":@"林俊杰",@"title":@"haha",@"uid":@"14"},
                         @{@"portrait":@"15",@"name":@"足球",@"title":@"haha",@"uid":@"15"},
                         @{@"portrait":@"16",@"name":@"58赶集",@"title":@"haha",@"uid":@"16"},
                         @{@"portrait":@"17",@"name":@"搜房网",@"title":@"haha",@"uid":@"17"},
                         @{@"portrait":@"18",@"name":@"欧弟",@"title":@"haha",@"uid":@"18"}];
    }
    return _serverDataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr=[NSMutableArray array];
    for (NSDictionary *subDic in self.serverDataArr) {
        ContactModel *model=[[ContactModel alloc]initWithDic:subDic];
        [self.dataArr addObject:model];
    }
    
    _rowArr=[ContactDataHelper getFriendListDataBy:self.dataArr];
//    NSLog(@"_rowArr == %@", _rowArr);
    _sectionArr=[ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
   
//    _searchDisplayController=[[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
//    [_searchDisplayController setDelegate:self];
//    [_searchDisplayController setSearchResultsDataSource:self];
//    [_searchDisplayController setSearchResultsDelegate:self];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
     [self.tableView setSectionIndexColor:RGB(255, 185, 0)];
    
    _searchResultArr=[NSMutableArray array];
    _booksIndexsToBeRemoved = [NSMutableIndexSet indexSet];
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

- (IBAction)saveAction:(id)sender {
    
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (NSDictionary* d in _serverDataArr) {
        NSString* uid = [d objectForKey:@"uid"];
        if ([_booksIndexsToBeRemoved containsIndex:[uid integerValue]]) {
            [arr addObject:d];
        }
    }
    [_delegate addFriendCallBack:arr];
    
    if (self.searchController.active)
    {
        [_searchController setActive:NO];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//- (UISearchBar *)searchBar{
//    if (!_searchBar) {
//        _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenSize.width, 44)];
////        [_searchBar setBackgroundImage:[UIImage imageNamed:@"ic_searchBar_bgImage"]];
//        [_searchBar sizeToFit];
//        [_searchBar setPlaceholder:@"Search"];
//        [_searchBar.layer setBorderWidth:0.5];
//        [_searchBar.layer setBorderColor:[UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1].CGColor];
//        [_searchBar setDelegate:self];
//        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
//    }
//    return _searchBar;
//}


#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //section
    if (self.searchController.active) {
        return 1;
    }else{
        return _rowArr.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //row
    if (self.searchController.active) {
        return _searchResultArr.count;
    }else{
        return [_rowArr[section] count];
    }
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50.0;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //viewforHeader
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!label) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:15.0f]];
        [label setTextColor:[UIColor colorWithRed:74.0/255 green:74.0/255 blue:74.0/255 alpha:1]];
        [label setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
    }
    [label setText:[NSString stringWithFormat:@"  %@",_sectionArr[section+1]]];
    return label;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.searchController.active) {
        return nil;
    }else{
        return _sectionArr;
    }
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index-1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.searchController.active) {
        return 0;
    }else{
        return 35.0;
    }
}

#pragma mark - UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    for(UIView *view in [tableView subviews])
//    {
//        if([[[view class] description] isEqualToString:@"UITableViewIndex"])
//        {
//            [view setAlpha:0.4];
//        }
//    }
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    AddFriendCell* vv = [cell viewWithTag:123];
    vv.superViewCon = self;
    
    ContactModel *model = nil;
    if (self.searchController.active){
//        [vv.ivLogo setImage:[UIImage imageNamed:[_searchResultArr[indexPath.row] valueForKey:@"portrait"]]];
//        [vv.lbName setText:[_searchResultArr[indexPath.row] valueForKey:@"name"]];
//        [vv.lbTitle setText:[_searchResultArr[indexPath.row] valueForKey:@"title"]];
        model=_searchResultArr[indexPath.row];
    }else{
        model=_rowArr[indexPath.section][indexPath.row];
    }
    
    [vv.ivLogo setImage:[UIImage imageNamed:model.portrait]];
    [vv.lbName setText:model.name];
    [vv.lbTitle setText:model.title];
    vv.index = [model.uid integerValue];
    [vv.btBg addTarget:self action:@selector(bookViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    vv.selected = [_booksIndexsToBeRemoved containsIndex:vv.index];
   
    return cell;
}

#pragma mark - BookView Listener

- (void)bookViewClicked:(UIButton *)button {
    AddFriendCell *bookView = (AddFriendCell *)(button.superview);
    if (bookView.selected) {
        [_booksIndexsToBeRemoved addIndex:bookView.index];
    }
    else {
        [_booksIndexsToBeRemoved removeIndex:bookView.index];
    }
    
    if ([_booksIndexsToBeRemoved count] > 0) {
        [_lbSave setHidden:NO];
        [_btSave setEnabled:YES];
    }else{
        [_lbSave setHidden:YES];
        [_btSave setEnabled:NO];
    }
}

#pragma mark searchBar delegate
//searchBar开始编辑时改变取消按钮的文字
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    NSArray *subViews;
//    subViews = [(searchBar.subviews[0]) subviews];
//    for (id view in subViews) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton* cancelbutton = (UIButton* )view;
//            [cancelbutton setTitle:@"Cancel" forState:UIControlStateNormal];
//            break;
//        }
//    }
//    searchBar.showsCancelButton = YES;
//}
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    return YES;
//}
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    return YES;
//}
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    //取消
//    [searchBar resignFirstResponder];
//    searchBar.showsCancelButton = NO;
//}


#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [self.searchController.searchBar text];
    
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.dataArr.count; i++) {
        NSString *storeString = [(ContactModel *)self.dataArr[i] name];
        NSString *storeImageString=[(ContactModel *)self.dataArr[i] portrait]?[(ContactModel *)self.dataArr[i] portrait]:@"";
        NSString *storeTitle = [(ContactModel *)self.dataArr[i] title];
        
        NSRange storeRange = NSMakeRange(0, storeString.length);
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
//            NSDictionary *dic=@{@"name":storeString,@"portrait":storeImageString,@"title":storeTitle};
//            [tempResults addObject:dic];
            [tempResults addObject:(ContactModel *)self.dataArr[i]];
        }
        
    }
    [_searchResultArr removeAllObjects];
    [_searchResultArr addObjectsFromArray:tempResults];
    
    //刷新表格
    [self.tableView reloadData];
}
@end

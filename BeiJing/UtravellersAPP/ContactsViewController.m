//
//  ContactsViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/26.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactsCell.h"
#import "ContactModel.h"
#import "ContactDataHelper.h"//根据拼音A~Z~#进行排序的tool
#import "MsgView5.h"
#import "BlacklistViewController.h"

@interface ContactsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton* btSave;
@property (weak, nonatomic) IBOutlet UILabel* lbSave;
@property (nonatomic,strong) NSArray *serverDataArr;//数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UISearchController *searchController;//搜索VC
@end

@implementation ContactsViewController

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
    _sectionArr=[ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];

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

- (IBAction)menuAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView5" bundle:nil];
    MsgView5 *msgView = (MsgView5*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView5"];
    msgView.delegate = self;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}


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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (tableView == _tableView)
        {
            if (self.searchController.active){
                ContactModel* model=_searchResultArr[indexPath.row];
                [_searchResultArr removeObject:model];
            }else{
                ContactModel* model=_rowArr[indexPath.section][indexPath.row];
                [_rowArr[indexPath.section] removeObject:model];
            }
        }
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]]  withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"%@", @"删除");
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        NSLog(@"%@", @"编辑");
    }
}


#pragma mark - UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    ContactsCell* vv = [cell viewWithTag:123];
    vv.delegate = self;
    vv.superViewCon = self;
    
    ContactModel *model = nil;
    if (self.searchController.active){
        model=_searchResultArr[indexPath.row];
    }else{
        model=_rowArr[indexPath.section][indexPath.row];
    }
    
    [vv.ivLogo setImage:[UIImage imageNamed:model.portrait]];
    [vv.lbName setText:model.name];
    [vv.lbTitle setText:model.title];
    vv.index = [model.uid integerValue];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

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

#pragma ContactsCellDelegate
- (void)chatCallBack
{
    if (self.searchController.active)
    {
        [_searchController setActive:NO];
    }
}

#pragma MsgView5Delegate
//添加好友
- (void)buddyCallBack
{
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"AddBuddyViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"AddBuddyViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

//添加黑名单
- (void)blackCallBack
{
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"BlacklistViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"BlacklistViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

@end

//
//  SelectCityViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/23.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "SelectCityViewController.h"
#import "SelectCityModel.h"
#import "ContactDataHelper.h"//根据拼音A~Z~#进行排序的tool
#import "SelectCityCell.h"
#import "ManageGroupCell2.h"
#import "SelectCityTop.h"

@interface SelectCityViewController ()
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *serverDataArr;//数据源
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UISearchController *searchController;//搜索VC
@end

@implementation SelectCityViewController


#pragma mark - dataArr(模拟从服务器获取到的数据)
- (NSArray *)serverDataArr{
    if (!_serverDataArr) {
        _serverDataArr=@[@{@"name":@"Anji "},
                         @{@"name":@"Ankang"},
                         @{@"name":@"Anqing"},
                         @{@"name":@"Anming"},
                         @{@"name":@"Beijing"},
                         @{@"name":@"Shanghai"},
                         @{@"name":@"Chengdu"},
                         @{@"name":@"Tianjing"},
                         @{@"name":@"Chongqing"},
                         @{@"name":@"Xi An"}];
    }
    return _serverDataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr=[NSMutableArray array];
    for (NSDictionary *subDic in self.serverDataArr) {
        SelectCityModel *model=[[SelectCityModel alloc]initWithDic:subDic];
        [self.dataArr addObject:model];
    }
    
    _rowArr=[ContactDataHelper getFriendListDataBy:self.dataArr];
    //    NSLog(@"_rowArr == %@", _rowArr);
    _sectionArr=[ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
    
    _searchResultArr=[NSMutableArray array];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    [_listView addSubview:_searchController.searchBar];
    
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"SelectCityTop" bundle:nil];
    SelectCityTop *v = (SelectCityTop*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectCityTop"];
    v.delegate = self;
    v.m_titleName = _m_titleName;
    UIView *vv = [[v.view subviews] objectAtIndex:0];
    [vv setFrame:CGRectMake(0, 0, ScreenSize.width, 0)];
    [vv setHidden:YES];
    [self addChildViewController:v];
    
    [self.tableView setTableHeaderView:vv];
//    self.tableView.tableHeaderView = vv;
    [self.tableView setSectionIndexColor:RGB(255, 185, 0)];
    [self.tableView setSectionIndexBackgroundColor:RGB(245, 245, 245)];
 
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:vv attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_tableView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    //等宽
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:vv attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_tableView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:vv attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_tableView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [_tableView addConstraint:c1];
    [_tableView addConstraint:c2];
    [_tableView addConstraint:c3];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIView *view=_tableView.tableHeaderView;
//    [_tableView beginUpdates];
    _tableView.tableHeaderView =view;
//    [_tableView endUpdates];
    [view setHidden:NO];
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

#pragma CityTopDelegate
- (void)topCallBack:(NSString*)str
{
    [_delegate cityCallBack:str];
    
    [self back:nil];
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
        [label setBackgroundColor:[UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1]];
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
    
    SelectCityCell* vv = [cell viewWithTag:123];
    vv.superViewCon = self;
    
    SelectCityModel *model = nil;
    if (self.searchController.active){
        //        [vv.ivLogo setImage:[UIImage imageNamed:[_searchResultArr[indexPath.row] valueForKey:@"portrait"]]];
        //        [vv.lbName setText:[_searchResultArr[indexPath.row] valueForKey:@"name"]];
        //        [vv.lbTitle setText:[_searchResultArr[indexPath.row] valueForKey:@"title"]];
        model=_searchResultArr[indexPath.row];
    }else{
        model=_rowArr[indexPath.section][indexPath.row];
    }
    
    [vv.lbName setText:model.name];
    [vv.btBg addTarget:self action:@selector(bookViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


#pragma mark - BookView Listener

- (void)bookViewClicked:(UIButton *)button {
   
    SelectCityCell *bookView = (SelectCityCell *)(button.superview);
  
    [_delegate cityCallBack:bookView.lbName.text];
    
    [self back:nil];
}


#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchText = [self.searchController.searchBar text];
    
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.dataArr.count; i++) {
        NSString *storeString = [(SelectCityModel *)self.dataArr[i] name];
    
        NSRange storeRange = NSMakeRange(0, storeString.length);
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            //            NSDictionary *dic=@{@"name":storeString,@"portrait":storeImageString,@"title":storeTitle};
            //            [tempResults addObject:dic];
            [tempResults addObject:(SelectCityModel *)self.dataArr[i]];
            
        }
        
    }
    [_searchResultArr removeAllObjects];
    [_searchResultArr addObjectsFromArray:tempResults];
    
    //刷新表格
    [self.tableView reloadData];
    
}
@end

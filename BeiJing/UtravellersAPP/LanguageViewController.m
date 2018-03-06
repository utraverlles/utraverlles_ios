//
//  LanguageViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/29.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "LanguageViewController.h"
#import "LanguageCell.h"

@interface LanguageViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton* btSave;
@property (weak, nonatomic) IBOutlet UILabel* lbSave;
@property (nonatomic,strong) NSArray *serverDataArr;//数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
//@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@property (nonatomic,strong) UISearchController *searchController;//搜索VC
@property (nonatomic,strong) NSString* strName;
@property (nonatomic) LanguageCell *oldView;
@end

@implementation LanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.serverDataArr = @[@"English", @"Bahasa Indonesia", @"Bahasa malayu", @"Español", @"한국어", @"Italiano", @"日本語", @"Polski", @"Português"];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    _searchResultArr=[NSMutableArray array];
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
    
    if (!_strName) {
        return;
    }
    [_delegate languageCallBack:_strName];
    
    if (self.searchController.active)
    {
        [_searchController setActive:NO];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //section
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //row
    if (self.searchController.active) {
        return _searchResultArr.count;
    }else{
        return _serverDataArr.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index-1;
}

#pragma mark - UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    LanguageCell* vv = [cell viewWithTag:123];
    vv.superViewCon = self;
    
    NSString *name = nil;
    if (self.searchController.active){
        
        name=_searchResultArr[indexPath.row];
    }else{
        name=_serverDataArr[indexPath.row];
    }
    
    [vv.lbName setText:name];
    
    [vv.btBg addTarget:self action:@selector(bookViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    vv.selected = [name isEqual:_strName];
    
    return cell;
}

#pragma mark - BookView Listener

- (void)bookViewClicked:(UIButton *)button {
    if (_oldView) {
        _oldView.selected = NO;
        _oldView = nil;
        _strName = nil;
    }
    LanguageCell *bookView = (LanguageCell *)(button.superview);
    if (bookView.selected) {
        _strName = bookView.lbName.text;
        _oldView = bookView;
    }
    else {
        _strName = nil;
    }
    
    if (_strName) {
        [_lbSave setHidden:NO];
        [_btSave setEnabled:YES];
    }else{
        [_lbSave setHidden:YES];
        [_btSave setEnabled:NO];
    }
    
}


#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [self.searchController.searchBar text];
    
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.serverDataArr.count; i++) {
        NSString *storeString = _serverDataArr[i];
        
        NSRange storeRange = NSMakeRange(0, storeString.length);
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            
            [tempResults addObject:storeString];
        }
        
    }
    [_searchResultArr removeAllObjects];
    [_searchResultArr addObjectsFromArray:tempResults];
    
    //刷新表格
    [self.tableView reloadData];
}

@end

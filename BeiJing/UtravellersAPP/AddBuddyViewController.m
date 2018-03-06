//
//  AddBuddyViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/22.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "AddBuddyViewController.h"
#import "AddBuddyCell.h"
#import "ContactModel.h"
#import "ContactDataHelper.h"//根据拼音A~Z~#进行排序的tool
//#import "ContactTableViewCell.h"

@interface AddBuddyViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lbSelection;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;

@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation AddBuddyViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listArray = @[@{@"name":@"Relatives"}, @{@"name":@"Andorra"}, @{@"name":@"Angola"}, @{@"name":@"Antigua and Barbuda"}, @{@"name":@"Argentina"}, @{@"name":@"Armenia"}];
    self.dataArr = [[NSMutableArray alloc] init];
    [_dataArr addObjectsFromArray:_listArray];
    
    
    [_tfSearch addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    NSString* content = @"Selection based on nationality and language";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, content.length)];
    NSRange start = [content rangeOfString:@"nationality"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0 / 255 green:185.0 / 255 blue:0.0 / 255 alpha:1.0] range:start];
    start = [content rangeOfString:@"language"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0 / 255 green:185.0 / 255 blue:0.0 / 255 alpha:1.0] range:start];
    _lbSelection.attributedText = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
   
    if (_bSearch) {
        _bSearch = NO;
        [_dataArr removeAllObjects];
        [_dataArr addObjectsFromArray:_listArray];
        [_tableView reloadData];
        [_tfSearch resignFirstResponder];
        _tfSearch.text = @"";
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

#pragma mark--
#pragma mark--UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    _bSearch = YES;
    [_dataArr removeAllObjects];
    [_tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField.text length] == 0) {
        return YES;
    }
    
    //==>
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 0) {
       
        [self updateSearchResultsForSearch:textField.text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 32;
}


#pragma mark - UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    NSDictionary *d = [_dataArr objectAtIndex:row];
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    AddBuddyCell* vv = [cell viewWithTag:123];
    vv.delegate = self;
    vv.superViewCon = self;
    vv.m_dict = d;
    
    [vv.lbName setText:[d objectForKey:@"name"]];
    
    return cell;
}

#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
-(void)updateSearchResultsForSearch:(NSString *)search {
    NSString *searchText = search;
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.listArray.count; i++) {
        NSDictionary *d = _listArray[i];
        NSString *storeString = [d objectForKey:@"name"];
        
        NSRange storeRange = NSMakeRange(0, storeString.length);
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            
            [tempResults addObject:d];
        }
        
    }
    [_dataArr removeAllObjects];
    [_dataArr addObjectsFromArray:tempResults];
    
    //刷新表格
    [self.tableView reloadData];
}

- (void)followCallBack:(UIView*)v
{
    AddBuddyCell* abc = (AddBuddyCell*)v;
    [_dataArr removeObject:abc.m_dict];
    [self.tableView reloadData];
}

@end

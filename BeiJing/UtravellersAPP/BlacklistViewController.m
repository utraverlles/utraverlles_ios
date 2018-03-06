//
//  BlacklistViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/27.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "BlacklistViewController.h"
#import "BlacklistCell.h"

@interface BlacklistViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *listArray;
@end

@implementation BlacklistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listArray = [[NSMutableArray alloc] init];
    [_listArray addObjectsFromArray:@[@{@"name":@"Relatives"}, @{@"name":@"Andorra"}, @{@"name":@"Angola"}, @{@"name":@"Antigua and Barbuda"}, @{@"name":@"Argentina"}, @{@"name":@"Armenia"}]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSDictionary *d = [_listArray objectAtIndex:row];
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString* name = [d objectForKey:@"name"];
    BlacklistCell* vv = [cell viewWithTag:123];
    vv.lbName.text = name;
    
    vv.delegate = self;
    vv.superViewCon = self;
    vv.m_dict = d;
    
    return cell;
}

- (void)removeCallBack:(UIView*)v
{
    BlacklistCell* abc = (BlacklistCell*)v;
    [_listArray removeObject:abc.m_dict];
    [self.tableView reloadData];
}
@end

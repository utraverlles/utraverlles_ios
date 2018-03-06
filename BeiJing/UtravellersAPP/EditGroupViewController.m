//
//  EditGroupViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/21.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "EditGroupViewController.h"
#import "EditGroupCell.h"
#import "MsgView4.h"

@interface EditGroupViewController ()
@property (nonatomic) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation EditGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listArray = [[NSMutableArray alloc] init];
    [_listArray addObjectsFromArray:@[@{@"name":@"Relatives"}, @{@"name":@"Andorra"}, @{@"name":@"Angola"}, @{@"name":@"Antigua and Barbuda"}, @{@"name":@"Argentina"}, @{@"name":@"Armenia"}]];
    
    [self.tableView setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addAction:(id)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView4" bundle:nil];
    MsgView4 *msgView = (MsgView4*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView4"];
    msgView.delegate = self;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_listArray count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //    需要的移动行
    NSInteger fromRow = [sourceIndexPath row];
    //    获取移动某处的位置
    NSInteger toRow = [destinationIndexPath row];
    //    从数组中读取需要移动行的数据
//    id object = [self.listData objectAtIndex:fromRow];
    //    在数组中移动需要移动的行的数据
//    [self.listData removeObjectAtIndex:fromRow];
    //    把需要移动的单元格数据在数组中，移动到想要移动的数据前面
//    [self.listData insertObject:object atIndex:toRow];
}


//单元格返回的编辑风格，包括删除 添加 和 默认  和不可编辑三种风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (tableView == _tableView)
        {
            NSDictionary *d = [_listArray objectAtIndex:indexPath.row];
            
//            NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
//            [parameters_ setObject:[NSString stringWithFormat:@"%@", [User_Dict objectForKey:@"userid"]] forKey:@"userid"];
//            [parameters_ setObject:[NSString stringWithFormat:@"%@", [User_Dict objectForKey:@"token"]] forKey:@"token"];
//            [parameters_ setObject:[d objectForKey:@"groupId"] forKey:@"groupId"];
//            WebPostClass *web = [[WebPostClass alloc] init];
//            web.postID = 2;
//            web.showLoadingBool = NO;
//            web.delegate = self;
//            [web getHttpData:@"oftenPatient/delGroup" parameters:parameters_];
            
            [_listArray removeObjectAtIndex:indexPath.row];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"%@", @"删除");
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        NSLog(@"%@", @"编辑");
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSDictionary *d = [_listArray objectAtIndex:row];
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString* name = [d objectForKey:@"name"];
    EditGroupCell* vv = [cell viewWithTag:123];
    vv.lbName.text = name;
   
    vv.superViewCon = self;
    vv.m_dict = d;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//删除选中状态
    
//    NSDictionary *d = [_listArray objectAtIndex:indexPath.row];
    
//    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ManageGroupViewController" bundle:nil];
//    ManageGroupViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ManageGroupViewController"];  //
//    door.m_dict = d;
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    [self.navigationController pushViewController:door animated:YES];
    
}


#pragma MsgView4Delegate
- (void)addGroup:(NSString*)pr
{
    [_listArray addObject:@{@"name":pr}];
    [_tableView reloadData];
}

@end

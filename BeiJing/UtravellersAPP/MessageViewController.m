//
//  MessageViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/14.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCellView.h"
#import "FootBall4_8.h"

@interface MessageViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *listArray;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listArray = @[@{@"portrait":@"1",@"name":@"aaa",@"content":@"最近怎么样了，拍到那个花瓶了吗？",@"uid":@"1"},
                       @{@"portrait":@"2",@"name":@"花无缺",@"content":@"最近怎么样了，拍到那个花瓶了吗？",@"uid":@"2"},
                       @{@"portrait":@"3",@"name":@"东方不败",@"content":@"最近怎么样了，拍到那个花瓶了吗？",@"uid":@"3"},
                       @{@"portrait":@"4",@"name":@"任我行",@"content":@"最近怎么样了，拍到那个花瓶了吗？",@"uid":@"4"},
                       @{@"portrait":@"18",@"name":@"欧弟",@"content":@"最近怎么样了，拍到那个花瓶了吗？",@"uid":@"18"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)contactsAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ContactsViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ContactsViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

#pragma mark -
#pragma mark Table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [_listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *d = [_listArray objectAtIndex:row];
    NSString* name = [d objectForKey:@"name"];
    NSString* portrait = [d objectForKey:@"portrait"];
    NSString* content = [d objectForKey:@"content"];
    
    MessageCellView* vv = [cell viewWithTag:123];
    vv.lbName.text = name;
    [vv.ivLogo setImage:[UIImage imageNamed:portrait]];
    [vv.lbContent setText:content];
//    [vv.ivLogo sd_setImageWithURL:[NSURL URLWithString:image] completed: ^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (img == nil) {
//            [vv.ivLogo setImage:[UIImage imageNamed:@"默认头像.png"]];
//        }
//    }];
//    vv.lbContent.text = content;
//    vv.lbTime.text = [self compareCurrentTime:dt];
//    if([new_count intValue] == 0)
//    {
//        [vv.countView setHidden:YES];
//    }else{
//        [vv.countView setHidden:NO];
//        vv.lbCount.text = new_count;
//    }
    
    vv.superViewCon = self;
    vv.m_dict = d;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    
    NSDictionary *d = [_listArray objectAtIndex:row];
    NSString* name = [d objectForKey:@"name"];
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FootBall4_8" bundle:nil];
    FootBall4_8 *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FootBall4_8"];  //
    door.m_titleName = name;
    door.m_historyD = d;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}



@end

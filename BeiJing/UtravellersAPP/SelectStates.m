//
//  MsgView1.m
#import "SelectStates.h"
@interface SelectStates ()
@property (weak, nonatomic) IBOutlet UIButton *btOK;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcHeight;

@property (nonatomic) NSMutableArray *listArray;
@property (nonatomic,strong) NSString* strName;
@end

@implementation SelectStates
- (void)viewDidLoad {
	[super viewDidLoad];
	//self.isNoNavigationBarBool = YES;
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.listArray = [[NSMutableArray alloc] init];
    [_listArray addObjectsFromArray:@[@{@"name":@"Embassy of the United States"},
                                      @{@"name":@"U.S. consulate general in Shanghai"},
                                      @{@"name":@"U.S. consulate general in Chengdu"},
                                      @{@"name":@"U.S. consulate general in Guangzhou"},
                                      @{@"name":@"U.S. consulate general in Shenyang"},
                                      @{@"name":@"U.S. consulate general in Shenyang"},
                                      @{@"name":@"U.S. consulate general in Hong Kong"}]];
    
    if ([_listArray count] < 6) {
        [_lcHeight setConstant:[_listArray count]*44];
    }
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


- (IBAction)backAction:(id)sender {
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)okAction:(UIButton*)sender {
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
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
    UILabel* lbName = [cell viewWithTag:1001];
    lbName.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [_delegate okCallBack:indexPath.row];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end

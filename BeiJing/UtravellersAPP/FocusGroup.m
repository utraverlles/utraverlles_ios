//
//  MsgView1.m
#import "FocusGroup.h"
#import "FocusGroupCell.h"

@interface FocusGroup ()
@property (weak, nonatomic) IBOutlet UIButton *btOK;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *listArray;
@property (nonatomic,strong) NSString* strName;
@property (nonatomic) FocusGroupCell *oldView;
@end
@implementation FocusGroup
- (void)viewDidLoad {
	[super viewDidLoad];
	//self.isNoNavigationBarBool = YES;
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.listArray = [[NSMutableArray alloc] init];
    [_listArray addObjectsFromArray:@[@{@"name":@"Chowhound Squad"},
                                      @{@"name":@"Playing Together"},
                                      @{@"name":@"Beauty Master"},
                                      @{@"name":@"Know-It-All"},
                                      @{@"name":@"Sports Talent"}]];

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}



- (IBAction)backAction:(id)sender {
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)okAction:(id)sender {
    
    [_delegate selectGroup:_strName];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)newAction:(id)sender {
    
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
    FocusGroupCell* vv = [cell viewWithTag:123];
    vv.lbName.text = name;
    
    vv.superViewCon = self;
    vv.m_dict = d;
    
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
    FocusGroupCell *bookView = (FocusGroupCell *)(button.superview);
    if (bookView.selected) {
        _strName = bookView.lbName.text;
        _oldView = bookView;
    }
    else {
        _strName = nil;
    }
    
    if (_strName) {
        [_btOK setTitleColor:RGB(255, 185, 0) forState:0];
        [_btOK setEnabled:YES];
    }else{
        [_btOK setTitleColor:RGB(109, 113, 125) forState:0];
        [_btOK setEnabled:NO];
    }
    
}
@end

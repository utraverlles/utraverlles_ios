//
//  MsgView1.m
#import "MsgView14.h"
@interface MsgView14 ()
@property (weak, nonatomic) IBOutlet UITextField *tfPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbStepMoney;

@end
@implementation MsgView14
- (void)viewDidLoad {
	[super viewDidLoad];
	//self.isNoNavigationBarBool = YES;
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:NO];
    _tfPrice.text = _m_titleName;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}



- (IBAction)backAction:(id)sender {
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)groupAction:(id)sender {
    
    [_delegate groupCallBack];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)unfollowAction:(id)sender {
    
    [_delegate unfollowCallBack];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end

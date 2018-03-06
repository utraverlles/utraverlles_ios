//
//  MsgView1.m
#import "MsgView13.h"
@interface MsgView13 ()
@property (weak, nonatomic) IBOutlet UITextField *tfPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbStepMoney;

@end
@implementation MsgView13
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

- (IBAction)okAction:(id)sender {
    
    if ([_tfPrice.text length] == 0) {
        return;
    }
    [_delegate editGroup:_tfPrice.text];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end

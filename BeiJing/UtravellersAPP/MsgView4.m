//
//  MsgView1.m
#import "MsgView4.h"
@interface MsgView4 ()
@property (weak, nonatomic) IBOutlet UITextField *tfPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbStepMoney;

@end
@implementation MsgView4
- (void)viewDidLoad {
	[super viewDidLoad];
	//self.isNoNavigationBarBool = YES;
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:NO];
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
    [_delegate addGroup:_tfPrice.text];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end

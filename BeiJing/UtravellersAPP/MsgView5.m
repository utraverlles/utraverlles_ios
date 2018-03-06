//
//  MsgView1.m
#import "MsgView5.h"
@interface MsgView5 ()

@end
@implementation MsgView5
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

- (IBAction)buddyAction:(UIButton*)sender {
 
    [_delegate buddyCallBack];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)blackAction:(UIButton*)sender {
    
    [_delegate blackCallBack];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
@end

//
//  MsgView1.m
#import "MsgView6.h"
@interface MsgView6 ()

@end
@implementation MsgView6
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

- (IBAction)okAction:(UIButton*)sender {
 
    [_delegate okCallBack];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


@end

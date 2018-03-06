//
//  MsgView1.m
#import "MsgView15.h"
@interface MsgView15 ()

@end
@implementation MsgView15
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
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


@end

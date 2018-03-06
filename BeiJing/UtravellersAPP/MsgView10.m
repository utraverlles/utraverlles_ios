//
//  MsgView1.m
#import "MsgView10.h"
@interface MsgView10 ()

@end

@implementation MsgView10
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

    [_delegate addSuccess];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end

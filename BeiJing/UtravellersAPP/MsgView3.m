//
//  MsgView1.m
#import "MsgView3.h"
@interface MsgView3 ()

@end
@implementation MsgView3
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
    
    [_delegate cancelCallBack];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)okAction:(UIButton*)sender {
 
    [_delegate delectCallBack];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


@end

//
//  MsgView1.m
#import "MsgView8.h"
@interface MsgView8 ()

@end
@implementation MsgView8
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

- (IBAction)chatAction:(UIButton*)sender {
 
    [_delegate chatCallBack];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)groupAction:(UIButton*)sender {
    
    [_delegate groupCallBack];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)unfollowAction:(UIButton*)sender {
    
    [_delegate unfollowCallBack];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
@end

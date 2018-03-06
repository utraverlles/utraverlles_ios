//
//  MsgView1.m
#import "MsgView11.h"
@interface MsgView11 ()
@property (weak, nonatomic) IBOutlet UILabel *lbLable1;

@end

@implementation MsgView11
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

    [_delegate okSuccess];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end

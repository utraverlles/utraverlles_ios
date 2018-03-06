//
//  MsgView1.m
#import "MsgView2.h"
@interface MsgView2 ()

@end
@implementation MsgView2
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
    
    switch (sender.tag) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}


@end

//
//  MsgView1.m
#import "SelectSex.h"
@interface SelectSex ()
@property (weak, nonatomic) IBOutlet UIButton *btMale;
@property (weak, nonatomic) IBOutlet UIButton *btFamale;
@end
@implementation SelectSex
- (void)viewDidLoad {
	[super viewDidLoad];
	//self.isNoNavigationBarBool = YES;
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:NO];
 
    if ([self.m_titleName isEqual:@"Male"]) {
        [self.btMale setTitleColor:RGB(255, 185, 0) forState:0];
    }else if([self.m_titleName isEqual:@"Famale"]){
        [self.btFamale setTitleColor:RGB(255, 185, 0) forState:0];
    }
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}



- (IBAction)backAction:(id)sender {
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)maleAction:(UIButton*)sender {
 
    [_delegate sexCallBack:_btMale.titleLabel.text];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)famaleAction:(UIButton*)sender {
    
    [_delegate sexCallBack:_btFamale.titleLabel.text];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
@end

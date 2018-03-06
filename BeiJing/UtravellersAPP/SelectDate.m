//
//  MsgView1.m
#import "SelectDate.h"
@interface SelectDate ()
@property (weak, nonatomic) IBOutlet UIDatePicker *dateSelect;
@end
@implementation SelectDate
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

- (IBAction)okAction:(UIButton*)sender {
    
    [_delegate dateCallBack:[_dateSelect date]];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end

//
//  MsgView1.m
#import "MsgView9.h"
@interface MsgView9 ()
@property (weak, nonatomic) IBOutlet UILabel *lbLable1;

@end
@implementation MsgView9
- (void)viewDidLoad {
	[super viewDidLoad];
	//self.isNoNavigationBarBool = YES;
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:NO];
    
    NSString* content = [NSString stringWithFormat:@"Add %@ as a friend", _m_titleName];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
    //    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, content.length)];
    NSRange start = [content rangeOfString:_m_titleName];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0 / 255 green:185.0 / 255 blue:0.0 / 255 alpha:1.0] range:start];
    _lbLable1.attributedText = str;
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

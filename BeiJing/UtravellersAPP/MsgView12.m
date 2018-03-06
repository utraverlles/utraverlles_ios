//
//  MsgView1.m
#import "MsgView12.h"
@interface MsgView12 ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *View1;
@property (weak, nonatomic) IBOutlet UIView *View2;

@end

@implementation MsgView12
- (void)viewDidLoad {
	[super viewDidLoad];
	//self.isNoNavigationBarBool = YES;
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:NO];
    
//    _bgView.alpha= 0.0f;
//    [UIView beginAnimations:@"fadeIn" context:nil];
//    [UIView setAnimationDuration:0.7];
//    //            [UIView setAnimationRepeatAutoreverses:YES];
//    [UIView setAnimationRepeatCount:1];
//    _bgView.alpha= 1.0f;
//    [UIView commitAnimations];
    
    self.bgView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    // 放大缩小动画
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.bgView.center = CCP(ViewSize(self.bgView).width-20, ViewSize(self.bgView).height+20);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}



- (IBAction)backAction:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.transform = CGAffineTransformMakeScale(0.05, 0.05);
        self.bgView.center = CCP(20, 84);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    
}

- (IBAction)editGroupAction:(id)sender {

    [_delegate editGroupCallBack];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)select1Action:(UIButton*)bt {
   
    NSArray* a = [self.View1 subviews];
    for (UIView* v in a) {
        NSArray* a1 = [v subviews];
        UIView* v0 = a1[0];
        UIView* v1 = a1[1];
        v0.alpha= 0.0f;
        [v1 setHidden:YES];
    }
    
    UIView* vv = a[bt.tag];
    NSArray* a1 = [vv subviews];
    UIView* v0 = a1[0];
    UIView* v1 = a1[1];
    v0.alpha= 1.0f;
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatCount:1];
    v0.alpha= 0.0f;
    [UIView commitAnimations];
    
    [v1 setHidden:NO];
}

- (IBAction)select2Action:(UIButton*)bt {
    
    NSArray* a = [self.View2 subviews];
    for (UIView* v in a) {
        NSArray* a1 = [v subviews];
        UIView* v0 = a1[0];
        UIView* v1 = a1[1];
        v0.alpha= 0.0f;
        [v1 setHidden:YES];
    }
    
    UIView* vv = a[bt.tag];
    NSArray* a1 = [vv subviews];
    UIView* v0 = a1[0];
    UIView* v1 = a1[1];
    v0.alpha= 1.0f;
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatCount:1];
    v0.alpha= 0.0f;
    [UIView commitAnimations];
    
    [v1 setHidden:NO];
}
@end

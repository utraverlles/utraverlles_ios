//
//  PhoneRegisterViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/10.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "PhoneRegisterViewController.h"

@interface PhoneRegisterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbCode;
@property (weak, nonatomic) IBOutlet UIButton *btCode;

@end

@implementation PhoneRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_second = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)loginAction:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"PersonalSettingsViewController" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PersonalSettingsViewController"];  //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

//获取验证码
- (IBAction)IdcodeAction:(id)sender {
    
    if (m_second == -1) {
        
        m_second = 60;
        _lbCode.text = [NSString stringWithFormat:@"%d seconds to resend", m_second];
        [_btCode setHidden:YES];
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                                              target:self
                                                            selector:@selector(handleMaxShowTimer:)
                                                            userInfo:nil
                                                             repeats:YES];
        
    }
}


//触发事件
-(void)handleMaxShowTimer:(NSTimer *)theTimer
{
    
    m_second --;
    _lbCode.text = [NSString stringWithFormat:@"%d seconds to resend", m_second];
    [_btCode setHidden:YES];
    
    if (m_second == -1) {
        
        _lbCode.text = @"";
        [_btCode setHidden:NO];
        [theTimer invalidate];
    }
    
}

@end

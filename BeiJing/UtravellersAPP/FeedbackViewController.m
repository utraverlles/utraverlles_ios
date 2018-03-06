//
//  FeedbackViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/8.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "FeedbackViewController.h"
#import "IdentifierValidator.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface FeedbackViewController ()
@property (weak, nonatomic) IBOutlet ALAutoResizingTextView *myTextView;
@property (weak, nonatomic) IBOutlet UIControl *controView;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitAction:(id)sender {
    
    //网络请求
    if ([_myTextView.text length] == 0) {
        [IdentifierValidator showCancelAlert:self msg:@"内容不能为空"];
        return;
    }
}

- (IBAction)controViewAction:(UIControl *)sender {
    [_myTextView resignFirstResponder];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    [_controView setHidden:NO];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    [_controView setHidden:YES];
}
@end

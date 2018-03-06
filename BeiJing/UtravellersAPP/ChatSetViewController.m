//
//  ChatSetViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/27.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ChatSetViewController.h"

@interface ChatSetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbTitleName;

@end

@implementation ChatSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lbTitleName.text = _m_titleName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
   
    [self.navigationController popViewControllerAnimated:YES];
}
@end

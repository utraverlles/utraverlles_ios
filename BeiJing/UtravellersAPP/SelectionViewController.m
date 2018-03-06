//
//  SelectionViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/12.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "SelectionViewController.h"
#import "RegionViewController.h"
#import "LanguageViewController.h"

@interface SelectionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbRegion;
@property (weak, nonatomic) IBOutlet UILabel *lbLanguage;
@property (weak, nonatomic) IBOutlet UIButton *btMale;
@property (weak, nonatomic) IBOutlet UIButton *btFemale;

@end

@implementation SelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)searchAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//区域
- (IBAction)regionAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"RegionViewController" bundle:nil];
    RegionViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"RegionViewController"];  //
    door.delegate = self;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

//语言
- (IBAction)languageAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LanguageViewController" bundle:nil];
    LanguageViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"LanguageViewController"];  //
    door.delegate = self;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

- (IBAction)maleAction:(id)sender {
    
    [_btMale setTitleColor:RGB(255, 185, 0) forState:0];
    [_btFemale setTitleColor:RGB(91, 89, 89) forState:0];
}

- (IBAction)femaleAction:(id)sender {
    
    [_btMale setTitleColor:RGB(91, 89, 89) forState:0];
    [_btFemale setTitleColor:RGB(255, 185, 0) forState:0];
}


#pragma RegionDelegate
- (void)regionCallBack:(NSString*)str {
    
    _lbRegion.text = str;
}

#pragma LanguageDelegate
- (void)languageCallBack:(NSString*)str {
    
    _lbLanguage.text = str;
}
@end

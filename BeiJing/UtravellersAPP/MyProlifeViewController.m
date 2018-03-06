//
//  MyProlifeViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/27.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "MyProlifeViewController.h"
#import "SelectSex.h"
#import "SelectDate.h"
#import "RegionViewController.h"
#import "LanguageViewController.h"
#import "SelectPhoto.h"
#import "UIImage+Scale.h"
#import "EidtName.h"

@interface MyProlifeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbGender;
@property (weak, nonatomic) IBOutlet UILabel *lbBirthday;
@property (weak, nonatomic) IBOutlet UILabel *lbRegion;
@property (weak, nonatomic) IBOutlet UILabel *lbLanguage;

@end

@implementation MyProlifeViewController

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

//头像
- (IBAction)logoAction:(id)sender {
    
    SelectPhoto *v = [[SelectPhoto alloc] init];
    v.delegate = self;
    [self addChildViewController:v];
    [self.view addSubview:v.view];
}

//名字
- (IBAction)nameAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"EidtName" bundle:nil];
    EidtName *msgView = (EidtName*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"EidtName"];
    msgView.delegate = self;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}

//性别
- (IBAction)genderAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"SelectSex" bundle:nil];
    SelectSex *msgView = (SelectSex*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectSex"];
    msgView.delegate = self;
    msgView.m_titleName = _lbGender.text;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
}

//生日
- (IBAction)birthdayAction:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"SelectDate" bundle:nil];
    SelectDate *msgView = (SelectDate*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectDate"];
    msgView.delegate = self;
    msgView.m_titleName = _lbBirthday.text;
    [self addChildViewController:msgView];
    [self.view addSubview:msgView.view];
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

#pragma SelectPhoto
- (void)changePhotos:(UIImage *)img {
    NSLog(@"图片已经选择");
    [_ivLogo setImage:img];
    
}

#pragma EidtNameDelegate
- (void)eidtSuccess:(NSString*)str {
    
    _lbName.text = str;
}

#pragma SelectSexDelegate
- (void)sexCallBack:(NSString*)str {
    
    _lbGender.text = str;
}

#pragma SelectDateDelegate
- (void)dateCallBack:(NSDate*)date {
    NSDateFormatter *forTime = [[NSDateFormatter alloc]init];
    [forTime setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [forTime stringFromDate:date];
    _lbBirthday.text = str;
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

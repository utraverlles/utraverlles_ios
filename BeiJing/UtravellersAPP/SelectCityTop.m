//
//  SelectCityTop.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/13.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "SelectCityTop.h"

@interface SelectCityTop ()
@property (weak, nonatomic) IBOutlet UIView *list1View;
@property (weak, nonatomic) IBOutlet UIView *list2View;
@property (weak, nonatomic) IBOutlet UIView *list3View;

@property (nonatomic) NSArray *list1Array;
@property (nonatomic) NSArray *list2Array;
@property (nonatomic) NSArray *list3Array;
@end

@implementation SelectCityTop

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.list1Array = @[_m_titleName];
    self.list2Array = @[_m_titleName];
    self.list3Array = @[@"Beijing", @"Shanghai", @"Chengdu", @"Tianjing", @"Chongqing", @"Xi An"];
    
    [self createList1Data:_list1Array];
    [self createList2Data:_list2Array];
    [self createList3Data:_list3Array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createList1Data:(NSArray *)dataArray {
    
    UIView *view = _list1View;
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    
    UIView *s_v = nil;
    NSArray *a = [view constraints];
    [view removeConstraints:a];
    
    int col = 3;
    float wid = 90;
    float hei = 30;
    float space = 0;
    if (col > 1) {
        space = ((ScreenSize.width - 15*2) - col*wid)/(col-1);
    }
    
    for (int i = 0; i < [dataArray count]; i++) {
     
        NSString* name = dataArray[i];
        UIButton* bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, wid, hei)];
        [bt setTranslatesAutoresizingMaskIntoConstraints:false];
        [bt setBackgroundColor:[UIColor whiteColor]];
        [bt.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bt setTitleColor:RGB(255, 185, 0) forState:0];
        [bt setTitle:name forState:0];
        bt.layer.masksToBounds = YES;
        bt.layer.cornerRadius = hei/2.0;
        bt.layer.borderWidth = 1.0;
        bt.layer.borderColor = [RGB(255, 185, 0) CGColor];
        [bt addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:bt];
        [viewArray addObject:bt];
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            
            NSLayoutConstraint *c00 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            NSLayoutConstraint *c01 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:hei];
            [v addConstraint:c00];
            [v addConstraint:c01];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:10];
            [view addConstraint:c1];
            [view addConstraint:c2];
            s_v = v;
            k++;
            continue;
        }
        
        if (k % col == 0) {
            NSLayoutConstraint *c00 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            NSLayoutConstraint *c01 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:hei];
            [v addConstraint:c00];
            [v addConstraint:c01];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:15];
            
            [view addConstraint:c1];
            [view addConstraint:c2];
        }else{
            NSLayoutConstraint *c00 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            NSLayoutConstraint *c01 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:hei];
            [v addConstraint:c00];
            [v addConstraint:c01];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeTrailing multiplier:1 constant:space];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            
            [view addConstraint:c1];
            [view addConstraint:c2];
        }
        
        s_v = v;
        k++;
    }
    
    if(s_v != nil)
    {
        //让SUPERVIEW的底 = 最后一个VIEW的底
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        [view addConstraint:c3];
    }
}

- (void)createList2Data:(NSArray *)dataArray {
    
    UIView *view = _list2View;
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    
    UIView *s_v = nil;
    NSArray *a = [view constraints];
    [view removeConstraints:a];
    
    int col = 3;
    float wid = 90;
    float hei = 30;
    float space = 0;
    if (col > 1) {
        space = ((ScreenSize.width - 15*2) - col*wid)/(col-1);
    }
    
    for (int i = 0; i < [dataArray count]; i++) {
        
        NSString* name = dataArray[i];
        UIButton* bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, wid, hei)];
        [bt setTranslatesAutoresizingMaskIntoConstraints:false];
        [bt setBackgroundColor:[UIColor whiteColor]];
        [bt.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bt setTitleColor:RGB(74, 74, 74) forState:0];
        [bt setTitle:name forState:0];
        bt.layer.masksToBounds = YES;
        bt.layer.cornerRadius = hei/2.0;
        bt.layer.borderWidth = 1.0;
        bt.layer.borderColor = [RGB(151, 151, 151) CGColor];
        [bt addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:bt];
        [viewArray addObject:bt];
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            
            NSLayoutConstraint *c00 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            NSLayoutConstraint *c01 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:hei];
            [v addConstraint:c00];
            [v addConstraint:c01];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:10];
            [view addConstraint:c1];
            [view addConstraint:c2];
            s_v = v;
            k++;
            continue;
        }
        
        if (k % col == 0) {
            NSLayoutConstraint *c00 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            NSLayoutConstraint *c01 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:hei];
            [v addConstraint:c00];
            [v addConstraint:c01];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:15];
            
            [view addConstraint:c1];
            [view addConstraint:c2];
        }else{
            NSLayoutConstraint *c00 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            NSLayoutConstraint *c01 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:hei];
            [v addConstraint:c00];
            [v addConstraint:c01];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeTrailing multiplier:1 constant:space];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            
            [view addConstraint:c1];
            [view addConstraint:c2];
        }
        
        s_v = v;
        k++;
    }
    
    if(s_v != nil)
    {
        //让SUPERVIEW的底 = 最后一个VIEW的底
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        [view addConstraint:c3];
    }
}

- (void)createList3Data:(NSArray *)dataArray {
    
    UIView *view = _list3View;
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    
    UIView *s_v = nil;
    NSArray *a = [view constraints];
    [view removeConstraints:a];
    
    int col = 3;
    float wid = 90;
    float hei = 30;
    float space = 0;
    if (col > 1) {
        space = ((ScreenSize.width - 15*2) - col*wid)/(col-1);
    }
    
    for (int i = 0; i < [dataArray count]; i++) {
        
        NSString* name = dataArray[i];
        UIButton* bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, wid, hei)];
        [bt setTranslatesAutoresizingMaskIntoConstraints:false];
        [bt setBackgroundColor:[UIColor whiteColor]];
        [bt.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bt setTitleColor:RGB(109, 113, 125) forState:0];
        [bt setTitle:name forState:0];
        bt.layer.masksToBounds = YES;
        bt.layer.cornerRadius = hei/2.0;
        bt.layer.borderWidth = 1.0;
        bt.layer.borderColor = [RGB(151, 151, 151) CGColor];
        [bt addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:bt];
        [viewArray addObject:bt];
    }
    
    int k = 0;
    for (UIView *v in viewArray) {
        if (s_v == nil) {
            
            NSLayoutConstraint *c00 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            NSLayoutConstraint *c01 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:hei];
            [v addConstraint:c00];
            [v addConstraint:c01];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:10];
            [view addConstraint:c1];
            [view addConstraint:c2];
            s_v = v;
            k++;
            continue;
        }
        
        if (k % col == 0) {
            NSLayoutConstraint *c00 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            NSLayoutConstraint *c01 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:hei];
            [v addConstraint:c00];
            [v addConstraint:c01];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:15];
            
            [view addConstraint:c1];
            [view addConstraint:c2];
        }else{
            NSLayoutConstraint *c00 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:wid];
            NSLayoutConstraint *c01 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:hei];
            [v addConstraint:c00];
            [v addConstraint:c01];
            NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeTrailing multiplier:1 constant:space];
            NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            
            [view addConstraint:c1];
            [view addConstraint:c2];
        }
        
        s_v = v;
        k++;
    }
    
    if(s_v != nil)
    {
        //让SUPERVIEW的底 = 最后一个VIEW的底
        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:s_v attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        [view addConstraint:c3];
    }
}

- (IBAction)buttonClicked:(UIButton*)sender {

//    NSLog(@"name == %@", sender.titleLabel.text);
    [_delegate topCallBack:sender.titleLabel.text];
}


@end

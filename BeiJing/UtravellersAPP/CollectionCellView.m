//
//  CollectionCellView.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/10.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "CollectionCellView.h"
#import "NoteDetailViewController.h"
#import "OthersViewController.h"

//缩放比例
static CGFloat scaleF = 0;
//手势滑动的速度系数
static CGFloat speedF = 0.5;

#define scrollSpace 62

@implementation CollectionCellView
- (void)awakeFromNib {
    [super awakeFromNib];
    
    _centerX = ScreenSize.width - 62/2;

    //Pan 拖动手势
    UIPanGestureRecognizer *tp=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragGestureEvents:)];
    tp.delegate=self;
    //    tp.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tp];
}

- (IBAction)othersAction:(id)sender{
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"OthersViewController" bundle:nil];
    OthersViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"OthersViewController"];  //
    door.m_dict = _m_dict;
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
}

- (IBAction)buttonCallBack:(UIButton *)sender {
    
//    [self setSelected:_selected ? NO : YES];
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NoteDetailViewController" bundle:nil];
    NoteDetailViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"NoteDetailViewController"];  //
    door.m_dict = _m_dict;
    door.m_bbsID = [_m_dict objectForKey:@"uid"];
    door.imageArray = [[NSArray alloc] init];
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
}


- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        [_rightView setHidden:NO];
    }
    else {
        [_rightView setHidden:YES];
        
    }
}

- (void)dragGestureEvents:(UIPanGestureRecognizer *)pan
{
    UIView *view = [pan view];
    //1.判断方向
    CGPoint point = [pan translationInView:view];
    
    scaleF = point.x + speedF + scaleF;
    
    if (1) {
        //显示左面菜单
        //计算当前菜单的显示中心点位置
        CGFloat x = _rightView.center.x + point.x + speedF;
        
        if (x > _centerX+scrollSpace) {
            x = _centerX+scrollSpace;
        }
        if (x < _centerX) {
            x = _centerX;
        }
        _rightView.center = CGPointMake(x, _rightView.center.y);
        
        //计算缩放比例
        //得到一个滑动偏移量的百分比
        CGFloat sx = 1 - scaleF / 1000;
        CGFloat sy = 0;
        _rightView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, sx, sy);
        
        //还原手势
        [pan setTranslation:CGPointZero inView:view];
        
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        //手势结束
        //滑动偏移量
        //定义偏移量范围: 160
        CGFloat offsetX = speedF + scrollSpace/2;
        if (-scaleF > offsetX) {
            //显示左边菜单
            [self showMenuLeftVC];
        } else {
            //显示主菜单
            [self showMenuRightVC];
            //当我们手指离开屏幕的时候还原偏移量
            scaleF = 0;
        }
    }
}

//左面菜单显示
- (void)showMenuLeftVC
{
    //自定义组件中常用到
    [UIView beginAnimations:nil context:nil];
    _rightView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    _rightView.center = CGPointMake(_centerX, _rightView.center.y);
    //执行动画
    [UIView commitAnimations];
    
}

//中间菜单显示
- (void)showMenuRightVC
{
    //自定义组件中常用到
    [UIView beginAnimations:nil context:nil];
    _rightView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    _rightView.center = CGPointMake(_centerX + scrollSpace, _rightView.center.y);
    //执行动画
    [UIView commitAnimations];
}

@end

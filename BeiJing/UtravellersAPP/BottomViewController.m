//
//  BottomViewController.m
//  FootBall3
//
//  Created by 王登鹏 on 15/10/29.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import "BottomViewController.h"
#import "MainNavigationController.h"



extern int iSegment;

@interface BottomViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tab_image1;
@property (weak, nonatomic) IBOutlet UIImageView *tab_image2;
@property (weak, nonatomic) IBOutlet UIImageView *tab_image3;
@property (weak, nonatomic) IBOutlet UIImageView *tab_image4;
@property (weak, nonatomic) IBOutlet UIImageView *tab_image5;
@property (weak, nonatomic) IBOutlet UILabel *tab_text1;
@property (weak, nonatomic) IBOutlet UILabel *tab_text2;
@property (weak, nonatomic) IBOutlet UILabel *tab_text3;
@property (weak, nonatomic) IBOutlet UILabel *tab_text4;
@property (weak, nonatomic) IBOutlet UILabel *tab_text5;
@end
@implementation BottomViewController
- (void)viewDidLoad {
	[super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goCommunity:) name:@"goCommunity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goNews:) name:@"goNews" object:nil];
    
	self.selectTag = 0;
	//[segmentedControl addTarget:self action:@selector(test) forControlEvents:UIControlEventValueChanged];
    UIButton* bt = [[UIButton alloc] init];
    bt.tag = 1;
    [self buttonAction:bt];
    
}

- (void)goCommunity:(NSNotification *)sender {
    
    
    UIButton* bt = [[UIButton alloc] init];
    bt.tag = 2;
    [self buttonAction:bt];
}

- (void)goNews:(NSNotification *)sender {
    
    
    UIButton* bt = [[UIButton alloc] init];
    bt.tag = 3;
    [self buttonAction:bt];
}

- (IBAction)buttonAction:(UIButton *)sender {
	/*
	   p2_14->p2_15
	   p2_13->p2_12
	   p2_6->p2_7
	   p2_11->p2_9
	   p2_10->p2_8
	 */
//     CGRect rect = self.tabBarController.tabBar.frame;
//    self.tabBarController.tabBar.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - 50);
//
	if (_selectTag == sender.tag) {
		return;
	}
   
//    self.tabBarController.navigationItem.titleView.tintColor = [UIColor colorWithRed:146.0 / 255.0 green:146.0 / 255.0 blue:146.0 / 255.0 alpha:1.0];
	self.tabBarController.navigationItem.titleView = nil;
	self.tabBarController.navigationItem.leftBarButtonItem = nil;
	self.tabBarController.navigationItem.rightBarButtonItem = nil;
	_selectTag = sender.tag;
    if(_selectTag == 5)
    {
        _selectTag = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditCommunity" object:nil];
    }
	[self.tabBarController.navigationItem.titleView removeFromSuperview];
	[self.tabBarController setSelectedIndex:_selectTag - 1];
//	UIColor *c1 = [UIColor colorWithRed:146.0 / 255.0 green:146.0 / 255.0 blue:146.0 / 255.0 alpha:1.0];
//	UIColor *c2 = [UIColor colorWithRed:9.0 / 255.0 green:145.0 / 255.0 blue:83.0 / 255.0 alpha:1.0];
//	[_tab_text1 setTextColor:c1];
//	[_tab_text2 setTextColor:c1];
//	[_tab_text3 setTextColor:c1];
//	[_tab_text4 setTextColor:c1];
//    [_tab_text5 setTextColor:c1];
	switch (_selectTag) {
        case 1:
        {
            [_tab_image1 setImage:[UIImage imageNamed:@"橙色底栏icon001"]];
            [_tab_image2 setImage:[UIImage imageNamed:@"灰色底栏icon002"]];
            [_tab_image3 setImage:[UIImage imageNamed:@"灰色底栏icon003"]];
            [_tab_image4 setImage:[UIImage imageNamed:@"灰色底栏icon004"]];
//            [_tab_text1 setTextColor:c2];
        }
            break;
		case 2:
		{
            [_tab_image1 setImage:[UIImage imageNamed:@"灰色底栏icon001"]];
            [_tab_image2 setImage:[UIImage imageNamed:@"橙色底栏icon002"]];
            [_tab_image3 setImage:[UIImage imageNamed:@"灰色底栏icon003"]];
            [_tab_image4 setImage:[UIImage imageNamed:@"灰色底栏icon004"]];
//			[_tab_text2 setTextColor:c2];
		}
		break;
		case 3:
		{
            [_tab_image1 setImage:[UIImage imageNamed:@"灰色底栏icon001"]];
            [_tab_image2 setImage:[UIImage imageNamed:@"灰色底栏icon002"]];
            [_tab_image3 setImage:[UIImage imageNamed:@"橙色底栏icon003"]];
            [_tab_image4 setImage:[UIImage imageNamed:@"灰色底栏icon004"]];
//			[_tab_text3 setTextColor:c2];
		}
		break;
		case 4:
		{
            [_tab_image1 setImage:[UIImage imageNamed:@"灰色底栏icon001"]];
            [_tab_image2 setImage:[UIImage imageNamed:@"灰色底栏icon002"]];
            [_tab_image3 setImage:[UIImage imageNamed:@"灰色底栏icon003"]];
            [_tab_image4 setImage:[UIImage imageNamed:@"橙色底栏icon004"]];
//			[_tab_text4 setTextColor:c2];
		}
		break;
        case 5:
        {
            [_tab_image1 setImage:[UIImage imageNamed:@"灰色底栏icon001"]];
            [_tab_image2 setImage:[UIImage imageNamed:@"灰色底栏icon002"]];
            [_tab_image3 setImage:[UIImage imageNamed:@"灰色底栏icon003"]];
            [_tab_image4 setImage:[UIImage imageNamed:@"灰色底栏icon004"]];
//            [_tab_text5 setTextColor:c2];
            
            _tab_image5.alpha= 0.0f;
            [UIView beginAnimations:@"fadeIn" context:nil];
            [UIView setAnimationDuration:0.7];
//            [UIView setAnimationRepeatAutoreverses:YES];
            [UIView setAnimationRepeatCount:1];
            _tab_image5.alpha= 1.0f;
            [UIView commitAnimations];
        }
            break;
		default:
			break;
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
   #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */
@end

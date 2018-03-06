//
//  CommunityCellViewController.h
//  SaleApp
//
//  Created by LuNian on 16/5/11.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
@protocol CommunityCellDelegate
- (void)playVideo:(UIViewController*)vc;
@end
@interface CommunityCellViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MWPhotoBrowserDelegate>
{
    float imageWidth;
    NSMutableArray *_selections;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (nonatomic, retain) NSArray* imageArray;
@property (nonatomic, strong) NSDictionary * videoDict;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbHitsCount;
@property (weak, nonatomic) IBOutlet UILabel *lbCommentCount;
@property (weak, nonatomic) IBOutlet UILabel *lbLikeCount;
@property (weak, nonatomic) IBOutlet UIImageView *ivZan;
@property (weak, nonatomic) IBOutlet UIButton *btZan;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *btOthers;
@end

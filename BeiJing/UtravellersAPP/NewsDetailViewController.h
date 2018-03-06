//
//  TopicDetailViewController.h
//  SaleApp
//
//  Created by LuNian on 16/5/6.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAutoResizingTextView.h"
#import "MWPhotoBrowser.h"

@interface NewsDetailViewController : UIViewController<ALAutoResizingTextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MWPhotoBrowserDelegate>
{
    CGFloat h;
    CGFloat myScrollViewFrameH;
    CGFloat myScrollViewContentH;
    
    NSString* pageFirstID;
    NSString* pageLastID;
    
    float imageWidth;
    NSMutableArray *_selections;
}

@property (nonatomic, retain) NSDictionary* m_dict;
@property (nonatomic, retain) NSString* m_bbsID;
@property (nonatomic, retain) NSArray* imageArray;
@property (nonatomic, assign) BOOL bLikes;
@property (nonatomic, assign) BOOL bCollect;
- (void)openTextView:(UIViewController*)vc;
@end

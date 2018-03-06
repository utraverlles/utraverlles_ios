//
//  CollectionCellView.h
//  UtravellersAPP
//
//  Created by LuNian on 16/10/10.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCellView : UIView


@property (nonatomic, retain) id delegate;
@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UIImageView *ivImg;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic) CGFloat centerX;
@end

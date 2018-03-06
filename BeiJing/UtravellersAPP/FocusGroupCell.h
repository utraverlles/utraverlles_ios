//
//  FocusGroupCell.h
//  UtravellersAPP
//
//  Created by LuNian on 16/10/9.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusGroupCell : UIView


@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *ivSel;
@property (weak, nonatomic) IBOutlet UIButton *btBg;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) NSInteger index;
@end

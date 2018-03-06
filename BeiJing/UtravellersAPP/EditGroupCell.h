//
//  EditGroupCell.h
//  UtravellersAPP
//
//  Created by LuNian on 16/9/21.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditGroupCell : UIView

@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end

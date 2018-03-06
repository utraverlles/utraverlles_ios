//
//  BlacklistCell.h
//  UtravellersAPP
//
//  Created by LuNian on 16/9/27.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BlacklistCellDelegate
- (void)removeCallBack:(UIView*)v;
@end
@interface BlacklistCell : UIView


@property (nonatomic, retain) id delegate;
@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@end

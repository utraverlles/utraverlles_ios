//
//  ContactsCell.h
//  UtravellersAPP
//
//  Created by LuNian on 16/9/26.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ContactsCellDelegate
- (void)chatCallBack;
@end

@interface ContactsCell : UIView


@property (nonatomic, retain) id delegate;
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

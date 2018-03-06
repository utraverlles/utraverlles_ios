//
//  ManageGroupCell.h
//  UtravellersAPP
//
//  Created by LuNian on 16/9/22.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ManageCell2Delegate <NSObject>
@optional
-(void)addCallBack;
-(void)delCallBack;
-(void)moreCallBack;
-(void)lessCallBack;
@end

@interface ManageGroupCell2 : UIView

@property (nonatomic, retain) id delegate;
@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@end

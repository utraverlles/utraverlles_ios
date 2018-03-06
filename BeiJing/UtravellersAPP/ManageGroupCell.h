//
//  ManageGroupCell.h
//  UtravellersAPP
//
//  Created by LuNian on 16/9/22.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ManageCellDelegate <NSObject>
-(void)delGroupCell:(UIView*)vv;
@optional

@end

@interface ManageGroupCell : UIView
{
    
}

@property (nonatomic, retain) id delegate;
@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UIImageView *ivDel;
@property (nonatomic) BOOL bSel;
@end

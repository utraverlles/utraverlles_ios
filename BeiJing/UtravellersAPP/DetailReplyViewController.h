//
//  DetailReplyViewController.h
//  SaleApp
//
//  Created by LuNian on 16/5/25.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailReplyDelegate
- (void)sendReply:(UIViewController*)vc name:(NSString*)name sid:(NSString*)sid;
- (void)sendReply:(UIViewController*)vc name:(NSString*)name sid:(NSString*)sid content:(NSString*)content;
@end

@interface DetailReplyViewController : UIViewController
{
    
}

@property (nonatomic, retain) id delegate;
@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (nonatomic) UIView *selfView;
@property (nonatomic) float  listY;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbName1;
@property (weak, nonatomic) IBOutlet UILabel *lbName2;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@end

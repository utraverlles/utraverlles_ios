//
//  LogoCellView.h
//  UtravellersAPP
//
//  Created by LuNian on 16/11/10.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoCellView : UIView

@property (nonatomic, retain) id delegate;
@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@end

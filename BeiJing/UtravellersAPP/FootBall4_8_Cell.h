//
//  FootBall4_8_Cell.h
//  FootBall3
//
//  Created by 王登鹏 on 15/10/28.
//  Copyright © 2015年 王登鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootBall4_8_Cell : UIView
{

}

@property (nonatomic) NSInteger group;
@property (nonatomic) NSInteger userID;
@property (nonatomic) NSString *content;
@property (weak, nonatomic) IBOutlet UIImageView *logImage;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateHeight;
@property (nonatomic) UIViewController *superViewCon;
@end
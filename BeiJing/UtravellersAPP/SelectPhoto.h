//
//  MsgView1.h
//  FootBall3
//
//  Created by 王登鹏 on 15/10/23.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol Edit1Delegate
- (void)changePhotos:(UIImage *)img;
@end
@interface SelectPhoto : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
}
@property (nonatomic, retain) id delegate;
@end

//
//  TopicDetailCellViewController.h
//  SaleApp
//
//  Created by LuNian on 16/5/9.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NoteDetailDelegate
- (void)openTextView:(UIViewController*)vc parentName:(NSString*)parentName parentID:(NSString*)parentID commentID:(NSString*)commentID;
- (void)sendTextView:(UIViewController*)vc parentName:(NSString*)parentName parentID:(NSString*)parentID commentID:(NSString*)commentID content:(NSString*)content;
@end

@interface NoteDetailCellViewController : UIViewController
{
    
}

@property (nonatomic, retain) id delegate;
@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (nonatomic) UIView *selfView;
@property (nonatomic) float  listY;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
//@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UILabel *lbXian;
@property (weak, nonatomic) IBOutlet UIImageView *ivZan;
@property (weak, nonatomic) IBOutlet UIButton *btZan;

- (void)createData:(NSArray *)dataArray;
@end

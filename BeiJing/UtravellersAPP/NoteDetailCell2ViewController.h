//
//  TopicDetailCellViewController.h
//  SaleApp
//
//  Created by LuNian on 16/5/9.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteDetailCell2ViewController : UIViewController
{
    
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSString* m_newsID;
@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UILabel *lbXian;
@property (weak, nonatomic) IBOutlet UIButton *btZan;

- (void)createData:(NSArray *)dataArray;
@end

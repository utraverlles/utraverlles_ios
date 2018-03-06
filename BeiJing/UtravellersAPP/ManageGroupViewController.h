//
//  ManageGroupViewController.h
//  UtravellersAPP
//
//  Created by LuNian on 16/9/21.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ManageGroupDelegate
- (void)editGroupSuccess:(NSString*)pr;
@end

@interface ManageGroupViewController : UIViewController
{
    BOOL bFull;
    int iDelect;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@end

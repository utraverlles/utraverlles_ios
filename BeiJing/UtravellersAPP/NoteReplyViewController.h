//
//  TopicDetailViewController.h
//  SaleApp
//
//  Created by LuNian on 16/5/6.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAutoResizingTextView.h"
@interface NoteReplyViewController : UIViewController<ALAutoResizingTextViewDelegate>
{
    CGFloat h;
    CGFloat myScrollViewFrameH;
    CGFloat myScrollViewContentH;
    
    NSString* pageFirstID;
    NSString* pageLastID;
}

@property (nonatomic, retain) NSDictionary* m_dict;
@property (nonatomic, retain) NSString* m_newsID;
@property (nonatomic, retain) NSString* m_commentID;
- (void)openTextView:(UIViewController*)vc;
@end

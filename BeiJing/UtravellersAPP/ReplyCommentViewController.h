//
//  ReplyCommentViewController.h
//  UtravellersAPP
//
//  Created by LuNian on 16/9/20.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AutoLayoutTextViews/ALAutoResizingTextView.h>

@protocol ReplyCommentViewDelegate
- (void)submitSuccess:(NSString*)content;
@end
@interface ReplyCommentViewController : UIViewController<ALAutoResizingTextViewDelegate>
{
    
}

@property (nonatomic) id delegate;
@end

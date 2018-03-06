//
//  FootBall3_1.h
//  FootBall3
//

#import <UIKit/UIKit.h>
//#import "HPGrowingTextView.h"
#import "ALAutoResizingTextView.h"

@interface FootBall4_8 : UIViewController<ALAutoResizingTextViewDelegate>
{
    CGFloat h;
    CGFloat myScrollViewH;
    NSString* m_patienIcon;
    NSString* pageFirstID;
    NSString* pageLastID;
    BOOL bMore;
    BOOL bLoad;
    float fHeight;
}

@property (nonatomic, retain) NSString* m_otherUserID;
@property (nonatomic, retain) NSString* m_titleName;
@property (nonatomic) NSDictionary* m_historyD;
@end

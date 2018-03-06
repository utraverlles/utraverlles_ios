//
//  MsgView1.h
//
#import <UIKit/UIKit.h>
@protocol MsgView8Delegate
- (void)chatCallBack;
- (void)groupCallBack;
- (void)unfollowCallBack;
@end

@interface MsgView8 : UIViewController
{
    
}

@property (nonatomic, retain) id delegate;
@end

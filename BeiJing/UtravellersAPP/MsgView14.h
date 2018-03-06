//
//  MsgView1.h
#import <UIKit/UIKit.h>

@protocol MsgView14Delegate
- (void)groupCallBack;
- (void)unfollowCallBack;
@end

@interface MsgView14 : UIViewController
{
    
}

@property (nonatomic) id delegate;
@property (nonatomic, retain) NSString* m_titleName;
@end

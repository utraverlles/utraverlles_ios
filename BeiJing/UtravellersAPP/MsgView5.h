//
//  MsgView1.h
//
#import <UIKit/UIKit.h>
@protocol MsgView5Delegate
- (void)buddyCallBack;
- (void)blackCallBack;
@end

@interface MsgView5 : UIViewController
{
    
}

@property (nonatomic, retain) id delegate;
@end

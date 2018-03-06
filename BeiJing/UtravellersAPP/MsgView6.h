//
//  MsgView1.h
//
#import <UIKit/UIKit.h>
@protocol MsgView6Delegate
- (void)okCallBack;
@end

@interface MsgView6 : UIViewController
{
    
}

@property (nonatomic, retain) id delegate;
@end

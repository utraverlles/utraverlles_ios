//
//  MsgView1.h
//
#import <UIKit/UIKit.h>
@protocol MsgView3Delegate
- (void)delectCallBack;
- (void)cancelCallBack;
@end

@interface MsgView3 : UIViewController
{
    
}

@property (nonatomic, retain) id delegate;
@end

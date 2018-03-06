//
//  MsgView1.h
#import <UIKit/UIKit.h>

@protocol MsgView12Delegate
- (void)editGroupCallBack;
@end

@interface MsgView12 : UIViewController
{
    
}

@property (nonatomic) id delegate;
@end

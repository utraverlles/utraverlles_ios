//
//  MsgView1.h
//
#import <UIKit/UIKit.h>
@protocol SelectStatesDelegate
- (void)okCallBack:(NSInteger) row;
@end

@interface SelectStates : UIViewController
{
    
}

@property (nonatomic, retain) id delegate;
@end

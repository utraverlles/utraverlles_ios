//
//  MsgView1.h
#import <UIKit/UIKit.h>

@protocol MsgView11Delegate
- (void)okSuccess;
@end

@interface MsgView11 : UIViewController
{
    
}

@property (nonatomic) id delegate;
@property (nonatomic, retain) NSString* m_titleName;
@end

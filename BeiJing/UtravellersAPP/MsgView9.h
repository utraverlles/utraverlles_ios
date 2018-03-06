//
//  MsgView1.h
#import <UIKit/UIKit.h>

@protocol MsgView9Delegate
- (void)addSuccess;
@end

@interface MsgView9 : UIViewController
{
    
}

@property (nonatomic) id delegate;
@property (nonatomic, retain) NSString* m_titleName;
@end

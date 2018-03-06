//
//  MsgView1.h
#import <UIKit/UIKit.h>

@protocol MsgView10Delegate
- (void)addSuccess;
@end

@interface MsgView10 : UIViewController
{
    
}

@property (nonatomic) id delegate;
@property (nonatomic, retain) NSString* m_titleName;
@end

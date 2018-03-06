//
//  MsgView1.h
#import <UIKit/UIKit.h>

@protocol MsgView13Delegate
- (void)editGroup:(NSString*)pr;
@end

@interface MsgView13 : UIViewController
{
    
}

@property (nonatomic) id delegate;
@property (nonatomic, retain) NSString* m_titleName;
@end

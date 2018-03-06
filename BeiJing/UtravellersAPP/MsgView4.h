//
//  MsgView1.h
#import <UIKit/UIKit.h>

@protocol MsgView4Delegate
- (void)addGroup:(NSString*)pr;
@end

@interface MsgView4 : UIViewController
{
    
}

@property (nonatomic) id delegate;

@end

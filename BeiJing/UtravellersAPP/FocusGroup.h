//
//  MsgView1.h
#import <UIKit/UIKit.h>

@protocol FocusGroupDelegate
- (void)selectGroup:(NSString*)pr;
@end

@interface FocusGroup : UIViewController
{
    
}

@property (nonatomic) id delegate;

@end

//
//  MsgView1.h
#import <UIKit/UIKit.h>

@protocol EidtNameDelegate
- (void)eidtSuccess:(NSString*)pr;
@end

@interface EidtName : UIViewController
{
    
}

@property (nonatomic) id delegate;

@end

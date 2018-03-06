//
//  MsgView1.h
//
#import <UIKit/UIKit.h>
@protocol SelectSexDelegate
- (void)sexCallBack:(NSString*)str;
@end

@interface SelectSex : UIViewController
{
    
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSString* m_titleName;
@end

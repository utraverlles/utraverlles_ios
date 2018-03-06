//
//  MsgView1.h
//
#import <UIKit/UIKit.h>
@protocol SelectDateDelegate
- (void)dateCallBack:(NSDate*)date;
@end

@interface SelectDate : UIViewController
{
    
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSString* m_titleName;
@property (weak, nonatomic) IBOutlet UIButton *btMale;
@property (weak, nonatomic) IBOutlet UIButton *btFamale;
@end

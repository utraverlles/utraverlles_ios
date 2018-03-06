//

//

#import <UIKit/UIKit.h>
#import <AutoLayoutTextViews/ALAutoResizingTextView.h>

@protocol EditCommunityDelegate
- (void)submitSuccess;
@end

@interface EditCommunity : UIViewController<UITextViewDelegate>
{
    bool bHelp;
}

@property (nonatomic) id delegate;
@end

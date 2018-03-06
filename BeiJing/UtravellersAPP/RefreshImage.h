//
//  LogoImage.h
//  FootBall3_B
//
//  Created by 王登鹏 on 15/12/9.
//  Copyright © 2015年 王登鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshImage : UIImageView
{
    float  angle;
    BOOL bStart;
}

- (void)startAnimation;
- (void)stopAnimation;
@end

//
//  LogoImage.m
//  FootBall3_B
//
//  Created by 王登鹏 on 15/12/9.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import "RefreshImage.h"
@implementation RefreshImage
- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
    
	}
	return self;
}

- (void)startAnimation
{
    if (bStart) {
        return;
    }
    bStart = YES;
    [self runAnimation];
}

- (void)runAnimation
{
    if (!bStart) {
        return;
    }
    
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI /180.0f));
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.transform = endAngle;
        
    } completion:^(BOOL finished) {
        
        angle += 15;
        
        [self runAnimation];
        
    }];
}

- (void)stopAnimation
{
    bStart = NO;
}
@end

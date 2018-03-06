//
//  MyVisualView.m
//  ParkingApp
//
//  Created by LuNian on 16/5/18.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "MyVisualView.h"

@implementation MyVisualView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
       
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.effect = blur;
    }
    return self;
}

@end

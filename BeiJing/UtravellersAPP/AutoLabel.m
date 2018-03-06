//
//  UnderLineLabel.m
//  ReaderApp
//
//  Created by LuNian on 16/7/19.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "AutoLabel.h"

@implementation AutoLabel
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        if ([[UIScreen mainScreen] currentMode].size.height < 1334
            || [[UIScreen mainScreen] currentMode].size.width/[[UIScreen mainScreen] currentMode].size.height>0.7) {
            self.font = [UIFont systemFontOfSize:12];
        }else{
            self.font = [UIFont systemFontOfSize:14];
        }
    }
    return self;
}


@end

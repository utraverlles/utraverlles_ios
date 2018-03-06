//
//  RotationLabel.m
//  ReaderApp
//
//  Created by LuNian on 16/7/19.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "RotationLabel.h"

@implementation RotationLabel
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
       self.transform = CGAffineTransformMakeRotation(-0.8);
    }
    return self;
}

@end

//
//  HyperlinksButton.m
//  SaleApp
//
//  Created by LuNian on 16/5/13.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "RadiusButton.h"

@implementation RadiusButton

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.bounds.size.height/2;
    }
    return self;
}


@end
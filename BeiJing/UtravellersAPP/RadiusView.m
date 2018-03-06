//
//  MyViewWhite.m
//  DoctorApp
//
//  Created by 王登鹏 on 15/11/27.
//  Copyright © 2015年 LuNian. All rights reserved.
//
#import "RadiusView.h"
@implementation RadiusView
- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.bounds.size.height/2;
//		self.layer.borderWidth = 1.0;
//		self.layer.borderColor = [[UIColor colorWithRed:239.0 / 255 green:239.0 / 255 blue:239.0 / 255 alpha:1.0] CGColor];
	}
	return self;
}

/*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   - (void)drawRect:(CGRect)rect {
    // Drawing code
   }
 */
@end

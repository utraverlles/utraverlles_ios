//
//  MyButton.m
//  DoctorApp
//
//  Created by 王登鹏 on 15/11/26.
//  Copyright © 2015年 LuNian. All rights reserved.
//
#import "MyButtonRadius5.h"
@implementation MyButtonRadius5
/*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   - (void)drawRect:(CGRect)rect {
    // Drawing code
   }
 */
- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		self.layer.borderWidth = 1.0;
		self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = self.titleLabel.textColor.CGColor;
	}
	return self;
}

@end

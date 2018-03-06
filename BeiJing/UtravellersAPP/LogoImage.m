//
//  LogoImage.m
//  FootBall3_B
//
//
#import "LogoImage.h"
@implementation LogoImage
- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		CGFloat w = self.bounds.size.width;
		self.layer.cornerRadius = w / 2;
		self.layer.masksToBounds = YES;
	}
	return self;
}

@end

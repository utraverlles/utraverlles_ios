//
//  MyViewWhite.m
//  DoctorApp
//
//
#import "MyViewGray19.h"
@implementation MyViewGray19
- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 19.0;
		self.layer.borderWidth = 1.0;
		self.layer.borderColor = [[UIColor colorWithRed:239.0 / 255 green:239.0 / 255 blue:239.0 / 255 alpha:1.0] CGColor];
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

//
//  UnderLineLabel.m
//  ReaderApp
//
//  Created by LuNian on 16/7/19.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "CenterLineLabel.h"

@implementation CenterLineLabel
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
    
    }
    return self;
}


- (void)setIsShowLine:(BOOL)isShowLine {
    _isShowLine = isShowLine;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (_isShowLine) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGSize fontSize =[self.text sizeWithFont:self.font
                                        forWidth:self.frame.size.width
                                   lineBreakMode:NSLineBreakByTruncatingTail];
        
        CGContextSetStrokeColorWithColor(ctx, self.textColor.CGColor);  // set as the text's color
        CGContextSetLineWidth(ctx, 1.0f);
        
        CGPoint leftPoint = CGPointMake(0,
                                        self.frame.size.height/2);
        CGPoint rightPoint = CGPointMake(self.frame.size.width,
                                         self.frame.size.height/2);
        CGContextMoveToPoint(ctx, leftPoint.x, leftPoint.y);
        CGContextAddLineToPoint(ctx, rightPoint.x, rightPoint.y);
        CGContextStrokePath(ctx);
    }

}

@end

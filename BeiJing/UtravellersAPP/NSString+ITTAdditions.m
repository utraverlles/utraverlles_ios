//
//  NSString+ITTAdditions.m
//  SaleApp
//
//  Created by LuNian on 16/5/19.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "NSString+ITTAdditions.h"

@implementation NSString (ITTAdditions)


-(BOOL)isStartWithString:(NSString*)str
{
    
    if([[self substringWithRange:NSMakeRange(0, [str length])] isEqualToString:str])
    {
        return YES;
    }
    
    return NO;
}

@end

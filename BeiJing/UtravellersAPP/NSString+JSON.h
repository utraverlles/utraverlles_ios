
//
//  NSString+JSON.h
//  WSPhnixPurfier
//
//  Created by Joy on 13-9-4.
//  Copyright (c) 2013年 Joy. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface NSString (JSON)

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithObject:(id) object;

@end


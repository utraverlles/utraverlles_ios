//
//  ADManager.h
//  ReaderApp
//
//  Created by LuNian on 16/8/8.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADManager : NSObject
+(instancetype)shareInstance;
+(void)clearAllUserDefaultsData;
@property (nonatomic,strong) NSMutableDictionary *userDict;
@property (nonatomic,strong) NSMutableDictionary *bookDict;
@property (nonatomic,strong) NSString *sexStr;
@property (nonatomic,strong) UIViewController *tagController;
@end

//
//  ADManager.m
//  ReaderApp
//
//  Created by LuNian on 16/8/8.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ADManager.h"

@implementation ADManager
+(instancetype)shareInstance
{
    static ADManager *appManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appManager = [[self alloc] init];
        
    });
    
    return appManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"User_Dict"];
        _sexStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"User_Sex"];
        _bookDict = nil;
        _tagController = nil;
        
        NSLog(@"User_Dict == %@", _userDict);
    }
    return self;
}

- (void)setUserDict:(NSMutableDictionary*)userDict
{
    _userDict = userDict;
    
    if (_userDict) {
        [[NSUserDefaults standardUserDefaults] setValue:_userDict forKey:@"User_Dict"];
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"User_Dict"];
    }
}

- (void)setSexStr:(NSString*)sexStr
{
    _sexStr = sexStr;
    
    if (_sexStr) {
        [[NSUserDefaults standardUserDefaults] setValue:_sexStr forKey:@"User_Sex"];
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"User_Sex"];
    }
}

/**
 *  清除所有的存储本地的数据
 */
+ (void)clearAllUserDefaultsData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
//    NSDictionary *dic = [userDefaults dictionaryRepresentation];
//    for (id  key in dic) {
//        [userDefaults removeObjectForKey:key];
//    }
//    [userDefaults synchronize];
    
    [userDefaults removeObjectForKey:@"BookShelf_Arr"];
    
}

/**
 *  清除所有的存储本地的数据
 */
//+ (void)clearAllUserDefaultsData
//{
//    
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//    
//}
@end

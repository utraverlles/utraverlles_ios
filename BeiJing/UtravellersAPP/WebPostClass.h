//
//  WebPostClass.h
//  FootBall3
//
//  Created by 王登鹏 on 15/11/12.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MBProgressHUD.h"
//#import "XMLDictionary.h"

@protocol WebPostClassDelegate
- (void)getData:(NSDictionary *)dict postID:(NSInteger)postID error:(NSError *)error;
- (void)getImageKey:(NSString *)key postID:(NSInteger)postID;
- (void)getFilePath:(NSString *)filePath postID:(NSInteger)postID;
@end
@interface WebPostClass : NSObject
{
}
@property (nonatomic) BOOL showLoadingBool;
@property (nonatomic) id delegate;
@property (nonatomic) NSInteger postID;
@property (nonatomic) UIViewController *superViewCon;
- (instancetype)init;
- (void)updateImage:(NSArray *)imageArray;
- (void)updateImageAliyun:(NSString *)appAction image:(UIImage *)image filePath:(NSString *)filePath parameters:(NSDictionary *)parameters;
- (void)getHttpData:(NSString *)appAction parameters:(NSDictionary *)parameters;
- (void)startMultiPartUploadTaskWithURL:(NSString *)appAction
                            imagesArray:(NSArray *)images
                      parameterOfimages:(NSString *)parameter
                         parametersDict:(NSDictionary *)parameters
                       compressionRatio:(float)ratio;
- (void)onlyPostHttpXML:(NSString *)xmlString;
- (void)getBaiDuHttp:(NSString *)appAction parameters:(NSDictionary *)parameters;
- (void)getGpsHttp:(NSString *)appAction parameters:(NSDictionary *)parameters;
@end

#define HTTP_URL @"http://api.v1.reader.novel.id/"
//#define HTTP_URL @"http://book.msgames.cn/"
#define HTTP_IMG @"http://139.129.44.74/myphpcms"
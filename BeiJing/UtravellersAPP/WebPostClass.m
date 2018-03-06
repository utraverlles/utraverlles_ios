//
//  WebPostClass.m
//  FootBall3
//
//  Created by 王登鹏 on 15/11/12.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import "WebPostClass.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <MD5Digest/NSString+MD5.h>
//#import <AliyunOSSiOS/OSSService.h>
//#import <AliyunOSSiOS/OSSCompat.h>
//#import "XMLDictionary.h"
//#import <QiniuSDK.h>

#define LoadingTAG 789547
@implementation WebPostClass
- (instancetype)init {
	self = [super init];
	if (self) {
	}
	return self;
}


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//把NSDictionary解析成post格式的NSString字符串
- (NSString *)parseParams:(NSDictionary *)params
{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
        //        NSLog(@"post()方法参数解析结果：%@",result);
    }
    result = [result substringToIndex:result.length - 1];
    
    return result;
}


- (void)getHttpData:(NSString *)appAction parameters:(NSDictionary *)parameters {
	if (_showLoadingBool) {
		
        if(!_superViewCon)
        {
            _superViewCon = (UIViewController *)_delegate;
        }
		UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Loading" bundle:nil];
		UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"Loading"];
		v.view.tag = LoadingTAG;
		[_superViewCon.view addSubview:v.view];
	}
	NSLog(@"parameters = %@", [parameters description]);
	NSString *URLstring = [NSString stringWithFormat:@"%@%@", HTTP_URL, appAction];
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	[manager.requestSerializer setTimeoutInterval:15];
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
	[manager POST:URLstring parameters:parameters success: ^(AFHTTPRequestOperation *task, id responseObject) {
	    NSDictionary *dict = (NSDictionary *)responseObject;
	    NSLog(@"\nURL = %@ \n dict = %@", URLstring, [dict description]);
	    [_delegate getData:dict postID:_postID error:nil];
        
	    UIView *v = [_superViewCon.view viewWithTag:LoadingTAG];
	    [v removeFromSuperview];
        
//        if ([[dict objectForKey:@"code"] intValue] != 0) {
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:((UIViewController *)_delegate).navigationController.view animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.labelText = [dict objectForKey:@"info"];
//            hud.labelFont = [UIFont systemFontOfSize:13];
//            hud.margin = 10.f;
//            hud.removeFromSuperViewOnHide = YES;
//            [hud hide:YES afterDelay:1];
//        }

        
//        if ([[dict objectForKey:@"code"] intValue] == -2) {
//            // [dict objectForKey:@"info"]
//            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MsgView13" bundle:nil];
//            UIViewController *msgView = [secondStoryBoard instantiateViewControllerWithIdentifier:@"MsgView13"];
//            [_superViewCon addChildViewController:msgView];
//            [_superViewCon.view addSubview:msgView.view];
//        }
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    NSLog(@"\nURL = %@  \nHTTP Error: %@", URLstring,  error);
	    [_delegate getData:nil postID:_postID error:error];
        
	    UIView *v = [_superViewCon.view viewWithTag:LoadingTAG];
	    [v removeFromSuperview];
	}];
}

- (void)startUp:(UIImage *)image token:(NSString *)token {
//	QNUploadManager *upManager = [[QNUploadManager alloc] init];
//	NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
//	[upManager putData:imageData key:nil token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//	    NSLog(@"%@", resp);
//	    [_delegate getImageKey:[resp objectForKey:@"key"] postID:_postID];
//	} option:nil];
}

- (void)updateImageAliyun:(NSString *)appAction image:(UIImage *)image filePath:(NSString *)filePath parameters:(NSDictionary *)parameters
{
    /*
    if (_showLoadingBool) {
        UIViewController *view = (UIViewController *)_delegate;
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Loading" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"Loading"];
        v.view.tag = LoadingTAG;
        [view.view addSubview:v.view];
    }
    
    NSString * const endPoint = @"http://oss-cn-qingdao.aliyuncs.com";
    
//    NSString* OSSAccessKeyId = [parameters objectForKey:@"OSSAccessKeyId"];
//    NSString* Signature = [parameters objectForKey:@"Signature"];
//    NSString* aliOssSecret = [parameters objectForKey:@"aliOssSecret"];
//    NSString* filePath = [parameters objectForKey:@"filePath"];
    
    id<OSSCredentialProvider> credential = [[OSSCustomSignerCredentialProvider alloc] initWithImplementedSigner:^NSString *(NSString *contentToSign, NSError *__autoreleasing *error) {
        // 您需要在这里依照OSS规定的签名算法，实现加签一串字符内容，并把得到的签名传拼接上AccessKeyId后返回
        // 一般实现是，将字符内容post到您的业务服务器，然后返回签名
        // 如果因为某种原因加签失败，描述error信息后，返回nil
        
        NSString *URLstring = [NSString stringWithFormat:@"%@%@", HTTP_URL, appAction];
        NSURL * URL = [NSURL URLWithString:[URLstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableDictionary *parameters_ = [[NSMutableDictionary alloc] init];
       [parameters_ setObject:contentToSign forKey:@"filePath"];
        
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
        [request setHTTPMethod:@"post"]; //指定请求方式
        [request setURL:URL]; //设置请求的地址
        [request setHTTPBody:[[self parseParams:parameters_] dataUsingEncoding:NSUTF8StringEncoding]];  //设置请求的参数
        
        NSURLResponse * response;
        NSError * error2;
        NSData * backData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error2];
        
        NSDictionary* d = nil;
        if (error2) {
            NSLog(@"error : %@",[error2 localizedDescription]);
        }else{
            NSLog(@"response : %@",response);
            NSLog(@"backData : %@",[[NSString alloc]initWithData:backData encoding:NSUTF8StringEncoding]);
            
            NSDictionary* dict = [self dictionaryWithJsonString:[[NSString alloc]initWithData:backData encoding:NSUTF8StringEncoding]];
            d = [dict objectForKey:@"data"];
        }
        NSString* OSSAccessKeyId = [d objectForKey:@"OSSAccessKeyId"];
        NSString* Signature = [d objectForKey:@"Signature"];
        
        return [NSString stringWithFormat:@"OSS %@:%@", OSSAccessKeyId, Signature];
    }];
    
    OSSClient* client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    
//    OSSClientConfiguration * conf = [OSSClientConfiguration new];
//    conf.maxRetryCount = 2;
//    conf.timeoutIntervalForRequest = 30;
//    conf.timeoutIntervalForResource = 24 * 60 * 60;
//    OSSClient* client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];
    
    OSSPutObjectRequest *request = [OSSPutObjectRequest new];
    request.bucketName = @"paipaitest";
    request.objectKey = filePath; //上传路径
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    request.uploadingData = imageData;
    request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask *task = [client putObject:request];
    [task continueWithBlock: ^id (OSSTask *task) {
        
        if (task.error) {
            NSLog(@"%@", task.error);
        }
        else {
            OSSPutObjectResult *result = task.result;
            NSLog(@"Result Success- requestId: %@, headerFields: %@, servercallback: %@",
                  result.requestId,
                  result.httpResponseHeaderFields,
                  result.serverReturnJsonString);
            
            [_delegate getFilePath:filePath postID:_postID];
        }
        
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:nil waitUntilDone:NO];
        return nil;
    }];
    
    */
}


- (void)updateUI:(id)sender {
    UIView *v = [((UIViewController *)_delegate).view viewWithTag:LoadingTAG];
    [v removeFromSuperview];
}

- (void)updateImage:(NSArray *)imageArray {
	//http://test5.changxinhudong.com/qiniu/uptoken.php
	for (UIImage *image in imageArray) {
		NSString *URLstring = @"http://139.129.44.74/paipai_web/app/public/login/getOssSign";
		AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
		manager.requestSerializer = [AFJSONRequestSerializer serializer];
		[manager.requestSerializer setTimeoutInterval:15];
		manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
		[manager POST:URLstring parameters:nil success: ^(AFHTTPRequestOperation *task, id responseObject) {
		    NSDictionary *dict = (NSDictionary *)responseObject;
		    NSLog(@"\nURL = %@ \n dict = %@", URLstring, [dict description]);
		    NSString *token = [dict objectForKey:@"uptoken"];
		    [self startUp:image token:token];
		} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
		    NSLog(@"\nURL = %@  \nHTTP Error: %@", URLstring,  error);
		    [_delegate getData:nil postID:_postID error:error];
		}];
	}
}

- (NSDictionary *)formatParameters:(NSDictionary *)parameters_ {
	NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:parameters_];
	[parameters setObject:@"ios" forKey:@"appType"];
	NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
	long long int date = (long long int)time;
	NSString *timeString = [NSString stringWithFormat:@"%lld", date];
	NSString *timeMD5 = [timeString MD5Digest];
	NSArray *keys = [parameters allKeys];
	NSArray *sortedArray = [keys sortedArrayUsingComparator: ^NSComparisonResult (id obj1, id obj2) {
	    return [obj1 compare:obj2 options:NSNumericSearch];
	}];
	NSString *s = @"";
	for (NSString *categoryId in sortedArray) {
		NSString *ss = [NSString stringWithFormat:@"%@=%@&", categoryId, [parameters objectForKey:categoryId]];
		s = [s stringByAppendingString:ss];
	}
	s = [s substringWithRange:NSMakeRange(0, s.length - 1)];
	NSString *sign = [timeMD5 stringByAppendingString:s];
	[parameters setObject:timeString forKey:@"time"];
	[parameters setObject:[[sign MD5Digest] substringToIndex:20] forKey:@"cliSign"];
	return parameters;
}

- (void)startMultiPartUploadTaskWithURL:(NSString *)appAction
                            imagesArray:(NSArray *)images
                      parameterOfimages:(NSString *)parameter
                         parametersDict:(NSDictionary *)parameters
                       compressionRatio:(float)ratio {
    
    if (_showLoadingBool) {
        UIViewController *view = (UIViewController *)_delegate;
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Loading" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"Loading"];
        v.view.tag = LoadingTAG;
        [view.view addSubview:v.view];
    }
	if (images.count == 0) {
		NSLog(@"上传内容没有包含图片");
	}
	for (int i = 0; i < images.count; i++) {
		if (![[images objectAtIndex:i] isKindOfClass:[UIImage class]]) {
			NSLog(@"images中第%d个元素不是UIImage对象", i + 1);
			return;
		}
	}
//	NSDictionary *dict = [self formatParameters:parameters];
    NSDictionary *dict = parameters;
	NSString *URLstring = [NSString stringWithFormat:@"%@%@", HTTP_URL, appAction];
	NSURL *URL = [NSURL URLWithString:URLstring];
	NSLog(@"\nparameters = %@", dict);
	NSString *u = @"?";
	for (NSString *key in[dict allKeys]) {
		u = [u stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, [dict objectForKey:key]]];
	}
	u = [u substringToIndex:u.length - 1];
	NSLog(@"\nURL = %@%@ \n", URLstring, u);
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager.requestSerializer setTimeoutInterval:30];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
	AFHTTPRequestOperation *operation = [manager POST:URL.absoluteString parameters:dict
	                        constructingBodyWithBlock: ^(id < AFMultipartFormData > formData) {
	    int i = 0;
	    for (UIImage *image in images) {
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
            NSString *dateString = [formatter stringFromDate:date];
            NSString *fileName = [NSString stringWithFormat:@"%@_%d.png", dateString, i];
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
	        [formData appendPartWithFileData:imageData name:parameter fileName:fileName mimeType:@"image/jpg/png/jpeg"];
	        i++;
		}
	}
	                                          success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    // 成功后的处理
//	    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
	    NSDictionary *dict = (NSDictionary *)responseObject;
	    NSLog(@"\nURL = %@%@ \n dict  = %@", URLstring, u, [dict description]);
	    [_delegate getData:dict postID:_postID error:nil];
                                                  
        UIView *v = [((UIViewController *)_delegate).view viewWithTag:LoadingTAG];
        [v removeFromSuperview];
	}
	                                          failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    // 失败后的处理
	    NSLog(@"HTTP Error: %@", error);
	    [_delegate getData:dict postID:_postID error:error];
                                                  
        UIView *v = [((UIViewController *)_delegate).view viewWithTag:LoadingTAG];
        [v removeFromSuperview];
	}];
	[operation setUploadProgressBlock: ^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
	    CGFloat percent = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
	    NSLog(@"上传进度 - >%f", percent);
	}];
}


- (void)onlyPostHttpXML:(NSString *)xmlString {

    
//    NSURL *URL = [NSURL URLWithString:@"https://api.mch.weixin.qq.com/pay/unifiedorder"];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
//    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
//    NSOperation *operation = [manager HTTPRequestOperationWithRequest:request success: ^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSXMLParser *parser = responseObject;
//        NSDictionary *d = [NSDictionary dictionaryWithXMLParser:parser];
////        NSLog(@"success d= %@", [d description]);
//        if (![parser parse]) {
//            // handle parsing error here
//            NSLog(@"error= %@", parser);
//        }
//        else {
//            // use parsed data here
//            NSLog(@"%@", parser);
//        }
//    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
//        // handle network related errors here
//        NSData *data = [[error userInfo] objectForKey:@"com.alamofire.serialization.response.error.data"];
//        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSDictionary *d = [NSDictionary dictionaryWithXMLString:result];
//        NSLog(@"error= %@", [d description]);
//        [_delegate getData:d postID:_postID error:error];
//    }];
//    [manager.operationQueue addOperation:operation];
    
}


- (void)getBaiDuHttp:(NSString *)appAction parameters:(NSDictionary *)parameters {
    if (_showLoadingBool) {
        UIViewController *view = (UIViewController *)_delegate;
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Loading" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"Loading"];
        v.view.tag = LoadingTAG;
        [view.view addSubview:v.view];
    }
    NSLog(@"parameters = %@", [parameters description]);
    NSString *u = @"?";
    for (NSString *key in[parameters allKeys]) {
        u = [u stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, [parameters objectForKey:key]]];
    }
    u = [u substringToIndex:u.length - 1];
    NSString *URLstring = [NSString stringWithFormat:@"%@%@", appAction, u];
    NSURL *URL = [NSURL URLWithString:URLstring];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:15];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/javascript"];
    [manager GET:URL.absoluteString parameters:nil success: ^(AFHTTPRequestOperation *task, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSLog(@"\nURL = %@ \n dict = %@", URLstring, [dict description]);
        [_delegate getData:dict postID:_postID error:nil];
        UIView *v = [((UIViewController *)_delegate).view viewWithTag:LoadingTAG];
        [v removeFromSuperview];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"\nURL = %@  \nHTTP Error: %@", URLstring,  error);
        [_delegate getData:nil postID:_postID error:error];
        UIView *v = [((UIViewController *)_delegate).view viewWithTag:LoadingTAG];
        [v removeFromSuperview];
    }];
}


- (void)getGpsHttp:(NSString *)appAction parameters:(NSDictionary *)parameters {
    if (_showLoadingBool) {
        UIViewController *view = (UIViewController *)_delegate;
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Loading" bundle:nil];
        UIViewController *v = [secondStoryBoard instantiateViewControllerWithIdentifier:@"Loading"];
        v.view.tag = LoadingTAG;
        [view.view addSubview:v.view];
    }
    NSLog(@"parameters = %@", [parameters description]);
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    
    NSString *URLstring = appAction;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:15];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager POST:URLstring parameters:parameters success: ^(AFHTTPRequestOperation *task, id responseObject) {
//        
//        NSDictionary *dict = (NSDictionary *)responseObject;
//        NSLog(@"\nURL = %@ \n dict = %@", URLstring, [dict description]);
//        [_delegate getData:dict postID:_postID error:nil];
//        UIView *v = [((UIViewController *)_delegate).view viewWithTag:LoadingTAG];
//        [v removeFromSuperview];
//    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"\nURL = %@  \nHTTP Error: %@", URLstring,  error);
//        [_delegate getData:nil postID:_postID error:error];
//        UIView *v = [((UIViewController *)_delegate).view viewWithTag:LoadingTAG];
//        [v removeFromSuperview];
//    }];
    
    [manager POST:URLstring parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
@end

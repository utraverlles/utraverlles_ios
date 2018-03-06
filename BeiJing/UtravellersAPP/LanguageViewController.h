//
//  LanguageViewController.h
//  UtravellersAPP
//
//  Created by LuNian on 16/9/29.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LanguageDelegate
- (void)languageCallBack:(NSString*)str;
@end
@interface LanguageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>
{
    NSMutableArray *_searchResultArr;//搜索结果Arr
}

@property (nonatomic, retain) id delegate;
@end

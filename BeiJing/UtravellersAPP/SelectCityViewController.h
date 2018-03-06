//
//  SelectCityViewController.h
//  UtravellersAPP
//
//  Created by LuNian on 16/9/23.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectCityDelegate
- (void)cityCallBack:(NSString*)str;
@end

@interface SelectCityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>
{
    
    NSArray *_rowArr;//row arr
    NSArray *_sectionArr;//section arr
    NSMutableArray *_searchResultArr;//搜索结果Arr
    NSMutableIndexSet *_booksIndexsToBeRemoved;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSString* m_titleName;
@end

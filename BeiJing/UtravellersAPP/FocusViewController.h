//
//  FocusViewController.h
//  UtravellersAPP
//
//  Created by LuNian on 16/10/9.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>
{
    NSArray *_rowArr;//row arr
    NSArray *_sectionArr;//section arr
    NSMutableArray *_searchResultArr;//搜索结果Arr
    NSMutableIndexSet *_booksIndexsToBeRemoved;
}

@end

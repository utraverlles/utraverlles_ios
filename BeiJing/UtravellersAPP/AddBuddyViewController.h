//
//  AddBuddyViewController.h
//  UtravellersAPP
//
//  Created by LuNian on 16/9/22.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddBuddyDelegate
- (void)addBuddyCallBack:(NSArray*)arr;
@end

@interface AddBuddyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>
{
    NSArray *_rowArr;//row arr
    NSArray *_sectionArr;//section arr
    NSMutableArray *_searchResultArr;//搜索结果Arr
    NSMutableIndexSet *_booksIndexsToBeRemoved;
    BOOL _bSearch;
}

@property (nonatomic, retain) id delegate;
@end

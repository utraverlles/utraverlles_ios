//
//  SelectLocalView.h
//  TourismApp
//
//  Created by 王登鹏 on 16/1/6.
//  Copyright © 2016年 王登鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectLocalViewDelegate
- (void)selectArea:(NSString *)areaStr;
@end

@interface SelectLocalView : UIViewController
{
    
}

@property (nonatomic, retain) NSString* province;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) id delegate;
@end

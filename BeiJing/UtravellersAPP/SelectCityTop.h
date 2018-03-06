//
//  SelectCityTop.h
//  UtravellersAPP
//
//  Created by LuNian on 16/10/13.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CityTopDelegate
- (void)topCallBack:(NSString*)str;
@end

@interface SelectCityTop : UIViewController


@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSString* m_titleName;
@end

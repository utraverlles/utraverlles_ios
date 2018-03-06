//
//  DetailImageViewController.h
//  SaleApp
//
//  Created by LuNian on 16/5/25.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailImageViewController : UIViewController
{
    
}

@property (nonatomic) UIViewController *superViewCon;
@property (nonatomic, retain) NSDictionary* m_dict;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@end

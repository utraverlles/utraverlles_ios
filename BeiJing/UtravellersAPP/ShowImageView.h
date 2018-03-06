//
//  ShowImageView.h
//  DoctorApp
//
//  Created by LuNian on 16/2/16.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowImageView : UIViewController{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *iv_BigImage;
@property (nonatomic, retain) UIImage* img;
@end

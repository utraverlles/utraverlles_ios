//
//  IdentifierValidator.h
//  SaleApp
//
//  Created by LuNian on 16/5/19.
//  Copyright © 2016年 LuNian. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    IdentifierTypeKnown = 0,
    IdentifierTypeZipCode,      //1
    IdentifierTypeEmail,        //2
    IdentifierTypePhone,        //3
    IdentifierTypeUnicomPhone,  //4
    IdentifierTypeQQ,           //5
    IdentifierTypeNumber,       //6
    IdentifierTypeString,       //7
    IdentifierTypeIdentifier,   //8
    IdentifierTypePassort,      //9
    IdentifierTypeCreditNumber, //10
    IdentifierTypeBirthday,     //11
}IdentifierType;


@interface IdentifierValidator : NSObject
{
    
}

+ (BOOL) isValid:(IdentifierType) type value:(NSString*) value;
+ (NSString *)firstCharactor:(NSString *)aString;
+ (void)showCancelAlert:(UIViewController*)viewController msg:(NSString *)msg;

@end

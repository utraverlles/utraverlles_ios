//
//  ReplyCommentViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/9/20.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "ReplyCommentViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface ReplyCommentViewController ()
@property (weak, nonatomic) IBOutlet ALPlaceholderTextView *myTextView;

@end

@implementation ReplyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


/*
- (void)textViewDidChange:(UITextView *)textView {
    NSInteger number = [textView.text length];
    if (number > 0) {
//        [_submitButton setEnabled:YES];
    }
    else {
//        [_submitButton setEnabled:NO];
    }
    if (number > 140) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于140" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:140];
        number = 140;
    }
//    self.fontCountLabel.text = [NSString stringWithFormat:@"%d/140", number];
}
*/

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        if ([_myTextView.text length] == 0) {
            return NO;
        }
        [_delegate submitSuccess:textView.text];
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    
    int count = 0;
    if (textView.text.length > 0) {
        for (int i = 0; i < textView.text.length; i++) {
            unichar c = [textView.text characterAtIndex:i];
            if (c >= 0x4E00 && c <= 0x9FA5) {
                count++;
            }
        }
    }
    int length = [self convertToInt:textView.text];
    
    if (length >= 140) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的内容长度已经超过140个字" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    else {
        return YES;
    }
    return YES;
}

- (int)convertToInt:(NSString *)strtemp {
    int strlength = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength + 1) / 2;
}

@end

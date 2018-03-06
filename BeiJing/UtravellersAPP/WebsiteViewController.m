//
//  WebsiteViewController.m
//  UtravellersAPP
//
//  Created by LuNian on 16/10/11.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "WebsiteViewController.h"

@interface WebsiteViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation WebsiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //从网络加载
//    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_m_url]]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.myWebView.isLoading) {
        [self.myWebView stopLoading];
    }
    self.myWebView.delegate = nil; // disconnect the delegate as the webview is hidden
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


//The web-view delegate managing network loading
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // starting the load, show the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:
                             @"An error occurred:%@", error.localizedDescription];
    [self.myWebView loadHTMLString:errorString baseURL:nil];
}

@end

//
//  WebViewViewController.m
//  ToolBox
//
//  Created by Scott Rocca on 10/21/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *myTopWebView;

@property (nonatomic, strong) UIWebView *myBottomWebView;
@end

@implementation WebViewViewController
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if( self != nil){
        self.title = @"Web View Tab"; 
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect viewRect = self.view.bounds;
    
    viewRect.size.height /= 2;
    
    self.myTopWebView = [[UIWebView alloc] initWithFrame:viewRect];
    NSString *htmlString = @"<br/>iOS Programming <strong>Cookbook</strong>";
    
    [self.myTopWebView loadHTMLString:htmlString baseURL:nil];
    
    [self.view addSubview:self.myTopWebView];
    
    viewRect.origin.y = viewRect.size.height;
    self.myBottomWebView = [[UIWebView alloc] initWithFrame:viewRect];
    self.myBottomWebView.scalesPageToFit = YES;
    [self.view addSubview:self.myBottomWebView];
    
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.myBottomWebView loadRequest:request];
    
    self.myBottomWebView.delegate = self;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebView Delegates
//Called as soon as the web view starts loading content
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

//Called as soon as the web view finishes loading content
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

//Stops loading content because of an error or broken network connection
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


@end

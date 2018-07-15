//
//  vkLoginViewController.m
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 13/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import "vkLoginViewController.h"
#import "ViewController.h"


@implementation vkLoginViewController
@synthesize vkWebView, appID, delegate;

- (void) dealloc {
    [delegate release];
    [appID release];
    vkWebView.delegate = nil;
    [vkWebView release];
    [super dealloc];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!vkWebView){
        self.vkWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        vkWebView.delegate = self;
        vkWebView.scalesPageToFit = YES;
        [self.view addSubview:vkWebView];
    }
    
    NSString *authLink = [NSString stringWithFormat:@"http://api.vk.com/oauth/authorize?client_id=%@&scope=wall,photos,friends&redirect_uri=http://api.vk.com/blank.html&display=touch&response_type=token", @"6632185"];
    NSURL *url = [NSURL URLWithString:authLink];
    
    [vkWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(BOOL)shouldAutorotate:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [vkWebView stopLoading];
    vkWebView.delegate = nil;
}

- (BOOL)webView:(UIWebView *)aWbView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *URL = [request URL];
    // Пользователь нажал Отмена в веб-форме
    if ([[URL absoluteString] isEqualToString:@"http://api.vk.com/blank.html#error=access_denied&error_reason=user_denied&error_description=User%20denied%20your%20request"]) {
        [super dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    NSLog(@"Request: %@", [URL absoluteString]);
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    // Если есть токен сохраняем его
    if ([vkWebView.request.URL.absoluteString rangeOfString:@"access_token"].location != NSNotFound) {
        NSString *accessToken = [self stringBetweenString:@"access_token="
                                                andString:@"&"
                                              innerString:[[[webView request] URL] absoluteString]];
        
        NSArray *userAr = [[[[webView request] URL] absoluteString] componentsSeparatedByString:@"&user_id="];
        NSString *user_id = [userAr lastObject];
        NSLog(@"User id: %@", user_id);
        if(user_id){
            [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"VKAccessUserId"];
        }
        
        if(accessToken){
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"VKAccessToken"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"VKAccessTokenDate"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        NSLog(@"vkWebView response: %@",[[[webView request] URL] absoluteString]);
        [(ViewController *)delegate authComplete];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ([vkWebView.request.URL.absoluteString rangeOfString:@"error"].location != NSNotFound) {
        NSLog(@"Error: %@", vkWebView.request.URL.absoluteString);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"vkWebView Error: %@", [error localizedDescription]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString*)stringBetweenString:(NSString*)start
                       andString:(NSString*)end
                     innerString:(NSString*)str
{
    NSScanner* scanner = [NSScanner scannerWithString:str];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];
    if ([scanner scanString:start intoString:NULL]) {
        NSString* result = nil;
        if ([scanner scanUpToString:end intoString:&result]) {
            return result;
        }
    }
    return nil;
}


@end

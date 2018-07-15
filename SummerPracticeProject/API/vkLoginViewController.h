//
//  vkLoginViewController.h
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 13/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface vkLoginViewController : UIViewController <UIWebViewDelegate> {
    
    id delegate;
    UIWebView *vkWebView;
    NSString *appID;
    
}
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) UIWebView *vkWebView;
@property (nonatomic, retain) NSString *appID;

- (NSString*)stringBetweenString:(NSString*)start
                       andString:(NSString*)end
                     innerString:(NSString*)str;
@end

//
//  ViewController.m
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 13/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import "ViewController.h"
#import "vkLoginViewController.h"
#import "VKAPIManager.h"
#import "MainViewController.h"

@interface ViewController()

@end


@implementation ViewController

@synthesize appID, loginButton;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
    if (accessToken) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        ViewController *mainViewController = (ViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"mainVC"];
        
        [self presentViewController:mainViewController animated:NO completion:nil];
        
    }
}

- (IBAction)loginButtonPressed:(id)sender {
    vkLoginViewController *login = [[vkLoginViewController alloc] init];
    self.appID = @"6632185";
    login.delegate = self;
    [self presentViewController:login animated:YES completion:nil];
    [login release];
    NSLog(@"doAuth");
}


- (void)authComplete {
    NSLog(@"success");
}

@end

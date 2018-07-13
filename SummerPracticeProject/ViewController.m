//
//  ViewController.m
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 13/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import "ViewController.h"
#import "vkLoginViewController.h"


@implementation ViewController
@synthesize appID, loginButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [loginButton release];
    [super dealloc];
}

@end

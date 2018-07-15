//
//  ViewController.h
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 13/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKAPIManager.h"

@interface ViewController : UIViewController{
    BOOL isAuth;
    NSString *appID;
}
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) NSString *appID;
- (void) authComplete;
@end

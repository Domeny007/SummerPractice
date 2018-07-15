//
//  MainViewController.h
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 14/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKAPIManager.h"

@interface MainViewController : UIViewController <VKAPIManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@end

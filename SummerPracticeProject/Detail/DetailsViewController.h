//
//  DetailsViewController.h
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 15/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewItem.h"
@interface DetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NewItem *item;

@end

//
//  AttachTableViewCell.h
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 15/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttachTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIView *backView;
@property (retain, nonatomic) IBOutlet UITextView *titleTextView;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (retain, nonatomic) IBOutlet UIImageView *photoView;



@end

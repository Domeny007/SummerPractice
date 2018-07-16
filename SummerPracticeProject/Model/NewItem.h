//
//  NewItem.h
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 14/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"

@interface NewItem : NSObject

@property (strong, nonatomic) NSURL *ownerImageURL;
@property (strong, nonatomic) NSString *ownerName;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *formatedDate;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) Attachment *attachment;
@property (strong, nonatomic) NSArray *attachments;
@property (strong, nonatomic) NSString *likesCount;

+ (instancetype)objectFromDictionary:(NSDictionary *)dict;

@end

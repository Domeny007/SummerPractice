//
//  Attachment.h
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 14/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface Attachment : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *imageURLString;
@property (assign, nonatomic) CGSize imageOriginSize;
@property (strong, nonatomic) NSString *title;

+ (instancetype)objectFromDictionary:(NSDictionary*)dict;


@end

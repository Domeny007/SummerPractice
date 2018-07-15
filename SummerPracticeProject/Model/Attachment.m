//
//  Attachment.m
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 14/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import "Attachment.h"

@implementation Attachment

+(instancetype)objectFromDictionary:(NSDictionary *)dict {
    Attachment *attach = [[Attachment alloc] init];
    NSString *photoString = @"photo";
    NSString *videoString = @"video";
    attach.type = dict[@"type"];
    if ([attach.type isEqualToString:photoString]) {
        attach.title = dict[photoString][@"text"];
        attach.imageURLString = dict[photoString][@"sizes"][3][@"url"];
        attach.imageOriginSize = CGSizeMake([dict[photoString][@"width"] floatValue], [dict[photoString][@"height"] floatValue]);
    } else if ([attach.type isEqualToString: videoString]) {
        attach.title = dict[videoString][@"title"];
        attach.imageURLString = dict[videoString][@"photo_320"];
        attach.imageOriginSize = CGSizeMake(320, 250);
    } if ([attach.type isEqualToString:@"link"]) {
        attach.title = [NSString stringWithFormat:@"%@\n%@", dict[@"link"][@"title"], dict[@"link"][@"url"]];
    } else if ([attach.type isEqualToString:@"note"]) {
        attach.title = dict[@"note"][@"title"];
    } else if ([attach.type isEqualToString:@"audio"]) {
        attach.title = [NSString stringWithFormat:@"%@ - %@", dict[@"audio"][@"artist"], dict[@"audio"][@"title"]];
    } else if ([attach.type isEqualToString:@"doc"]) {
        attach.title = dict[@"doc"][@"title"];
    } else if ([attach.type isEqualToString:@"page"]) {
        attach.title = dict[@"page"][@"title"];
    }
    if (attach.title) {
        attach.title = [attach.title stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    }
    return attach;
}

@end

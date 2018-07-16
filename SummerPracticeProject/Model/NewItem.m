//
//  NewItem.m
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 14/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import "NewItem.h"
#import "Constants.h"

@implementation NewItem

+ (instancetype)objectFromDictionary:(NSDictionary *)dict {
    NewItem *item = [[NewItem alloc] init];
    
    // content
    item.date = [NSDate dateWithTimeIntervalSince1970:[dict[@"date"] integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = DATETIME_FORMAT;
    item.formatedDate = [formatter stringFromDate:item.date];
    item.text = [dict[@"text"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    item.text = (item.text.length > 8192) ? [item.text substringToIndex:8192] : item.text;
    
    item.likesCount =[NSString stringWithFormat:@"%@", dict[@"likes"][@"count"]];
    
    // attachment
    NSDictionary *attach = dict[@"attachment"];
    if (attach) {
        item.attachment = [Attachment objectFromDictionary:attach];
    }
    // attachments
    NSArray *attaches = dict[@"attachments"];
    NSMutableArray *resArray = [[NSMutableArray alloc] initWithCapacity:attaches.count];
    if (attaches) {
        for (NSDictionary *dict in attaches) {
            [resArray addObject:[Attachment objectFromDictionary:dict]];
        }
        item.attachments = resArray;
    }
    return item;
}

@end


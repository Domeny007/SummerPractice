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

// маппинг сущности NewsItem из NSDictionary
+ (instancetype)objectFromDictionary:(NSDictionary *)dict {
    NewItem *item = [[NewItem alloc] init];
    
    // owner
    NSDictionary *owner = dict[@"group"] ?: dict[@"user"];
    if (![owner isKindOfClass:[NSNull class]]) {
        item.ownerName = owner[@"name"] ? : [NSString stringWithFormat:@"%@ %@", owner[@"last_name"], owner[@"first_name"]];
        item.ownerImageURL = [NSURL URLWithString:owner[@"photo"]];
    }
    // content
    item.date = [NSDate dateWithTimeIntervalSince1970:[dict[@"date"] integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = DATETIME_FORMAT;
    item.formatedDate = [formatter stringFromDate:item.date];
    item.text = [dict[@"text"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    item.text = (item.text.length > 8192) ? [item.text substringToIndex:8192] : item.text;
    
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


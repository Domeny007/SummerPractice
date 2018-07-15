//
//  VKAPIManager.m
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 14/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import "VKAPIManager.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworking/AFNetworking.h"
#import "NewItem.h"

#define SERVER_URL @"https://api.vk.com/method/"
#define METHOD_NEWS_FETCH @"https://api.vk.com/method/newsfeed.get?v=5.80&filters=post&access_token="

@interface VKAPIManager()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) NSString *mainURL;
@end

@implementation VKAPIManager

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURL *URL = [NSURL URLWithString:SERVER_URL];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

+ (VKAPIManager *)managerWithDelegate:(id<VKAPIManagerDelegate>)aDelegate {
    VKAPIManager *manager = [[VKAPIManager alloc] init];
    manager.delegate = aDelegate;
    return manager;
}

-(void) fetchNews {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
    _mainURL = [METHOD_NEWS_FETCH stringByAppendingString:accessToken];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:_mainURL parameters:nil progress:nil success:^(NSURLSessionTask *operation, id responceObject) {
        NSLog(@"JSON : %@", responceObject);
        if ([responceObject[@"response"] isKindOfClass:[NSDictionary class]]) {
            NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:30];
            for (id val in responceObject[@"response"][@"items"]) {
                if ([val isKindOfClass:[NSDictionary class]]) {
                    [result addObject:[NewItem objectFromDictionary:val]];
                }
            }
            [self.delegate manager:self didSucceedSearchWithData:result];
        } else {
            [self.delegate manager:self didSucceedSearchWithData:nil];
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(manager:didFailedSearchWithError:)]) {
            [self.delegate manager:self didFailedSearchWithError:error];
        } else {
        NSLog(@"Error: %@", error);
        }
    }];
}


@end

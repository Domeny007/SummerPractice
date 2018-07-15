//
//  VKAPIManager.h
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 14/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VKAPIManagerDelegate;


@interface VKAPIManager : NSObject

@property (weak, nonatomic) id<VKAPIManagerDelegate> delegate;

+ (VKAPIManager *)managerWithDelegate:(id<VKAPIManagerDelegate>)aDelegate;
- (void)fetchNews;

@end


@protocol VKAPIManagerDelegate <NSObject>

@optional
- (void)manager:(VKAPIManager *)manager didSucceedSearchWithData:(NSArray *)data;
- (void)manager:(VKAPIManager *)manager didFailedSearchWithError:(NSError *)error;

@end

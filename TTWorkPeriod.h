//
//  TTWorkPeriod.h
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTWorkPeriod : NSObject

@property (strong, nonatomic) NSString *periodTitle;
@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *finishTime;
@property (strong, nonatomic) NSString *description;
@property (assign, nonatomic) NSTimeInterval duration;

- (NSDictionary *)workPeriodDictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

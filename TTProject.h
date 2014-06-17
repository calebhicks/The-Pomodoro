//
//  TTProject.h
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkPeriod.h"

@interface TTProject : NSObject

@property (strong, nonatomic) NSString *projectTitle;
@property (strong, nonatomic) NSString *projectDescription;
@property (strong, nonatomic) NSArray *workPeriods;
@property (strong, nonatomic) NSDate *dateCreated;
@property (assign, nonatomic) NSTimeInterval totalDuration;

@property (strong, nonatomic) WorkPeriod *currentWorkPeriod;

- (NSDictionary *)projectDictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

- (void)addRoundAsWorkPeriod:(WorkPeriod *)workPeriod;
- (void)addWorkPeriod;
- (void)startNewWorkPeriod;
- (void)endCurrentWorkPeriod;
- (void)updateDuration;

@end

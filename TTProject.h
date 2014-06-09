//
//  TTProject.h
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTWorkPeriod.h"

@interface TTProject : NSObject

@property (strong, nonatomic) NSString *projectTitle;
@property (strong, nonatomic) NSString *projectDescription;
@property (strong, nonatomic) NSArray *workPeriods;
@property (strong, nonatomic) NSDate *dateCreated;

@property (strong, nonatomic) TTWorkPeriod *currentWorkPeriod;

- (NSDictionary *)projectDictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

- (void)addWorkPeriod:(TTWorkPeriod *)workPeriod toProject:(TTProject *)project;
- (void)startNewWorkPeriod;
- (void)endCurrentWorkPeriod;


@end

//
//  TTProject.m
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTProject.h"
#import "TTProjectController.h"

static NSString * const titleKey = @"title";
static NSString * const descriptionKey = @"description";
static NSString * const periodsKey = @"periods";
static NSString * const createdKey = @"created";

@implementation TTProject

- (NSDictionary *)projectDictionary{
    
    NSMutableDictionary *entryDictionary = [[NSMutableDictionary alloc]init];
    
    if (self.projectTitle) {
        [entryDictionary setValue:self.projectTitle forKeyPath:titleKey];
    }
    
    if (self.projectDescription) {
        [entryDictionary setValue:self.projectDescription forKeyPath:descriptionKey];
    }
    
    if (self.workPeriods){
        
        NSMutableArray *periods = [NSMutableArray new];
        for (TTWorkPeriod *period in self.workPeriods) {
            [periods addObject:[period workPeriodDictionary]];
        }
        [entryDictionary setObject:periods forKey:periodsKey];
    }
    
    if (self.dateCreated){
        [entryDictionary setValue:self.dateCreated forKeyPath:createdKey];
    }
    
    return entryDictionary;
}


- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.projectTitle = dictionary[titleKey];
        self.projectDescription = dictionary[descriptionKey];
        
        NSArray *workPeriodDictionaries = dictionary[periodsKey];
        NSMutableArray *workPeriods = [NSMutableArray new];
        for (NSDictionary *workPeriodDictionary in workPeriodDictionaries) {
            TTWorkPeriod *workPeriod = [[TTWorkPeriod alloc] initWithDictionary:workPeriodDictionary];
            [workPeriods addObject:workPeriod];
            }
        self.workPeriods = workPeriods;
        
        self.dateCreated = dictionary[createdKey];
        }
    return self;
}

- (void)addWorkPeriod{
    NSMutableArray *mutableWorkPeriods = [NSMutableArray arrayWithArray:self.workPeriods];
    [mutableWorkPeriods addObject:self.currentWorkPeriod];
    self.workPeriods = mutableWorkPeriods;
    [[TTProjectController sharedInstance]synchronize];
}

- (void)startNewWorkPeriod{
    TTWorkPeriod *workPeriod = [TTWorkPeriod new];
    workPeriod.startTime = [NSDate date];
    workPeriod.periodTitle = @"work period";
    workPeriod.description = @" ";
    
    self.currentWorkPeriod = workPeriod;
    
    [self addWorkPeriod];
    [[TTProjectController sharedInstance]synchronize];
    
}

- (void)endCurrentWorkPeriod{
    self.currentWorkPeriod.finishTime = [NSDate date];
    [[TTProjectController sharedInstance]synchronize];
}

@end

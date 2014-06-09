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
        self.workPeriods = dictionary[periodsKey];
        self.dateCreated = dictionary[createdKey];
    }
    return self;
}

- (void)addWorkPeriod:(TTWorkPeriod *)workPeriod toProject:(TTProject *)project{
    
    NSMutableArray *mutableWorkPeriods = [NSMutableArray arrayWithArray:project.workPeriods];
    [mutableWorkPeriods addObject:workPeriod];
    project.workPeriods = mutableWorkPeriods;
}

- (void)startNewWorkPeriod{
    TTWorkPeriod *workPeriod = [TTWorkPeriod new];
    workPeriod.startTime = [NSDate date];
    workPeriod.periodTitle = @"work period";
    workPeriod.description = @" ";
    
    self.currentWorkPeriod = workPeriod;
    
    [self addWorkPeriod:self.currentWorkPeriod toProject:self];
    [[TTProjectController sharedInstance]synchronize];
    
}

- (void)endCurrentWorkPeriod{
    self.currentWorkPeriod.finishTime = [NSDate date];
    [[TTProjectController sharedInstance]synchronize];
}

@end

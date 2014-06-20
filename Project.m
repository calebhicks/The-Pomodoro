//
//  Project.m
//  Wired In
//
//  Created by Caleb Hicks on 6/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "Project.h"
#import "WorkPeriod.h"
#import "ProjectController.h"
#import "POAppDelegate.h"
#import "CoreDataHelper.h"

static NSString * const titleKey = @"title";
static NSString * const descriptionKey = @"description";
static NSString * const periodsKey = @"periods";
static NSString * const createdKey = @"created";

@implementation Project

@dynamic dateCreated;
@dynamic projectDescription;
@dynamic projectTitle;
@dynamic totalDuration;
@dynamic workPeriods;

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
        for (WorkPeriod *period in self.workPeriods) {
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
        NSMutableOrderedSet *workPeriods = [NSMutableOrderedSet new];
        for (NSDictionary *workPeriodDictionary in workPeriodDictionaries) {
            WorkPeriod *workPeriod = [[WorkPeriod alloc] initWithDictionary:workPeriodDictionary];
            [workPeriods addObject:workPeriod];
        }
        self.workPeriods = workPeriods;
        
        self.dateCreated = dictionary[createdKey];
    }
    return self;
}

- (void)addWorkPeriod:(WorkPeriod *)workPeriod{

    [self addWorkPeriodsObject:workPeriod];
    
//    NSMutableOrderedSet *mutableWorkPeriods = [NSMutableOrderedSet orderedSetWithOrderedSet:self.workPeriods];
//    [mutableWorkPeriods addObject:self.currentWorkPeriod];
//    self.workPeriods = mutableWorkPeriods;
//    [[ProjectController sharedInstance]synchronize];
}

- (void)startNewWorkPeriod{
    
    WorkPeriod *workPeriod = [NSEntityDescription insertNewObjectForEntityForName:@"WorkPeriod" inManagedObjectContext:[[CoreDataHelper sharedInstance] managedObjectContext]];
    workPeriod.startTime = [NSDate date];
    workPeriod.periodTitle = @"work period";
    //workPeriod.description = @" ";
    
    [self addWorkPeriodsObject:workPeriod];
    
    [[ProjectController sharedInstance]synchronize];
    
}

- (void)endWorkPeriod:(WorkPeriod *)workPeriod{
    workPeriod.finishTime = [NSDate date];
    [self updateDuration];
    [[ProjectController sharedInstance]synchronize];
}

- (void)addRoundAsWorkPeriod:(WorkPeriod *)workPeriod{

    [self addWorkPeriodsObject:workPeriod];
    
//    NSMutableOrderedSet *mutableWorkPeriods = [NSMutableOrderedSet orderedSetWithOrderedSet:self.workPeriods];
//    [mutableWorkPeriods addObject:workPeriod];
//    self.workPeriods = mutableWorkPeriods;
//    [[ProjectController sharedInstance]synchronize];
}

- (void)updateDuration{
    
//    workPeriod.duration = [NSNumber numberWithDouble:[workPeriod.finishTime timeIntervalSinceDate:workPeriod.startTime]];
    
    [self updateTotalDuration];
    
}

- (void)updateTotalDuration{
    
    NSTimeInterval totalDuration = 0.0;
    NSInteger timeInteger = totalDuration;
    
    
    for (WorkPeriod *workPeriod in self.workPeriods) {
        
        timeInteger += [workPeriod.duration integerValue];
        
    }
    
    totalDuration = timeInteger;
    
    self.totalDuration = [NSNumber numberWithFloat:totalDuration];
    
}


@end

//
//  TTProject.m
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTProject.h"
#import "TTProjectController.h"
#import "POAppDelegate.h"

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
        NSMutableArray *workPeriods = [NSMutableArray new];
        for (NSDictionary *workPeriodDictionary in workPeriodDictionaries) {
            WorkPeriod *workPeriod = [[WorkPeriod alloc] initWithDictionary:workPeriodDictionary];
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
    
    POAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    WorkPeriod *workPeriod = [NSEntityDescription insertNewObjectForEntityForName:@"WorkPeriod" inManagedObjectContext:managedObjectContext];
    workPeriod.startTime = [NSDate date];
    workPeriod.periodTitle = @"work period";
    //workPeriod.description = @" ";
    
    self.currentWorkPeriod = workPeriod;
    
    [self addWorkPeriod];
    [[TTProjectController sharedInstance]synchronize];
    
}

- (void)endCurrentWorkPeriod{
    self.currentWorkPeriod.finishTime = [NSDate date];
    [self updateDuration];
    [[TTProjectController sharedInstance]synchronize];
}

- (void)addRoundAsWorkPeriod:(WorkPeriod *)workPeriod{
    NSMutableArray *mutableWorkPeriods = [NSMutableArray arrayWithArray:self.workPeriods];
    [mutableWorkPeriods addObject:workPeriod];
    self.workPeriods = mutableWorkPeriods;
    [[TTProjectController sharedInstance]synchronize];
}

- (void)updateDuration{

    self.currentWorkPeriod.duration = [NSNumber numberWithDouble:[self.currentWorkPeriod.finishTime timeIntervalSinceDate:self.currentWorkPeriod.startTime]];

    [self updateTotalDuration];
    
}

- (void)updateTotalDuration{
    
    NSTimeInterval totalDuration = 0.0;
    NSInteger timeInteger = totalDuration;

    
    for (WorkPeriod *workPeriod in self.workPeriods) {
    
        timeInteger += [workPeriod.duration integerValue];
        
    }
    
    totalDuration = timeInteger;
    
    self.totalDuration = totalDuration;
            
}

@end

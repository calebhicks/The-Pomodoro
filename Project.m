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

@interface Project()

@property (nonatomic, weak) WorkPeriod *workPeriod;

@end


@implementation Project

@dynamic dateCreated;
@dynamic projectDescription;
@dynamic projectTitle;
@dynamic totalDuration;
@dynamic workPeriods;
@synthesize workPeriod;

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
            WorkPeriod *newWorkPeriod = [[WorkPeriod alloc] initWithDictionary:workPeriodDictionary];
            [workPeriods addObject:newWorkPeriod];
        }
        self.workPeriods = workPeriods;
        
        self.dateCreated = dictionary[createdKey];
    }
    return self;
}

- (void)addWorkPeriod:(WorkPeriod *)newWorkPeriod{

    self.workPeriod = newWorkPeriod;
    
    self.workPeriod.project = self;

}

- (void)startNewWorkPeriod{
    
    self.workPeriod = [NSEntityDescription insertNewObjectForEntityForName:@"WorkPeriod" inManagedObjectContext:[[CoreDataHelper sharedInstance] managedObjectContext]];
    self.workPeriod.startTime = [NSDate date];
    self.workPeriod.periodTitle = @"work period";
    self.workPeriod.project = self;
    
    [[ProjectController sharedInstance]synchronize];
    
}

- (void)endWorkPeriod{
    self.workPeriod.finishTime = [NSDate date];
    [self updateDuration];
    [[ProjectController sharedInstance]synchronize];
}

- (void)addRoundAsWorkPeriod:(WorkPeriod *)workPeriod{

    self.workPeriod.project = self;

}

- (void)updateDuration{
    
    workPeriod.duration = [NSNumber numberWithDouble:[workPeriod.finishTime timeIntervalSinceDate:workPeriod.startTime]];
    
    [self updateTotalDuration];
    
}

- (void)updateTotalDuration{
    
    NSTimeInterval totalDuration = 0.0;
    NSInteger timeInteger = totalDuration;
    
    
    for (WorkPeriod *localWorkPeriod in self.workPeriods) {
        
        timeInteger += [localWorkPeriod.duration integerValue];
        
    }
    
    totalDuration = timeInteger;
    
    self.totalDuration = [NSNumber numberWithFloat:totalDuration];
    
}

- (NSFetchedResultsController*)projectFetchedResultsController{
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:YES]];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:self.managedObjectContext
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}


@end

//
//  ProjectController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ProjectController.h"
#import "POAppDelegate.h"
#import "CoreDataHelper.h"

@interface ProjectController();

@property (strong, nonatomic) NSArray *projects;
@property (strong, nonatomic) NSArray *projectWorkPeriods;

@end

static NSString * const projectListKey = @"projectList";

@implementation ProjectController

+(ProjectController *)sharedInstance {
    static ProjectController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ProjectController alloc] init];
        
        [sharedInstance loadFromCoreData];
    });
    return sharedInstance;
}

-(void)setProjects:(NSArray *)projects{
    _projects = projects;
    
    [self synchronize];
}

-(void)synchronize{
    [[[CoreDataHelper sharedInstance]managedObjectContext] save:nil];
}

-(void)addProject:(Project *)project{
    NSMutableArray *mutableEntries = [NSMutableArray arrayWithArray:self.projects];
    [mutableEntries addObject:project]; //adding entry to end of array
    self.projects = mutableEntries;
}

-(void)removeProject:(Project *)project{
    NSMutableArray *mutableEntries = [NSMutableArray arrayWithArray:self.projects];
    [mutableEntries removeObject:project];
    self.projects = mutableEntries;
}

-(void)loadFromCoreData{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
    self.projects = [[[CoreDataHelper sharedInstance]managedObjectContext] executeFetchRequest:request error:NULL];
}

@end

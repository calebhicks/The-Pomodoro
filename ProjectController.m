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

+ (Project *)defaultProjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
    NSArray* objects = [managedObjectContext executeFetchRequest:request error:NULL];
    Project *project = objects.firstObject;
    
    if (project == nil) {
        
        project = [NSEntityDescription insertNewObjectForEntityForName:@"Project"
                                                  inManagedObjectContext:managedObjectContext];
    }
    
    return project;
    
}

+ (Project *)returnProjectAtIndex:(NSInteger)index{
    
    POAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
    NSArray* objects = [managedObjectContext executeFetchRequest:request error:NULL];
    Project *project = objects[index];
    
    return project;
}

-(void)setProjects:(NSArray *)projects{
    _projects = projects;
    
    [self synchronize];
    
}

-(void)synchronize{
//    NSMutableArray *projectDictionaries = [[NSMutableArray alloc]init];
//    for (Project *project in self.projects) {
//        [projectDictionaries addObject:[project projectDictionary]];
//    }
//    
//    [[NSUserDefaults standardUserDefaults] setObject:projectDictionaries forKey:projectListKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
//    NSArray *projectDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:projectListKey];
//    
//    NSMutableArray *projects = [NSMutableArray new];
//    for (NSDictionary *project in projectDictionaries) {
//        [projects addObject:[[Project alloc] initWithDictionary:project]];
//    }
//    self.projects = projects;
}

@end

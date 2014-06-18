//
//  ProjectController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ProjectController.h"
#import "POAppDelegate.h"

@interface ProjectController();

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation ProjectController

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

@end

//
//  ProjectController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ProjectController.h"

@implementation ProjectController

+ (Project *)defaultProjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Analytics"];
    NSArray* objects = [managedObjectContext executeFetchRequest:request error:NULL];
    Project *project = objects.firstObject;
    
    if (project == nil) {
        
        project = [NSEntityDescription insertNewObjectForEntityForName:@"Analytics"
                                                  inManagedObjectContext:managedObjectContext];
    }
    
    return project;
    
}

@end

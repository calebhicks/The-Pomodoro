//
//  ProjectController.h
//  Wired In
//
//  Created by Caleb Hicks on 6/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface ProjectController : NSObject

+ (Project *)defaultProjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

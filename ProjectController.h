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

@property (strong, nonatomic, readonly) NSArray *projects;

+(ProjectController *)sharedInstance;

-(void)addProject:(Project *)project;

-(void)removeProject:(Project *)project;

-(void) loadFromCoreData;

-(void) synchronize;

@end

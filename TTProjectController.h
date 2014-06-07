//
//  TTProjectController.h
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTProject.h"

@interface TTProjectController : NSObject

+ (TTProjectController *)sharedInstance;

-(void) addProject:(TTProject *)project;

-(void) removeProject:(TTProject *)project;

-(void) loadFromDefaults;

-(void) synchronize;

@end

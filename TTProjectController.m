//
//  TTProjectController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTProjectController.h"

@interface TTProjectController()

@property (strong, nonatomic) NSArray *projects;

@end

static NSString * const projectListKey = @"projectList";


@implementation TTProjectController

+ (TTProjectController *)sharedInstance {
    static TTProjectController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TTProjectController alloc] init];
        
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)setEntries:(NSArray *)projects{
    _projects = projects;
    
    [self synchronize];
    
}

- (void)synchronize{
    NSMutableArray *projectDictionaries = [[NSMutableArray alloc]init];
    for (TTProject *project in self.projects) {
        [projectDictionaries addObject:[project projectDictionary]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:projectDictionaries forKey:projectListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)addProject:(TTProject *)project{
    NSMutableArray *mutableEntries = [NSMutableArray arrayWithArray:self.projects];
    [mutableEntries addObject:project]; //adding entry to end of array
    self.entries = mutableEntries;
}

- (void)removeProject:(TTProject *)project{
    NSMutableArray *mutableEntries = [NSMutableArray arrayWithArray:self.projects];
    [mutableEntries removeObject:project];
    self.projects = mutableEntries;
}

-(void)loadFromDefaults{
    NSArray *projectDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:projectListKey];
    
    NSMutableArray *projects = [NSMutableArray new];
    for (NSDictionary *project in projectDictionaries) {
        [projects addObject:[[TTProject alloc] initWithDictionary:project]];
    }
    self.projects = projects;
}

@end

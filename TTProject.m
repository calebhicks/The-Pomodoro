//
//  TTProject.m
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTProject.h"
#import "TTWorkPeriod.h"

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
        for (TTWorkPeriod *period in self.workPeriods) {
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
        self.workPeriods = dictionary[periodsKey];
        self.dateCreated = dictionary[createdKey];
    }
    return self;
}

@end

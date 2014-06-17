//
//  WorkPeriod.m
//  Wired In
//
//  Created by Caleb Hicks on 6/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "WorkPeriod.h"

static NSString * const titleKey = @"title";
static NSString * const startKey = @"start";
static NSString * const finishKey = @"finish";
static NSString * const descriptionKey = @"description";
static NSString * const durationKey = @"duration";

@implementation WorkPeriod

@dynamic duration;
@dynamic finishTime;
@dynamic periodDescription;
@dynamic periodTitle;
@dynamic startTime;
@dynamic project;

- (NSDictionary *)workPeriodDictionary{
    
    NSMutableDictionary *entryDictionary = [[NSMutableDictionary alloc]init];
    
    if (self.periodTitle) {
        [entryDictionary setValue:self.periodTitle forKeyPath:titleKey];
    }
    
    if (self.startTime) {
        [entryDictionary setValue:self.startTime forKeyPath:startKey];
    }
    
    if (self.finishTime){
        [entryDictionary setValue:self.finishTime forKey:finishKey];
    }
    
    if (self.periodDescription){
        [entryDictionary setValue:self.description forKeyPath:descriptionKey];
    }
    
    if (self.duration){
        NSNumber *durationInt = self.duration;
        
        [entryDictionary setValue:durationInt forKey:durationKey];
    }
    
    return entryDictionary;
}


- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.periodTitle = dictionary[titleKey];
        self.startTime = dictionary[startKey];
        self.finishTime = dictionary[finishKey];
        self.periodDescription = dictionary[descriptionKey];
        
        NSNumber *duration = dictionary[durationKey];
        
        self.duration = duration;
        
    }
    return self;
}

@end

//
//  TTWorkPeriod.m
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTWorkPeriod.h"

static NSString * const titleKey = @"title";
static NSString * const startKey = @"start";
static NSString * const finishKey = @"finish";
static NSString * const descriptionKey = @"description";
static NSString * const durationKey = @"duration";


@implementation TTWorkPeriod

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
    
    if (self.description){
        [entryDictionary setValue:self.description forKeyPath:descriptionKey];
    }
    
    if (self.duration){
        NSInteger durationInt = self.duration;
        
        [entryDictionary setValue:[NSNumber numberWithInteger:durationInt] forKey:durationKey];
    }
    
    return entryDictionary;
}


- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.periodTitle = dictionary[titleKey];
        self.startTime = dictionary[startKey];
        self.finishTime = dictionary[finishKey];
        self.description = dictionary[descriptionKey];
        
        NSInteger duration = [dictionary[durationKey] integerValue];
        
        self.duration = duration;

    }
    return self;
}

@end

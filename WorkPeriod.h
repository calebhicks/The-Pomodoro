//
//  WorkPeriod.h
//  Wired In
//
//  Created by Caleb Hicks on 6/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WorkPeriod : NSManagedObject

@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * finishTime;
@property (nonatomic, retain) NSString * periodDescription;
@property (nonatomic, retain) NSString * periodTitle;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSManagedObject *project;

- (NSDictionary *)workPeriodDictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

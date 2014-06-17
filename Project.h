//
//  Project.h
//  Wired In
//
//  Created by Caleb Hicks on 6/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WorkPeriod;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * projectDescription;
@property (nonatomic, retain) NSString * projectTitle;
@property (nonatomic, retain) NSNumber * totalDuration;
@property (nonatomic, retain) NSOrderedSet *workPeriods;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)insertObject:(WorkPeriod *)value inWorkPeriodsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromWorkPeriodsAtIndex:(NSUInteger)idx;
- (void)insertWorkPeriods:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeWorkPeriodsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInWorkPeriodsAtIndex:(NSUInteger)idx withObject:(WorkPeriod *)value;
- (void)replaceWorkPeriodsAtIndexes:(NSIndexSet *)indexes withWorkPeriods:(NSArray *)values;
- (void)addWorkPeriodsObject:(WorkPeriod *)value;
- (void)removeWorkPeriodsObject:(WorkPeriod *)value;
- (void)addWorkPeriods:(NSOrderedSet *)values;
- (void)removeWorkPeriods:(NSOrderedSet *)values;
@end

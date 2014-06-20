//
//  CoreDataHelper.h
//  Wired In
//
//  Created by Caleb Hicks on 6/20/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

+ (CoreDataHelper *)sharedInstance;
- (NSManagedObjectContext *)managedObjectContext;


@end

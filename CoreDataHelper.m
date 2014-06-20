//
//  CoreDataHelper.m
//  Wired In
//
//  Created by Caleb Hicks on 6/20/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "CoreDataHelper.h"
#import "POAppDelegate.h"

@implementation CoreDataHelper

+ (CoreDataHelper *)sharedInstance {
    static CoreDataHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CoreDataHelper new];
    });
    return sharedInstance;
}

- (NSManagedObjectContext *)managedObjectContext{

    POAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    return managedObjectContext;
}

@end

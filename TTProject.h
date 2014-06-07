//
//  TTProject.h
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTProject : NSObject

@property (strong, nonatomic) NSString *projectTitle;
@property (strong, nonatomic) NSArray *workPeriods;
@property (strong, nonatomic) NSDate *dateCreated;

- (NSDictionary *)projectDictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;


@end

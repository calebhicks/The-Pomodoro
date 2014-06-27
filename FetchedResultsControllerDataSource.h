//
//  FetchedResultsControllerDataSource.h
//  Wired In
//
//  Created by Caleb Hicks on 6/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchedResultsControllerDataSource : NSObject <UITableViewDataSource, NSFetchedResultsControllerDelegate>

- (id)initWithTableView:(UITableView*)tableView;

@property (strong, nonatomic) NSString *reuseIdentifier;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) id delegate;

@end

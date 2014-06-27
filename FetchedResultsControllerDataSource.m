//
//  FetchedResultsControllerDataSource.m
//  Wired In
//
//  Created by Caleb Hicks on 6/27/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "FetchedResultsControllerDataSource.h"
#import "TTProjectDetailViewController.h"

@interface FetchedResultsControllerDataSource()



@end

@implementation FetchedResultsControllerDataSource

- (id)initWithTableView:(UITableView*)tableView
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.tableView.dataSource = self;
    }
    return self;
}

- (void)setFetchedResultsController:(NSFetchedResultsController*)fetchedResultsController
{
    _fetchedResultsController = fetchedResultsController;
    fetchedResultsController.delegate = self;
    [fetchedResultsController performFetch:NULL];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return self.fetchedResultsController.sections.count;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.fetchedResultsController.sections count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    id cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier
                                              forIndexPath:indexPath];
    [self.delegate configureCell:cell withProject:object];
    return cell;
    
}

- (void)configureCell:(id)theCell withProject:(Project *)project
{
    UITableViewCell* cell = theCell;
    cell.textLabel.text = project.projectTitle;
}

@end

//
//  TTListTableViewDatasource.m
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTListTableViewDatasource.h"
#import "Project.h"
#import "ProjectController.h"

@interface TTListTableViewDatasource() 

@end

@implementation TTListTableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    Project *project = [ProjectController sharedInstance].projects[indexPath.row];
    cell.textLabel.text = project.projectTitle;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    if (project.projectDescription) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", project.projectDescription];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Project Created: %@", [dateFormatter stringFromDate:project.dateCreated]];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[ProjectController sharedInstance].projects count];
}



@end

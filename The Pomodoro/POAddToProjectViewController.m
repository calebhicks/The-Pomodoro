//
//  POAddToProjectViewController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/12/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POAddToProjectViewController.h"
#import "TTProjectController.h"

@interface POAddToProjectViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation POAddToProjectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self registerTableView:self.tableView];
    
    [self.view addSubview:self.tableView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Table View Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    TTProject *project = [TTProjectController sharedInstance].projects[indexPath.row];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[TTProjectController sharedInstance].projects count];
}


- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.delegate selectorDidSelectProject:[TTProjectController sharedInstance].projects[indexPath.row]];
}

@end

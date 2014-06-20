//
//  TTListTableViewController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTListTableViewController.h"
#import "TTListTableViewDatasource.h"
#import "ProjectController.h"
#import "TTProjectDetailViewController.h"
#import "CoreDataHelper.h"

@interface TTListTableViewController () <UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TTListTableViewDatasource *dataSource;

@end

@implementation TTListTableViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.dataSource = [[TTListTableViewDatasource alloc]init];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self registerTableView:self.tableView];
    
    UIBarButtonItem *addEntryButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newProject)];
    
    self.navigationItem.rightBarButtonItem = addEntryButton;
    
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    //[[TTProjectController sharedInstance] synchronize];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newProject{
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:[[CoreDataHelper sharedInstance]managedObjectContext]];
    project.dateCreated = [NSDate date];
    
    [[ProjectController sharedInstance] addProject:project];
    
    TTProjectDetailViewController *projectView = [[TTProjectDetailViewController alloc]init];
    
    projectView.project = project;
    
    [self.navigationController pushViewController:projectView animated:YES];
}

- (void)registerTableView:(UITableView *)tableView {
[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TTProjectDetailViewController *projectView = [[TTProjectDetailViewController alloc]init];
    
    projectView.project = [ProjectController sharedInstance].projects[indexPath.row];
    
    //projectView.title = projectView.project.projectTitle;
    
    [projectView.project updateDuration];
    
    [self.navigationController pushViewController:projectView animated:YES];
}

@end

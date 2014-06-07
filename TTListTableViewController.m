//
//  TTListTableViewController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTListTableViewController.h"
#import "TTListTableViewDatasource.h"

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
    [self registerTableView:self.tableView];
    
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerTableView:(UITableView *)tableView {
[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
@end

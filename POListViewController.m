//
//  POListViewController.m
//  The Pomodoro
//
//  Created by Caleb Hicks on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POListViewController.h"
#import "POTimerViewController.h"

static NSString * const CurrentRoundKey = @"CurrentRound";

@interface POListViewController ()

@property (nonatomic, assign) NSInteger currentRound;

@end

@implementation POListViewController

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
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    
    [self.view addSubview:tableView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init]; //[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Round %d - %@ min", indexPath.row + 1, [[[self times] objectAtIndex:indexPath.row] stringValue]];

    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[self times] count];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%d", [[[self times] objectAtIndex:indexPath.row] integerValue]);
    
    [POTimerViewController sharedInstance].minutes = [[[self times] objectAtIndex:indexPath.row] integerValue];
    
    //[[POTimerViewController sharedInstance] setTimer:[[[self times] objectAtIndex:indexPath.row] integerValue]];
    
}

- (void)postMinutes{
    
}

- (NSArray *)times{
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}

@end

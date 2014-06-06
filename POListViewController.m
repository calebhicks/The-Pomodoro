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

@interface POListViewController () <UIAlertViewDelegate>

@property (nonatomic, assign) NSInteger currentRound;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *currentTime;

@end

@implementation POListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.currentRound = [[NSUserDefaults standardUserDefaults] integerForKey:CurrentRoundKey];
        
        [self registerForNotifications];
    }
    return self;
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRound:) name:RoundCompleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentRound:) name:@"CurrentTime" object:nil];

}

- (void)unregisterForNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RoundCompleteNotification object:nil];
}

- (void)dealloc {
    [self unregisterForNotifications];
}

- (void)setCurrentRound:(NSInteger)currentRound {
    _currentRound = currentRound;

    [[NSUserDefaults standardUserDefaults] setValue:@(currentRound) forKeyPath:CurrentRoundKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    [self.view addSubview:self.tableView];
    
    [self selectCurrentRound];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateCurrentRound:(NSNotification *)notification{
    NSLog(@"%@", notification.object);
    self.currentTime = notification.object;
    
    NSArray *array = @[[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [self.tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init]; //[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row == 0){
        cell.textLabel.text = [NSString stringWithFormat:@"Current round: %@", self.currentTime];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"Round %d - %@ min", indexPath.row, [[[self times] objectAtIndex:indexPath.row-1] stringValue]];
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[self times] count]+1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.currentRound = indexPath.row+1;
    
    [self postMinutes];
    
}

- (void)postMinutes{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NewRoundTimeNotificationName object:nil userInfo:@{UserInfoMinutesKey: [self times][self.currentRound]}];
    
}

- (NSArray *)times{
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}

- (void)endRound:(NSNotification *)notification{
    self.currentRound++;
    if (self.currentRound == [[self times] count]) {
        self.currentRound = 0;
    }
    
    [self selectCurrentRound];
    
    [self postMinutes];
    
    UIAlertView *alertEndRound = [[UIAlertView alloc]initWithTitle:@"Round Complete" message:@"Your round has finished, continue with next round?" delegate:self cancelButtonTitle:@"Not now" otherButtonTitles:@"Next Round", nil];
    
    [alertEndRound show];
    
    [self scheduleNotification];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        return;
    }else{
        
    }
}

- (void) scheduleNotification{
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.fireDate = [[NSDate date] dateByAddingTimeInterval:[self.currentTime integerValue]];
    notification.alertBody = @"Your round has finished.";
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    
}


- (void)selectCurrentRound {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentRound inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath
                                animated:NO
                          scrollPosition:UITableViewScrollPositionTop];
    
}

@end

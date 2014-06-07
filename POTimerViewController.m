//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by Caleb Hicks on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POTimerViewController.h"
#import "POListViewController.h"

static NSString * const CurrentMinutesKey = @"CurrentMinutes";
static NSString * const CurrentSecondsKey = @"CurrentSeconds";

@interface POTimerViewController ()

@property (assign, nonatomic) BOOL active;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;

@property (assign, nonatomic) NSInteger minutes;
@property (assign, nonatomic) NSInteger seconds;

@property (assign, nonatomic) NSInteger pausedMinutes;
@property (assign, nonatomic) NSInteger pausedSeconds;


@end

@implementation POTimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self registerForNotifications];
        
    }
    return self;
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound:) name:NewRoundTimeNotificationName object:nil];
}

- (void)unregisterForNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NewRoundTimeNotificationName object:nil];
}

- (void)dealloc {
    [self unregisterForNotifications];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Focus";
    
    [self updateLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTime:(id)sender {
    
    if(self.active == NO){
        [self.startTimeButton setTitle:@"Pause" forState:UIControlStateNormal];
        self.active = YES;
        
        [self performSelector:@selector(decreaseSecond) withObject:nil afterDelay:1.0];
        [self scheduleNotification];
        [self saveTimerInfo];
        
    }else if (self.active == YES){
        self.active = NO;
        [self.startTimeButton setTitle:@"Start" forState:UIControlStateNormal];
        [self cancelLocalNotifications];
    }
    

}

- (void) scheduleNotification{
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    
    if(notification){
        notification.fireDate = [[NSDate date] dateByAddingTimeInterval:self.minutes*60+self.seconds];
        notification.alertBody = @"Nice work. Your round has finished.";
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.repeatInterval = 0;
        notification.applicationIconBadgeNumber = 0;
        notification.userInfo = @{@"roundfinished": @"YES"};
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
}

- (void) cancelLocalNotifications{
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
}

- (void)setTimer:(NSInteger)minutes{
    
    self.minutes = minutes;
    self.seconds = 0;
    
    [self startTime:nil];
        
}

- (void)updateLabel {
    
    if (self.seconds < 10) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d:0%d", self.minutes, self.seconds];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentTime" object:self.timeLabel.text userInfo:nil];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%d:%d", self.minutes, self.seconds];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentTime" object:self.timeLabel.text userInfo:nil];
    }
    
    if (self.active == YES){
        [self.startTimeButton setTitle:@"Pause" forState:UIControlStateNormal];
    }else if (self.active == NO){
        [self.startTimeButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
}

- (void)decreaseSecond{
    
    if(self.seconds > 0){
        self.seconds --;
    }
    
    if(self.minutes > 0){
        if (self.seconds == 0){
            self.seconds = 59;
            self.minutes--;
        }
    }else{
        if(self.seconds == 0){
            self.startTimeButton.enabled = YES;
            [self.startTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            self.active = NO;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:RoundCompleteNotification object:nil userInfo:nil];
        }
        
    }
    
    [self updateLabel];
    
    if (self.active == YES) {
        [self performSelector:@selector(decreaseSecond) withObject:nil afterDelay:1.0];
    }
    
}

- (void)newRound:(NSNotification *)notification {
    self.minutes = [notification.userInfo[UserInfoMinutesKey] integerValue];
    self.seconds = 0;
    
    [self cancelLocalNotifications];
    
    [self updateLabel];
}

- (void)saveTimerInfo {
    
    NSDate *finishTime = [[NSDate date] dateByAddingTimeInterval:self.minutes*60+self.seconds];
    [[NSUserDefaults standardUserDefaults] setObject:finishTime forKey:@"EndTime"];
    
    NSLog(@"%@", finishTime);
    
}

- (void)loadUpdatedTimerInfo{

    NSDate *finishTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"EndTime"];
    
    NSTimeInterval timeDifferential = [[NSDate date]timeIntervalSinceDate:finishTime];
    NSInteger differentialInSeconds = timeDifferential*-1;
    
    
    // set minutes
    
    if(differentialInSeconds > 60){
        self.minutes = floor(differentialInSeconds/60);
    }
    
    // set seconds
    
    self.seconds = differentialInSeconds % 60;
    
    NSLog(@"The time differential is %f", timeDifferential);
    NSLog(@"%d", self.minutes);
    NSLog(@"%d", self.seconds);

}

@end

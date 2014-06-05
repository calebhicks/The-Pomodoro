//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by Caleb Hicks on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POTimerViewController.h"
#import "POListViewController.h"

@interface POTimerViewController ()

@property (assign, nonatomic) BOOL active;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseTimeButton;

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
    
    //self.view.backgroundColor = [UIColor redColor];
    
    [self updateLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTime:(id)sender {
    self.startTimeButton.enabled = NO;
    self.pauseTimeButton.enabled = YES;
    [self.startTimeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.active = YES;
    
    [self performSelector:@selector(decreaseSecond) withObject:nil afterDelay:1.0];

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
    
    if (self.active) {
        [self performSelector:@selector(decreaseSecond) withObject:nil afterDelay:1.0];
    }
    
}

- (void)newRound:(NSNotification *)notification {
    self.minutes = [notification.userInfo[UserInfoMinutesKey] integerValue];
    self.seconds = 0;
    
    // Re-enable the button
    self.startTimeButton.enabled = YES;
    [self.startTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self updateLabel];
}

@end

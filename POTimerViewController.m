//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by Caleb Hicks on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POTimerViewController.h"

@interface POTimerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;

@end

@implementation POTimerViewController

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
    
    self.title = @"Focus";
    
    self.view.backgroundColor = [UIColor redColor];
    
}

+ (POTimerViewController *)sharedInstance {
    static POTimerViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[POTimerViewController alloc] init];
        [sharedInstance updateLabel];
    });
    return sharedInstance;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTime:(id)sender {
    self.startTimeButton.enabled = NO;
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
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%d:%d", self.minutes, self.seconds];
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
            
            // todo: send notification
        }
        
    }
    
    [self updateLabel];
    
    if (self.active) {
        [self performSelector:@selector(decreaseSecond) withObject:nil afterDelay:1.0];
    }
    
}

//- (void)newRound:(NSNotification *)notification {
//    self.minutes = [notification.userInfo[UserInfoMinutesKey] integerValue];
//    self.seconds = 0;
//    
//    // Re-enable the button
//    self.button.enabled = YES;
//    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    [self updateLabel];
//}

@end

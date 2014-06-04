//
//  POTimerViewController.h
//  The Pomodoro
//
//  Created by Caleb Hicks on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POTimerViewController : UIViewController

@property (assign, nonatomic) BOOL active;

@property (assign, nonatomic) NSInteger minutes;
@property (assign, nonatomic) NSInteger seconds;

+ (POTimerViewController *)sharedInstance;

- (void)setTimer:(NSInteger)minutes;

@end

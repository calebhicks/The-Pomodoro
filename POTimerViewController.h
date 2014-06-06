//
//  POTimerViewController.h
//  The Pomodoro
//
//  Created by Caleb Hicks on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const RoundCompleteNotification = @"RoundCompleteNotification";


@interface POTimerViewController : UIViewController


- (void)setTimer:(NSInteger)minutes;
- (void)saveTimerInfo;
- (void)loadUpdatedTimerInfo;

@end

//
//  POListViewController.h
//  The Pomodoro
//
//  Created by Caleb Hicks on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>



static NSString * const NewRoundTimeNotificationName = @"NewRoundTimeNotification";
static NSString * const UserInfoMinutesKey = @"minutes";

@interface POListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (void) showAlertView;

@end

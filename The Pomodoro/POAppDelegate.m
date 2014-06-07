//
//  POAppDelegate.m
//  The Pomodoro
//
//  Created by Joshua Howland on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POAppDelegate.h"
#import "POTimerViewController.h"
#import "POListViewController.h"

@interface POAppDelegate ();

@property (strong, nonatomic) POListViewController *listViewController;
@property (strong, nonatomic) POTimerViewController *timerViewController;

@end


@implementation POAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.listViewController = [[POListViewController alloc]init];
    self.listViewController.tabBarItem.title = @"Rounds";
    self.listViewController.title = @"Rounds";
    self.listViewController.tabBarItem.image = [UIImage imageNamed:@"wiredin"];
    UINavigationController *listNav = [[UINavigationController alloc]initWithRootViewController:self.listViewController];
    
    
    self.timerViewController = [[POTimerViewController alloc]init];
    self.timerViewController.tabBarItem.title = @"Timer";
    self.timerViewController.title = @"Timer";
    self.timerViewController.tabBarItem.image = [UIImage imageNamed:@"watch"];
    [self.timerViewController loadView];
    //[self.timerViewController setInitialTimerValue];
    UINavigationController *timerNav = [[UINavigationController alloc]initWithRootViewController:self.timerViewController];
    
    
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    tabBar.viewControllers = @[listNav, timerNav]; //load timerNav first so listNav can have value set for time
    [self.window setRootViewController:tabBar];

    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    [self.timerViewController saveTimerInfo];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self.listViewController postMinutes];
    [self.timerViewController loadUpdatedTimerInfo];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    // display alert only if notification is of round finished
    if( [notification.userInfo  isEqual: @{@"roundfinished": @"YES"}]){
    UIAlertView *alertEndRound = [[UIAlertView alloc]initWithTitle:@"Round Complete" message:@"Nice work! Go for another round!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alertEndRound show];
    }
    
}

@end

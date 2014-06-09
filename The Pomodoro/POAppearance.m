//
//  POAppearance.m
//  The Pomodoro
//
//  Created by Caleb Hicks on 6/4/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POAppearance.h"

@implementation POAppearance

+(void)load{
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:.11 green:.38 blue:.56 alpha:1]];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:.11 green:.38 blue:.56 alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont fontWithName:@"Avenir-Light" size:20]
                                                           }];
}

@end
//
//  POIntroViewController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/6/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POIntroViewController.h"
#import "POTimerViewController.h"
#import "POListViewController.h"

@interface POIntroViewController ()

@end

@implementation POIntroViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    POTimerViewController *timerView = [[POTimerViewController alloc]init];
    
    return timerView;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    POTimerViewController *timerView = [[POTimerViewController alloc]init];
    
    return timerView;

}

@end

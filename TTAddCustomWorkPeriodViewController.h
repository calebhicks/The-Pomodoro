//
//  TTAddCustomWorkPeriodViewController.h
//  Wired In
//
//  Created by Caleb Hicks on 6/9/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "WorkPeriod.h"

@interface TTAddCustomWorkPeriodViewController : UIViewController

@property (strong, nonatomic) Project *project;
@property (strong, nonatomic) WorkPeriod  *workPeriod;

@end

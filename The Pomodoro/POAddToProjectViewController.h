//
//  POAddToProjectViewController.h
//  Wired In
//
//  Created by Caleb Hicks on 6/12/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@protocol SelectorDelegate <NSObject>

-(void) selectorDidSelectProject:(Project *)project;

@end

@interface POAddToProjectViewController : UIViewController

@property (nonatomic, weak) id <SelectorDelegate> delegate;

@end

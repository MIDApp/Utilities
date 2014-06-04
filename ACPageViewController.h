//
//  ACPageViewController.h
//
//  Created by Andrea Cremaschi on 09/04/14.
//  Copyright (c) 2014 midapp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIViewController*(^PageViewControllerConfigurationBlock)(id model, int pageNumber);

@interface ACPageViewController : UIPageViewController

@property (strong) PageViewControllerConfigurationBlock pageViewControllerConfigurationBlock;
@property (strong) NSArray *modelArray;
@property int currentPage;

@end


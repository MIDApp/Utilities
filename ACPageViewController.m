//
//  PageViewController.m
//  duczogno
//
//  Created by Andrea Cremaschi on 09/04/14.
//  Copyright (c) 2014 midapp. All rights reserved.
//

#import "ACPageViewController.h"
#import "UIViewController+PageViewController.h"

@interface ACPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@end

@implementation ACPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIScrollView*)scrollView {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView*)view;
        }
    }
    return nil;
    
}

- (UIViewController*)viewControllerAtIndex: (int) index {
    UIViewController *pageVC;
    if (self.pageViewControllerConfigurationBlock) {
        pageVC = self.pageViewControllerConfigurationBlock(index);
        // TODO: if the pageVC.view's contains a scrollview, its delegate must be setted to self
        //        schedaVC.scrollViewDelegate= self;
    } else {
        pageVC = [UIViewController new];
    }
    pageVC.pageIndex = index;
    
    return pageVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // imposta il delegato della scrollview
    [[self scrollView] setDelegate:self];
    
    
    // Elimina la tap gesture recognizer perché interferisce con lo scroll della pagina
    UIGestureRecognizer* tapRecognizer = nil;
    for (UIGestureRecognizer* recognizer in self.gestureRecognizers) {
        if ( [recognizer isKindOfClass:[UITapGestureRecognizer class]] ) {
            tapRecognizer = recognizer;
            break;
        }
    }
    
    if ( tapRecognizer ) {
        [self.view removeGestureRecognizer:tapRecognizer];
    }
    
    self.dataSource = self;
    self.delegate = self;
    
    UIViewController *vc = [self viewControllerAtIndex: self.currentPage];
    
    [self setViewControllers: @[vc]
                   direction: UIPageViewControllerNavigationDirectionForward
                    animated: YES
                  completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDatasource

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    int curIndex = viewController.pageIndex;
    return [self viewControllerAtIndex:curIndex +1];
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    int curIndex = viewController.pageIndex;
    if (curIndex == 0) return nil;
    return [self viewControllerAtIndex:curIndex -1];
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView != [self scrollView]) {
        [[self scrollView] setScrollEnabled: NO];
    } else {
        UIView *childView = [self.viewControllers.firstObject view];
        childView.userInteractionEnabled = NO;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [[self scrollView] setScrollEnabled: YES];
    UIView *childView = [self.viewControllers.firstObject view];
    childView.userInteractionEnabled = YES;
}

@end

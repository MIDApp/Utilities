//
//  UIViewController+PageViewController.m
//  duczogno
//
//  Created by Andrea Cremaschi on 09/04/14.
//  Copyright (c) 2014 midapp. All rights reserved.
//

#import "UIViewController+PageViewController.h"
#import <objc/runtime.h>


static char kViewControllerIndexKey;

@implementation UIViewController (PageViewController)

- (int)pageIndex {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    NSNumber* pageIndexNumber = objc_getAssociatedObject(self, &kViewControllerIndexKey);
#pragma clang diagnostic pop
    return pageIndexNumber.intValue;
}

- (void)setPageIndex:(int)imageCache {
    objc_setAssociatedObject(self, &kViewControllerIndexKey, @(imageCache), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

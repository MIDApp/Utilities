//
//  AutosizeTableView.m
//  DUC
//
//  Created by Alessio Anesa on 24/04/15.
//  Copyright (c) 2015 MIDApp s.r.l.. All rights reserved.
//

#import "AutosizeTableView.h"

@interface UIView (FittingSize)

- (BOOL)sizeToFitVerticallyWithWidth:(CGFloat)width;
- (CGFloat)heightToFitVerticallyWithWidth:(CGFloat)width;

@end

@implementation AutosizeTableView

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self adjustContentSize];
}

- (void)adjustContentSize
{
    CGFloat width = self.frame.size.width;
    
    UIView *tableHeaderView = self.tableHeaderView;
    UIView *tableFooterView = self.tableFooterView;
    
    if ([tableHeaderView sizeToFitVerticallyWithWidth:width] || [tableFooterView sizeToFitVerticallyWithWidth:width])
    {
        CGPoint contentOffset = self.contentOffset;
        
        [self setTableHeaderView:nil];
        [self setTableFooterView:nil];
        
        CGSize contentSize = [self sizeThatFits:CGSizeMake(width, UILayoutFittingExpandedSize.height)];
        
        contentSize.height += [tableHeaderView heightToFitVerticallyWithWidth:width];
        contentSize.height += [tableFooterView heightToFitVerticallyWithWidth:width];
        
        
        [self setTableHeaderView:tableHeaderView];
        [self setTableFooterView:tableFooterView];
        
        [self setContentSize:contentSize];
        [self setContentOffset:contentOffset];
    }
}

@end

@implementation UIView (FittingSize)

- (CGFloat)heightToFitVerticallyWithWidth:(CGFloat)width
{
    NSLayoutConstraint *constraint;
    constraint = [NSLayoutConstraint constraintWithItem:self
                                              attribute:NSLayoutAttributeWidth
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                             multiplier:1.0
                                               constant:width];
    [self addConstraint:constraint];
    
    CGSize size = [self systemLayoutSizeFittingSize:CGSizeMake(width, UILayoutFittingCompressedSize.height)];
    
    [self removeConstraint:constraint];
    
    return size.height;
}

- (BOOL)sizeToFitVerticallyWithWidth:(CGFloat)width
{
    NSLayoutConstraint *constraint;
    constraint = [NSLayoutConstraint constraintWithItem:self
                                              attribute:NSLayoutAttributeWidth
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                             multiplier:1.0
                                               constant:width];
    [self addConstraint:constraint];
    
    CGSize size = [self systemLayoutSizeFittingSize:CGSizeMake(width, UILayoutFittingCompressedSize.height)];
    
    [self removeConstraint:constraint];
    
    if (CGSizeEqualToSize(self.frame.size, size))
        return NO;
    
    self.frame = ({
        CGRect headerFrame = self.frame;
        headerFrame.size = size;
        headerFrame;
    });
    return YES;
}

@end

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
    
    [self sizeToFit];
}

- (void)sizeToFit
{
    CGFloat width = self.frame.size.width;
    CGSize contentSize = [self sizeThatFits:CGSizeMake(width, UILayoutFittingExpandedSize.height)];
    contentSize.height += [self.tableHeaderView heightToFitVerticallyWithWidth:width];
    contentSize.height += [self.tableFooterView heightToFitVerticallyWithWidth:width];

    [self.tableHeaderView sizeToFitVerticallyWithWidth:width];
    [self.tableFooterView sizeToFitVerticallyWithWidth:width];
    
    [super setTableHeaderView:self.tableHeaderView];
    [super setTableFooterView:self.tableFooterView];
    
//    [super setContentSize:contentSize];
    
    [super sizeToFit];
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

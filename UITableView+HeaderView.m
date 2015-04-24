#import "UITableView+HeaderView.h"

static NSString *ConstraintIdentifier = @"WidthConstraintIdentifier";

@implementation UITableView (HeaderView)

- (void) sizeHeaderToFit
{
    [self sizeHeaderToFitForced:NO];
}

- (void)sizeHeaderToFitForced:(BOOL)forced
{
    UIView *headerView = self.tableHeaderView;
    
    if (([self updateWidthConstraintForView:headerView] || forced) && [headerView sizeToFitVertically])
    {
        self.tableHeaderView = headerView;
        [self layoutIfNeeded];
    }
}

- (void)sizeFooterToFit
{
    [self sizeFooterToFitForced:NO];
}

- (void) sizeFooterToFitForced:(BOOL)forced
{
    UIView *footerView = self.tableFooterView;
    
    if (([self updateWidthConstraintForView:footerView] || forced) && [footerView sizeToFitVertically])
    {
        self.tableFooterView = footerView;
        [self layoutIfNeeded];
    }
}

- (BOOL)updateWidthConstraintForView:(UIView *)view
{
    if (!view)
        return NO;
    
    NSLayoutConstraint *constraint;
    for (constraint in view.constraints)
    {
        if (constraint.identifier && [constraint.identifier isEqualToString:ConstraintIdentifier])
        {
            break;
        }
        else
            constraint = nil;
    }
    
    if (!constraint)
    {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        constraint = [NSLayoutConstraint constraintWithItem:view
                                                  attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                 multiplier:1.0
                                                   constant:self.bounds.size.width];
        constraint.identifier = ConstraintIdentifier;
        [view addConstraint:constraint];
        return YES;
    }
    else
    {
        if (constraint.constant == self.bounds.size.width)
            return NO;
        constraint.constant = self.bounds.size.width;
        return YES;
    }
}

@end

@implementation UIView (FittingSize)

- (BOOL)sizeToFitVertically
{
    [self layoutIfNeeded];
    CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
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
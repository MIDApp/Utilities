#import "UITableView+HeaderView.h"

static NSString *ConstraintIdentifier = @"WidthConstraintIdentifier";

@implementation UITableView (HeaderView)

- (void) sizeHeaderToFit
{
    UIView *headerView = self.tableHeaderView;
    
    [self updateWidthConstraintForView:headerView];
    if ([headerView sizeToFitVertically])
        self.tableHeaderView = headerView;
}

- (void) sizeFooterToFit
{
    UIView *footerView = self.tableFooterView;
    
    [self updateWidthConstraintForView:footerView];
    if ([footerView sizeToFitVertically])
        self.tableFooterView = footerView;
}

- (void)updateWidthConstraintForView:(UIView *)view
{
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
        constraint = [NSLayoutConstraint constraintWithItem:view
                                                  attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                 multiplier:1.0
                                                   constant:self.bounds.size.width];
        constraint.identifier = ConstraintIdentifier;
        [view addConstraint:constraint];
    }
    else
    {
        constraint.constant = self.bounds.size.width;
    }
}

@end

@implementation UIView (FittingSize)

- (BOOL)sizeToFitVertically
{
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
#import <UIKit/UIKit.h>

@interface UITableView (HeaderView)

- (void) sizeHeaderToFit;
- (void) sizeFooterToFit;

@end

@interface UIView (FittingSize)

- (void)sizeToFitVertically;

@end
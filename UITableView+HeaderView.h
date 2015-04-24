#import <UIKit/UIKit.h>

@interface UITableView (HeaderView)

- (void) sizeHeaderToFit;
- (void) sizeFooterToFit;
- (void) sizeHeaderToFitForced:(BOOL)forced;
- (void) sizeFooterToFitForced:(BOOL)forced;

@end

@interface UIView (FittingSize)

- (BOOL)sizeToFitVertically;

@end
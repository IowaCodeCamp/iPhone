#import <UIKit/UIKit.h>

@class UIViewController;

@interface AsyncImageDownload : UIView {
    NSURLConnection* connection;
    NSMutableData* data;
    NSIndexPath* indexPath;
    UIViewController* viewController;
    UIImageView* imgview;
}

@property (nonatomic, retain) NSURLConnection* connection;
@property (nonatomic, retain) NSMutableData* data;
@property (nonatomic, retain) NSIndexPath* indexPath;
@property (nonatomic, retain) UIViewController* viewController;
@property (nonatomic, retain) UIImageView* imgview;

- (void) loadImageFromURL:(NSString *)url:(NSIndexPath *)indexInfo:(UIViewController *)vwController:(UIImageView *)imgview;

@end

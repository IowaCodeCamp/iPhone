#import <UIKit/UIKit.h>

@class IowaCodeCampViewController;
@class SessionDetails;
@class Session;

@interface IowaCodeCampAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow* window;
    IowaCodeCampViewController *viewController;
    IBOutlet UINavigationController* navController;
    IBOutlet SessionDetails* detailsController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet IowaCodeCampViewController *viewController;
@property (nonatomic, retain) SessionDetails *detailsController;

- (void)sessionJsonFinished;
- (void)showSessionDetailsView:(Session *)session;
- (void)launchSpeakerDetailsView;

@end

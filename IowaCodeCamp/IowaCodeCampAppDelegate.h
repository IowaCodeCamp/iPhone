#import <UIKit/UIKit.h>

@class IowaCodeCampViewController;
@class SessionDetails;
@class SpeakerDetails;
@class Session;
@class Speaker;

@interface IowaCodeCampAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow* window;
    IowaCodeCampViewController *viewController;
    IBOutlet UINavigationController* navController;
    IBOutlet SessionDetails* detailsController;
    IBOutlet SpeakerDetails* speakerDetailsController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet IowaCodeCampViewController *viewController;
@property (nonatomic, retain) SessionDetails* detailsController;
@property (nonatomic, retain) SpeakerDetails* speakerDetailsController;

- (void)sessionJsonFinished;
- (void)showSessionDetailsView:(Session *)session;
- (void)launchSpeakerDetailsView:(Speaker *)speaker;

@end

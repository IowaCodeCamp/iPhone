#import <UIKit/UIKit.h>

@class IowaCodeCampAppDelegate;
@class Session;

@interface SessionDetails : UIViewController {
    Session* selectedSession;  
    IBOutlet UILabel* lblSessionTitle;
    IBOutlet UILabel* lblSpeakerName;
    IBOutlet UILabel* lblSessionTime;
    IBOutlet UITextView* txtSessionDesc;
    IBOutlet UILabel* lblRoom;
    IBOutlet UIImageView* imgSpeaker;
    IBOutlet IowaCodeCampAppDelegate* appDelegate;
}

@property (nonatomic, retain) IowaCodeCampAppDelegate* appDelegate;
@property (nonatomic, retain) Session* selectedSession;
@property (nonatomic, retain) UILabel* lblSessionTitle;
@property (nonatomic, retain) UILabel* lblSpeakerName;
@property (nonatomic, retain) UILabel* lblSessionTime;
@property (nonatomic, retain) UITextView* txtSessionDesc;
@property (nonatomic, retain) UILabel* lblRoom;
@property (nonatomic, retain) UIImageView* imgSpeaker;

- (IBAction) showSpeakerDetails: (id) sender;

@end

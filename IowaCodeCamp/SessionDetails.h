#import <UIKit/UIKit.h>

@class Session;

@interface SessionDetails : UIViewController {
    Session* selectedSession;  
    IBOutlet UILabel* lblSessionTitle;
    IBOutlet UILabel* lblSpeakerName;
    IBOutlet UILabel* lblSessionTime;
    IBOutlet UILabel* lblSessionDesc;
    IBOutlet UIImageView* imgSpeaker;
}

@property (nonatomic, retain) Session* selectedSession;
@property (nonatomic, retain) UILabel* lblSessionTitle;
@property (nonatomic, retain) UILabel* lblSpeakerName;
@property (nonatomic, retain) UILabel* lblSessionTime;
@property (nonatomic, retain) UILabel* lblSessionDesc;
@property (nonatomic, retain) UIImageView* imgSpeaker;

@end

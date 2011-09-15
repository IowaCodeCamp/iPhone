#import <UIKit/UIKit.h>

@class Speaker;

@interface SpeakerDetails : UIViewController {
    Speaker* selectedSpeaker;  
    IBOutlet UILabel* lblSpeakerName;
    IBOutlet UILabel* lblSpeakerUri;
    IBOutlet UILabel* lblSpeakerLocation;
    IBOutlet UIImageView* imgSpeaker;
    IBOutlet UITextView* txtSpeakerBio;
}

@property (nonatomic, retain) Speaker* selectedSpeaker;
@property (nonatomic, retain) UILabel* lblSpeakerName;
@property (nonatomic, retain) UILabel* lblSpeakerUri;
@property (nonatomic, retain) UILabel* lblSpeakerLocation;
@property (nonatomic, retain) UIImageView* imgSpeaker;
@property (nonatomic, retain) UITextView* txtSpeakerBio;

@end

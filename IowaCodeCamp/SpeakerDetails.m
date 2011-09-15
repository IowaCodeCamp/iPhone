#import "SpeakerDetails.h"
#import "AsyncImageDownload.h"
#import "Speaker.h"

@implementation SpeakerDetails
@synthesize selectedSpeaker;
@synthesize lblSpeakerUri;
@synthesize lblSpeakerLocation;
@synthesize lblSpeakerName;
@synthesize imgSpeaker;
@synthesize txtSpeakerBio;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lblSpeakerName.text = [selectedSpeaker name];
    lblSpeakerUri.text = @"http://twitter.com/toranb";
    lblSpeakerLocation.text = @"Des Moines, IA";
    txtSpeakerBio.text = [selectedSpeaker bio];
    
    NSString* imgUrl = [NSString stringWithFormat:@"http://iowacodecamp.com/public/images/speakers/%@", [selectedSpeaker img]];
    
    AsyncImageDownload* asyncImg = [[AsyncImageDownload alloc] init];
    [asyncImg loadImageFromURL:imgUrl :nil :self :nil];
    
    [asyncImg autorelease];
}

- (void) setImageForGivenIndexPath:(UIImage *)img:(NSIndexPath *)indexInfo:(UIImageView *)imgview
{
    imgSpeaker.frame = CGRectMake(5, 43, 90, 117);
    [imgSpeaker setImage:img];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

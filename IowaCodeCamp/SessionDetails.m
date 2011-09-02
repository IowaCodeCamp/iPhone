#import "SessionDetails.h"
#import "AsyncImageDownload.h"
#import "Speaker.h"

@implementation SessionDetails
@synthesize selectedSession;
@synthesize lblSessionDesc;
@synthesize lblSessionTime;
@synthesize lblSpeakerName;
@synthesize lblSessionTitle;
@synthesize imgSpeaker;

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
    
    Speaker* speaker = [selectedSession speaker];
    lblSessionTitle.text = [selectedSession session];
    lblSessionDesc.text = [selectedSession desc];
    lblSessionTime.text = [selectedSession time];
    lblSpeakerName.text = [speaker name];
    
    NSString* imgUrl = [NSString stringWithFormat:@"http://iowacodecamp.com/public/images/speakers/%@", [speaker img]];
    
    AsyncImageDownload* asyncImg = [[AsyncImageDownload alloc] init];
    [asyncImg loadImageFromURL:imgUrl :nil :self :nil];
}

- (void) setImageForGivenIndexPath:(UIImage *)img:(NSIndexPath *)indexInfo:(UIImageView *)imgview
{
    imgSpeaker.frame = CGRectMake(20, 47, 106, 165);
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

#import "IowaCodeCampViewController.h"
#import "SessionService.h"
#import "Session.h"
#import "IowaCodeCampAppDelegate.h"
#import "AddModalDialog.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation IowaCodeCampViewController
@synthesize sessions;
@synthesize groupIndex;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [AddModalDialog buildModalDialogWithTextForView:@"loading" :self];
    
    SessionService* service = [[SessionService alloc] initWithViewController:self];
    [service getListOfSessions];
    
    [service autorelease];
}

- (void) callbackWithListOfSessions:(NSArray *)list {
    [AddModalDialog removeModalDialogForView:self];
    
    [self indexEachSessionByTime:list];
    self.sessions = list;
    
    [appDelegate sessionJsonFinished];
}

- (void) refreshDisplay {
	[sessionsTableView reloadData];
    
    [self dismissModalViewControllerAnimated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {    
    return [groupIndex count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {    
    return [groupIndex objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sessionTime = [groupIndex objectAtIndex:section];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time ==[c] %@", sessionTime];
    NSArray* sessionz = [self.sessions filteredArrayUsingPredicate:predicate];
    
    return [sessionz count];    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Session* obj = [self objForIndexedGroup:indexPath];
    
    [appDelegate showSessionDetailsView:obj];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 16.0; //the actual height value is set in the interface builder option => this is simply a reminder to set it there :)
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
	UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColorFromRGB(0x838E00) colorWithAlphaComponent:0.8];
	headerLabel.font = [UIFont boldSystemFontOfSize:12];
	headerLabel.frame = CGRectMake(0.0, 0.0, 320.0, 16.0);
	headerLabel.text = [NSString stringWithFormat:@" %@", sectionTitle];
    
    [headerLabel autorelease];
    
	return headerLabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SessionDetails"];
    
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SessionDetails"] autorelease];
        
        UIView* detailsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 99)];
        
        UILabel* sessionName = [[UILabel alloc] initWithFrame:CGRectMake(5, -5, 310, 35)];
        sessionName.font = [UIFont boldSystemFontOfSize:14.0];
        sessionName.tag = 16;
        [detailsView addSubview:sessionName];
        [sessionName release];
        
        UILabel* speakerName = [[UILabel alloc] initWithFrame:CGRectMake(5, 24, 310, 15)];
        speakerName.font = [UIFont systemFontOfSize:12.0];
        speakerName.tag = 17;
        speakerName.textColor = [UIColor grayColor];
        [detailsView addSubview:speakerName];
        [speakerName release];
        
        [cell.contentView addSubview:detailsView];
        
        [detailsView release];
	}
    
    NSString *time = [groupIndex objectAtIndex:[indexPath section]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time ==[c] %@", time];
    NSArray* sessionz = [self.sessions filteredArrayUsingPredicate:predicate];
    
    if ([sessionz count] > 0) {
        Session* obj = [sessionz objectAtIndex: [indexPath row]];
        
        UILabel* sessionName = (UILabel*) [cell viewWithTag:16];
        sessionName.text = obj.session;
        
        UILabel* released = (UILabel*) [cell viewWithTag:17];
        released.text = obj.speaker.name;
    }
    
	return cell;  
}

- (Session *) objForIndexedGroup:(NSIndexPath *)indexPath
{
    NSString *time = [groupIndex objectAtIndex:[indexPath section]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time ==[c] %@", time];
    NSArray* sessionz = [self.sessions filteredArrayUsingPredicate:predicate];
    
    return [sessionz objectAtIndex:[indexPath row]];
}

- (void) indexEachSessionByTime:(NSArray *) sessionz
{
    groupIndex = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[sessionz count]; i++){
        NSString* releaseDate = [[sessionz objectAtIndex:i] time];
        if (i > 0) {
            BOOL* alreadyExists = NO;
            for (int z=0; z<[groupIndex count]; z++) {
                NSString* currentReleased = [groupIndex objectAtIndex:z];
                if ([currentReleased isEqualToString:releaseDate]) {
                    alreadyExists = YES;
                    break;
                }
            }
            if (!alreadyExists) {
                [groupIndex addObject:releaseDate]; 
            }
        }else {
            [groupIndex addObject:releaseDate]; 
        }
    } 
}

@end

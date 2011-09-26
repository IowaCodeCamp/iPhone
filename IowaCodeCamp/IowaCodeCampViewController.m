#import "IowaCodeCampViewController.h"
#import "SessionService.h"
#import "Session.h"
#import "IowaCodeCampAppDelegate.h"
#import "AddModalDialog.h"
#import "SessionOrganizer.h"
#import "SpecialSessionIdentifier.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation IowaCodeCampViewController
@synthesize groupIndex;
@synthesize sessions;
@synthesize specialSessionIdentifier;

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
    
    specialSessionIdentifier = [[SpecialSessionIdentifier alloc] init];
    
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
    NSIndexPath *path = [NSIndexPath indexPathForRow:section inSection:section];
    NSArray* sessionz = [self getListOfSessionsWithPredicate:path];
    
    return [sessionz count];    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Session* obj = [self objForIndexedGroup:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([specialSessionIdentifier sessionNameRequiresSpecialTreatment:obj.session]) {
        return;
    }
    
    [appDelegate showSessionDetailsView:obj];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    Session* obj = [self objForIndexedGroup:indexPath];
    
    if ([specialSessionIdentifier sessionNameRequiresSpecialTreatment:obj.session]) {
        return 26.0f;
    }
    
    return 47.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 18.0; //the actual height value is set in the interface builder option => this is simply a reminder to set it there :)
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
	UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColorFromRGB(0x838E00) colorWithAlphaComponent:0.8];
	headerLabel.font = [UIFont boldSystemFontOfSize:14];
	headerLabel.frame = CGRectMake(0.0, 0.0, 320.0, 18.0);
	headerLabel.text = [NSString stringWithFormat:@" %@", sectionTitle];
    
    [headerLabel autorelease];
    
	return headerLabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SessionDetails"];
    
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SessionDetails"] autorelease];
        
        UIView* detailsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 47)];
        
        UILabel* sessionName = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 32)];
        sessionName.font = [UIFont boldSystemFontOfSize:14.0];
        sessionName.tag = 16;
        [detailsView addSubview:sessionName];
        [sessionName release];
        
        UILabel* speakerName = [[UILabel alloc] initWithFrame:CGRectMake(5, 26, 310, 15)];
        speakerName.font = [UIFont systemFontOfSize:12.0];
        speakerName.tag = 17;
        speakerName.textColor = [UIColor grayColor];
        [detailsView addSubview:speakerName];
        [speakerName release];
        
        [cell.contentView addSubview:detailsView];
        
        [detailsView release];
	}
    
    NSArray* sessionz = [self getListOfSessionsWithPredicate:indexPath];
    
    if ([sessionz count] > 0) {
        Session* obj = [sessionz objectAtIndex: [indexPath row]];
        
        UILabel* sessionName = (UILabel*) [cell viewWithTag:16];
        sessionName.text = obj.session;
        
        if ([specialSessionIdentifier sessionNameRequiresSpecialTreatment:obj.session]) {
            sessionName.frame = CGRectMake(5,0,310,26);
        }
        
        UILabel* released = (UILabel*) [cell viewWithTag:17];
        released.text = obj.speaker.name;
    }
    
	return cell;  
}

- (Session *) objForIndexedGroup:(NSIndexPath *)indexPath
{
    NSArray* sessionz = [self getListOfSessionsWithPredicate:indexPath];
    
    return [sessionz objectAtIndex:[indexPath row]];
}

- (NSArray *) getListOfSessionsWithPredicate:(NSIndexPath *)indexPath {
    NSString *time = [groupIndex objectAtIndex:[indexPath section]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time ==[c] %@", time];
    NSArray* sessionz = [self.sessions filteredArrayUsingPredicate:predicate];
    
    return sessionz;
}

- (void) indexEachSessionByTime:(NSArray *) sessionz
{
    SessionOrganizer* organizer = [[[SessionOrganizer alloc] init] autorelease];
    NSArray* sessionList = [organizer sortAndGroupSessions:sessionz];
    groupIndex = [[NSArray alloc] initWithArray:sessionList];
}

@end

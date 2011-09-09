#import "IowaCodeCampViewController.h"
#import "SessionService.h"
#import "Session.h"
#import "IowaCodeCampAppDelegate.h"

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
    SessionService* service = [[SessionService alloc] initWithViewController:self];
    [service getListOfSessions];
}

- (void) callbackWithListOfSessions:(NSArray *)list {
    [self indexEachSessionByTime:list];
    self.sessions = list;
    
    [appDelegate newReleasesJsonFinished];
}

- (void) refreshDisplay {
	[newReleasesTableView reloadData];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SessionDetails"];
    
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
        
        UILabel* sessionName = [cell viewWithTag:16];
        sessionName.text = obj.session;
        
        UILabel* released = [cell viewWithTag:17];
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

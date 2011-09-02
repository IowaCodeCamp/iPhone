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
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//table view below
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
        
//        UIView* detailsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 99)];
//        //detailsView.tag = 14;
//        
//        UILabel* movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(75, 6, 210, 35)];
//        movieTitle.font = [UIFont boldSystemFontOfSize:21.0];
//        movieTitle.tag = 16;
//        [detailsView addSubview:movieTitle];
//        [movieTitle release];
//        
//        [cell.contentView addSubview:detailsView];
//        
//        [detailsView release];
	}
    
    NSString *time = [groupIndex objectAtIndex:[indexPath section]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time ==[c] %@", time];
    NSArray* sessionz = [self.sessions filteredArrayUsingPredicate:predicate];
    
    if ([sessionz count] > 0) {
        Session* obj = [sessionz objectAtIndex: [indexPath row]];
        NSString* session = [[NSString alloc] initWithFormat:@"%@", obj.session];
        cell.text = session;
        
        //UILabel* movieTitle = [cell viewWithTag:16];
        //movieTitle.text = time;
        
        //[movieTitle release];
    }
    
	return cell;  
}

- (Session *) objForIndexPath:(NSIndexPath *)indexPath
{
        return [sessions objectAtIndex:[indexPath row]];
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

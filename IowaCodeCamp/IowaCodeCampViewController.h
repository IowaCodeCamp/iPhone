#import <UIKit/UIKit.h>

@class IowaCodeCampAppDelegate;
@class Session;
@class SpecialSessionIdentifier;

@interface IowaCodeCampViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    NSArray* sessions;
    NSArray* groupIndex;
    IBOutlet UITableView* sessionsTableView;
    IBOutlet IowaCodeCampAppDelegate* appDelegate;
    SpecialSessionIdentifier* specialSessionIdentifier;
}

@property (nonatomic, retain) NSArray* sessions;
@property (nonatomic, retain) NSArray* groupIndex;
@property (nonatomic, retain) SpecialSessionIdentifier* specialSessionIdentifier;

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (Session *) objForIndexedGroup:(NSIndexPath *)indexPath;
- (void) callbackWithListOfSessions:(NSArray *)list;
- (void) refreshDisplay;
- (void) indexEachSessionByTime:(NSArray *) sessionz;
- (NSArray *) getListOfSessionsWithPredicate:(NSIndexPath *)indexPath;

@end

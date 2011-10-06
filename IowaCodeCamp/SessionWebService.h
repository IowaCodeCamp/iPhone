#import <Foundation/Foundation.h>

@class SessionService;

@interface SessionWebService : NSObject {
    NSMutableData* responseData;
    SessionService* service;
}

@property (nonatomic, retain) SessionService* service;
@property (nonatomic, retain) NSMutableData* responseData;

- (id) initWithSessionService:(SessionService *)service;

- (void) getListOfSessions;

@end

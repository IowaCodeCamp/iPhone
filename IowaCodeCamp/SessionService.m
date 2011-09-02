#import "SessionService.h"
#import "SessionWebService.h"
#import "SessionDeserializer.h"

@implementation SessionService
@synthesize viewController;
@synthesize deserializer;
@synthesize service;

- (id) init
{
    return [self initWithViewController:nil];
}

- (id) initWithViewController:(UIViewController *)viewController
{
    if (self == [super init])
    {
        self.service = [[SessionWebService alloc] initWithSessionService:self];
        self.deserializer = [[SessionDeserializer alloc] init];
        self.viewController = viewController;
    }
    return self;
}

- (void) getListOfSessions {
    [service getListOfSessions];
}

- (void) callbackWithListOfSessions:(NSString *)json {
    NSArray* sessions = [deserializer parseJsonAndReturnSessions:json];
    [viewController callbackWithListOfSessions:sessions];
}

- (void) dealloc {
    [viewController release];
    [deserializer release];
    [super dealloc];
}

@end

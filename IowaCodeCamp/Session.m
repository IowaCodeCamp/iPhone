#import "Session.h"


@implementation Session
@synthesize time;
@synthesize session;
@synthesize desc;
@synthesize room;
@synthesize speaker;

- (NSString *)description {
    return [NSString stringWithFormat:@"time = %@, desc = %@, session = %@", self.time, self.desc, self.session];
}

- (void) dealloc {
    [time release];
    [session release];
    [desc release];
    [speaker release];
    [room release];
    [super dealloc];
}

@end

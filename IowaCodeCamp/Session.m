#import "Session.h"
#import "SessionDateTransformer.h"

@implementation Session
@synthesize time;
@synthesize session;
@synthesize desc;
@synthesize room;
@synthesize speaker;

- (NSString *)description {
    return [NSString stringWithFormat:@"time = %@, desc = %@, session = %@", self.time, self.desc, self.session];
}

- (NSComparisonResult)compareSessionStartTime:(Session *)obj {
    SessionDateTransformer* transformer = [[SessionDateTransformer alloc] init];
    NSDate* first = [transformer transformSessionTimeToDate:time];
    NSDate* last = [transformer transformSessionTimeToDate:obj.time];
    
    [transformer release];
    
    return [first compare:last];
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

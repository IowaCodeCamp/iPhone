#import "SessionOrganizer.h"
#import "Session.h"

@implementation SessionOrganizer

- (NSArray *) sortAndGroupSessions:(NSArray *)sessionz
{
    NSArray* sorted = [sessionz sortedArrayUsingSelector:@selector(compareSessionStartTime:)];
    NSMutableArray* tmpGroupIndex = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[sorted count]; i++){
        NSString* releaseDate = [[sorted objectAtIndex:i] time];
        if (i > 0) {
            BOOL* alreadyExists = NO;
            for (int z=0; z<[tmpGroupIndex count]; z++) {
                NSString* currentReleased = [tmpGroupIndex objectAtIndex:z];
                if ([currentReleased isEqualToString:releaseDate]) {
                    alreadyExists = YES;
                    break;
                }
            }
            if (!alreadyExists) {
                [tmpGroupIndex addObject:releaseDate]; 
            }
        }else {
            [tmpGroupIndex addObject:releaseDate]; 
        }
    } 
    
    [tmpGroupIndex autorelease];
    
    return tmpGroupIndex;
}

@end

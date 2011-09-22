#import "SessionOrganizer.h"

@implementation SessionOrganizer

- (NSArray *) sortAndGroupSessions:(NSArray *)sessionz
{
    NSMutableArray* tmpGroupIndex = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[sessionz count]; i++){
        NSString* releaseDate = [[sessionz objectAtIndex:i] time];
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

#import "Speaker.h"

@implementation Speaker
@synthesize name;
@synthesize bio;
@synthesize img;
@synthesize web;
@synthesize location;

- (NSString *)description {
    return [NSString stringWithFormat:@"name = %@, bio = %@, img = %@", self.name, self.bio, self.img];
}

- (void) dealloc {
    [name release];
    [bio release];
    [img release];
    [web release];
    [location release];
    [super dealloc];
}

@end

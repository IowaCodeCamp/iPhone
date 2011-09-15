#import "Speaker.h"

@implementation Speaker
@synthesize name;
@synthesize title;
@synthesize bio;
@synthesize img;
@synthesize web;
@synthesize location;

- (NSString *)description {
    return [NSString stringWithFormat:@"name = %@, title = %@, bio = %@, img = %@", self.name, self.title, self.bio, self.img];
}

- (void) dealloc {
    [name release];
    [title release];
    [bio release];
    [img release];
    [web release];
    [location release];
    [super dealloc];
}

@end

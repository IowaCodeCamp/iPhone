#import "Speaker.h"

@implementation Speaker
@synthesize name;
@synthesize title;
@synthesize bio;
@synthesize img;

- (NSString *)description {
    return [NSString stringWithFormat:@"name = %@, title = %@, bio = %@, img = %@", self.name, self.title, self.bio, self.img];
}

- (void) dealloc {
    [name release];
    [title release];
    [bio release];
    [img release];
    [super dealloc];
}

@end

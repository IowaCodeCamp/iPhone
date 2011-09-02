#import "SessionDeserializer.h"
#import "Session.h"
#import "Speaker.h"

@implementation SessionDeserializer

- (NSArray *)parseJsonAndReturnSessions:(NSString *)html {
    NSArray* json = [html JSONValue];
    
    NSArray* items = [json valueForKeyPath:@"d.data"];
    
    NSMutableArray* sessions = [NSMutableArray array];
    for (NSDictionary *item in items) {
        Session* session = [[Session alloc] init];
        
        [session setSession:[item objectForKey:@"session"]];
        [session setTime:[item objectForKey:@"time"]];
        [session setDesc:[item objectForKey:@"desc"]];
        
        NSDictionary *spkr = [item objectForKey:@"speaker"];
        NSString* name = [spkr objectForKey:@"name"];
        NSString* title = [spkr objectForKey:@"title"];
        NSString* bio = [spkr objectForKey:@"bio"];
        NSString* img = [spkr objectForKey:@"img"];
        
        Speaker* speaker = [[Speaker alloc] init];
        [speaker setName:name];
        [speaker setTitle:title];
        [speaker setBio:bio];
        [speaker setImg:img];
        
        [session setSpeaker:speaker];
        
        [sessions addObject:session];
        
        [speaker release];
        [session release];
    }
    
    return sessions;
}

@end

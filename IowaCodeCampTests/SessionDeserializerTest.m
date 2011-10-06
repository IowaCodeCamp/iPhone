#import "SessionDeserializerTest.h"
#import "SessionDeserializer.h"
#import "Session.h"

@implementation SessionDeserializerTest

- (void)testExampleWithInvalidHtml
{
    SessionDeserializer* sut = [[SessionDeserializer alloc] init];
    
    NSString* json = @"{\"d\":{\"success\":true,\"msg\":null,\"data\":[{\"session\":\"First Session\",\"time\":\"9:00 AM - 10:30 AM\",\"desc\":\"very fun session\",\"speaker\":{\"name\":\"Chris Missal\",\"title\":\"Rockstar\",\"bio\":\"my hero\"}},{\"session\":\"Next Session\",\"time\":\"9:00 AM - 10:30 AM\",\"desc\":\"not a good session\",\"speaker\":{\"name\":\"Toran Billups\",\"title\":\"Dude\",\"bio\":\"good kid\"}}]}}";
    NSArray* sessions = [sut parseJsonAndReturnSessions:json];
    
    Session* firstSession = [sessions objectAtIndex: 1];
    NSString* time = [firstSession time];
    NSString* session = [firstSession session];
    NSString* desc = [firstSession desc];
    
    STAssertTrue([time isEqual:@"9:00 AM - 10:30 AM"], @"failed to parse time from session json");
    STAssertTrue([session isEqual:@"First Session"], @"failed to parse session from session json");
    STAssertTrue([desc isEqual:@"very fun session"], @"failed to parse desc from session json");
    
    [sut release];
}

@end


#import "SessionWebService.h"
#import "SessionService.h"
#import "JSON.h"

@implementation SessionWebService
@synthesize service;
@synthesize responseData;

- (id) init
{
    return [self initWithSessionService:nil];
}

- (id) initWithSessionService:(SessionService *)svc
{
    if (self == [super init])
    {
        responseData = [NSMutableData new];
        self.service = svc;
    }
    return self;
}

- (void) getListOfSessions
{
    NSURL *url = [NSURL URLWithString:@"http://toranbillups.com/content/examples/icc.html"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod:@"GET"];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [connection release];
    
    NSString* responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSArray* json = [responseString JSONValue];
    
    if (json != NULL) {
        [service callbackWithListOfSessions:responseString];
    }
    else {
        [service callbackWithListOfSessions:nil];
    }
    
    [responseString release];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

- (void) dealloc {
    [service release];
    [responseData release];
    [super dealloc];
}

@end

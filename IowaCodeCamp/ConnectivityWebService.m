#import "ConnectivityWebService.h"
#import "AddModalDialog.h"

@implementation ConnectivityWebService
@synthesize appDelegate;
@synthesize responseData;

- (id) init
{
    return [self initWithAppDelegate:nil];
}

- (id) initWithAppDelegate:(IowaCodeCampAppDelegate *)apDelegate
{
    if (self == [super init])
    {
        responseData = [NSMutableData new];
        self.appDelegate = apDelegate;
    }
    return self;
}

- (void) verifyConnectivity
{
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod:@"GET"];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
	[responseData release];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {    
	[responseData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [AddModalDialog showNoticeForNoConnectivity];
}

- (void) dealloc {
    [appDelegate release];
    [super dealloc];
}

@end

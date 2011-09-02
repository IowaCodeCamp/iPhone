#import "AsyncImageDownload.h"

@implementation AsyncImageDownload
@synthesize indexPath;
@synthesize viewController;
@synthesize data;
@synthesize connection;
@synthesize imgview;

- (void) loadImageFromURL:(NSString *)urlStr:(NSIndexPath *)indexInfo:(UIViewController *)vwController:(UIImageView *)imgview
{
    self.viewController = vwController;
    self.indexPath = indexInfo;
    self.imgview = imgview;
    if (connection!=nil) { [connection release]; }
    if (data!=nil) { [data release]; }
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
    connection = [[NSURLConnection alloc]
                  initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection
    didReceiveData:(NSData *)incrementalData {
    if (data==nil) {
        data =
        [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    
    [connection release];
    connection=nil;
    
    UIImage* img = [UIImage imageWithData:data];
    
    [data release];
    data=nil;
    
    [viewController setImageForGivenIndexPath:img :self.indexPath :self.imgview];
}

- (void)dealloc {
    [connection cancel];
    [connection release];
    [data release];
    [viewController release];
    [indexPath release];
    [imgview release];
    [super dealloc];
}

@end

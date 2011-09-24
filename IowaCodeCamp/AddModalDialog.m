#import "AddModalDialog.h"

@implementation AddModalDialog

+ (void)buildModalDialogWithTextForView:(NSString *)text:(UIViewController *)controller
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    UIView* _hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 450)];
    _hudView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _hudView.clipsToBounds = YES;
    
    UIActivityIndicatorView* _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.frame = CGRectMake(140, 135, _activityIndicatorView.bounds.size.width, _activityIndicatorView.bounds.size.height);
    [_hudView addSubview:_activityIndicatorView];
    [_activityIndicatorView startAnimating];
    [_activityIndicatorView release]; // _hudView owns this now
    
    UILabel* _captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 190, 250, 25)];
    _captionLabel.backgroundColor = [UIColor clearColor];
    _captionLabel.textColor = [UIColor whiteColor];
    _captionLabel.font = [UIFont boldSystemFontOfSize:21.0];
    _captionLabel.adjustsFontSizeToFitWidth = NO;
    _captionLabel.textAlignment = UITextAlignmentCenter;
    _captionLabel.text = text;
    [_hudView addSubview:_captionLabel];
    [_captionLabel release]; // _hudView owns this now
    
    [controller.view addSubview:_hudView];
    [_hudView release]; // the controller's view owns this now
}

+ (void)removeModalDialogForView:(UIViewController *)controller
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSUInteger count = [controller.view.subviews count];
    [[controller.view.subviews objectAtIndex:(count - 1)] removeFromSuperview];
}

+ (void)removeLoadingImagesForView:(UIViewController *)controller
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSUInteger count = [controller.view.subviews count];
    [[controller.view.subviews objectAtIndex:(count - 1)] removeFromSuperview];
    
    UIView* _hudViewx = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 450)];
    _hudViewx.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _hudViewx.clipsToBounds = YES;
    
    UIImageView* bkImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    UIImage* bkgimg = [UIImage imageNamed:@"loading.png"];
    [bkImgView setImage:bkgimg];
    [_hudViewx addSubview:bkImgView];
    [bkImgView release];
    
    [controller.view addSubview:_hudViewx];
}

+ (void)showNoticeForNoConnectivity
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No network connection" message:@"This application requires some form of internet connectivity to function"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
    [alert release]; 
}

- (void)dealloc {
    [super dealloc];
}

@end

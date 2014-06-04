//
//  ViewFacebook.m
//  AloneMakMak
//
//  Created by saranpol on 6/5/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "ViewFacebook.h"
#import "API.h"


@implementation ViewFacebook

@synthesize mWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    API *a = [API getAPI];
    NSString *s = [NSString stringWithFormat:@"http://labs.bkklive.com/demo/movie/api/view/%@", a.mImageID];
    [mWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:s]]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *c = webView.request.URL.absoluteString;
    NSLog(@"current url %@", c);
    
    if ([c rangeOfString:@"http://labs.bkklive.com/demo/movie/api/thank"].location == NSNotFound) {
    } else {
        [self performSegueWithIdentifier:@"GotoViewThank2" sender:nil];
    }
}


@end

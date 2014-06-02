//
//  ViewThank.m
//  AloneMakMak
//
//  Created by saranpol on 6/3/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "ViewThank.h"



@implementation ViewThank

@synthesize mImageHead;
@synthesize mLabelThank;

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
    
    [mLabelThank setFont:[UIFont fontWithName:@"DBSilomX" size:mLabelThank.font.pointSize]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self performSelector:@selector(animateHead) withObject:nil afterDelay:0.1];
}

- (void)animateHead {
    [UIView animateKeyframesWithDuration:0.8
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionAutoreverse | UIViewKeyframeAnimationOptionRepeat
                              animations:^{
                                  //mImageHead.transform = CGAffineTransformScale(mImageHead.transform, 0.7, 0.7);
                                  CGRect r = mImageHead.frame;
                                  r.origin.x += r.size.width*0.1/2.0;
                                  r.origin.y += r.size.height*0.1/2.0;
                                  r.size.width *= 0.9;
                                  r.size.height *= 0.9;
                                  [mImageHead setFrame:r];
                              }completion:^(BOOL finished){
                                  
                              }];
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
    [[[self presentingViewController] presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end

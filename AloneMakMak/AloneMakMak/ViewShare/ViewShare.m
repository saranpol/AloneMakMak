//
//  ViewShare.m
//  AloneMakMak
//
//  Created by saranpol on 6/3/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "ViewShare.h"
#import "API.h"

@implementation ViewShare

@synthesize mImageView;
@synthesize mImageHead;

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
    API *a = [API getAPI];
    [mImageView setImage:a.mImageCurrent];
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

//- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application {
////    if ([self isWhatsApplication:application]) {
////        NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tmptmpimg.wai"];
////        [UIImageJPEGRepresentation(_img, 1.0) writeToFile:savePath atomically:YES];
////        controller.URL = [NSURL fileURLWithPath:savePath];
////        controller.UTI = @"net.whatsapp.image";
////    }
//}
//
//- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
//
//}

- (IBAction)clickShare:(id)sender {
    //    UIImage *image = [self saveImage];
    //    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tmp_img.jpg"];
    //    [UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
    //
    //    self.mDoc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
    //    mDoc.delegate = self;
    //    [mDoc presentOptionsMenuFromRect:CGRectZero inView:self.view animated:YES];
    API *a = [API getAPI];
    UIImage *image = a.mImageCurrent;
    
    NSArray* dataToShare = @[image];  // ...or whatever pieces of data you want to share.
    
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{
        
    }];
    
    //    NSArray *activityItems = @[image];
    //    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    //    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo];
    //    [self presentViewController:activityVC animated:TRUE completion:nil];
    
}

- (IBAction)clickEmail:(id)sender {
    
}

- (void)clickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

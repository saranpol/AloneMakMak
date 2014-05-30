//
//  ViewOutput.m
//  AloneMakMak
//
//  Created by saranpol on 5/31/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "ViewOutput.h"
#import "API.h"

@implementation ViewOutput

@synthesize mImageView;
@synthesize mViewContent;
//@synthesize mDoc;

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
    
    [self.mImageView setImage:a.mImageCurrent];

    if(a.mViewFrame)
        [self.mViewContent addSubview:a.mViewFrame];
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

- (UIImage*)saveImage {
    UIImage* image;
    UIGraphicsBeginImageContext(mViewContent.frame.size);
    [mViewContent.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}

- (IBAction)clickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickSave:(id)sender {
    [self saveImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}


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

    UIImage *image = [self saveImage];
    
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


@end

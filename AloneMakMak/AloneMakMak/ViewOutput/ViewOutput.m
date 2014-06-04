//
//  ViewOutput.m
//  AloneMakMak
//
//  Created by saranpol on 5/31/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "ViewOutput.h"
#import "API.h"
#import "AMMViewController.h"

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

- (UIImage*)resize:(UIImage*)image {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1200, 900), NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, 1200, 900)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)saveImage {
    UIImage* image;
    //UIGraphicsBeginImageContext(mViewContent.frame.size);
    UIGraphicsBeginImageContextWithOptions(mViewContent.bounds.size, self.view.opaque, 0.0);
    [mViewContent.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    image = [self resize:image];
    
    return image;
}

- (IBAction)clickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        API *a = [API getAPI];
        [a.mVC clickTakePhoto:nil];
    }];
}

- (IBAction)clickSave:(id)sender {
    API *a = [API getAPI];
    a.mImageCurrent = [self saveImage];
    [self dismissViewControllerAnimated:YES completion:^{
        [a.mVC performSegueWithIdentifier:@"GotoViewShare" sender:nil];
    }];
}





@end

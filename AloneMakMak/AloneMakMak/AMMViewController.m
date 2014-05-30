//
//  AMMViewController.m
//  AloneMakMak
//
//  Created by saranpol on 5/31/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "AMMViewController.h"
#import "API.h"
#import "UIImagePickerCustom.h"

@implementation AMMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickTakePhoto:(id)sender {
    UIImagePickerCustom *imagePickerController = [[UIImagePickerCustom alloc] init];
    if ([UIImagePickerCustom isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setCameraDevice:UIImagePickerControllerCameraDeviceFront];
    }else{
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [imagePickerController setDelegate:self];
    
    
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (IBAction)clickLibrary:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePickerController setDelegate:self];
    [self presentViewController:imagePickerController animated:YES completion:nil];
    API *a = [API getAPI];
    a.mViewFrame = nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    API *a = [API getAPI];
    [a savePhoto:info];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"GotoViewOutput" sender:self];
    }];
}

@end

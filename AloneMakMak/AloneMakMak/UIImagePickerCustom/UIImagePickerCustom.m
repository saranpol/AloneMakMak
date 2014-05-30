//
//  UIImagePickerCustom.m
//  AloneMakMak
//
//  Created by saranpol on 5/31/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "UIImagePickerCustom.h"
#import "ViewUtil.h"
#import "API.h"

@implementation UIImagePickerCustom

@synthesize mMotionManager;
@synthesize mQueue;
@synthesize mIsInPreviewMode;

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    API *a = [API getAPI];
    a.mViewFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    
    UIImageView *f = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frame_test.png"]];
    [a.mViewFrame addSubview:f];
    [self.view addSubview:a.mViewFrame];
    [a.mViewFrame setUserInteractionEnabled:NO];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cameraChanged:)
                                                 name:@"AVCaptureDeviceDidStartRunningNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cameraTaken:)
                                                 name:@"_UIImagePickerControllerUserDidCaptureItem"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cameraContinue:)
                                                 name:@"_UIImagePickerControllerUserDidRejectItem"
                                               object:nil];

    
    
    
    self.mMotionManager = [[CMMotionManager alloc] init];
    mMotionManager.accelerometerUpdateInterval  = 1.0/10.0; // Update at 10Hz
    if (mMotionManager.gyroAvailable) {
        self.mQueue = [NSOperationQueue currentQueue];
        [mMotionManager startGyroUpdatesToQueue:mQueue
                                   withHandler: ^ (CMGyroData *gyroData, NSError *error) {
                                       CMRotationRate rotate = gyroData.rotationRate;
                                       //NSLog(@"%f %f %f", rotate.x, rotate.y, rotate.z);
                                       if(!mIsInPreviewMode){
                                           float factor = 5.0;
                                           if([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
                                               factor *= -1;
                                           
                                           float x = a.mViewFrame.frame.origin.x+rotate.x*factor;
                                           
                                           if(x > 300)
                                               x = 300;
                                           if(x < -300)
                                               x = -300;
                                           [ViewUtil setFrame:a.mViewFrame x:x];
                                       }
                                   }];
        
    }
    
//    if (mMotionManager.accelerometerAvailable) {
//        self.mQueue = [NSOperationQueue currentQueue];
//        [mMotionManager startAccelerometerUpdatesToQueue:mQueue
//                                            withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
//                                                CMAcceleration acceleration = accelerometerData.acceleration;
//                                                [ViewUtil setFrame:mViewFrame x:mViewFrame.frame.origin.x+acceleration.x];
//                                            }];
//        
//    }
    
}

- (void)cameraTaken:(NSNotification *)notification {
    self.mIsInPreviewMode = YES;
}
- (void)cameraContinue:(NSNotification *)notification {
    self.mIsInPreviewMode = NO;
}

- (void)cameraChanged:(NSNotification *)notification
{
    if(self.cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        self.cameraViewTransform = CGAffineTransformIdentity;
        self.cameraViewTransform = CGAffineTransformScale(self.cameraViewTransform, 1, -1);
    } else {
        self.cameraViewTransform = CGAffineTransformIdentity;
    }
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

@end

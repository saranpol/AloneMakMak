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
@synthesize mGesture;

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

- (void)clickCapture {
    [mMotionManager stopGyroUpdates];
    self.mIsInPreviewMode = YES;
    [self takePicture];
}

- (void)clickFlip {
    if(self.cameraDevice == UIImagePickerControllerCameraDeviceFront)
        [self setCameraDevice:UIImagePickerControllerCameraDeviceRear];
    else
        [self setCameraDevice:UIImagePickerControllerCameraDeviceFront];
}

- (void)clickBack {
    [mMotionManager stopGyroUpdates];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)panFrame:(UIPanGestureRecognizer*)g {
    CGPoint p = [g locationInView:self.view];
    API *a = [API getAPI];

    float dx = 0;
    static float oldx = 0;
    if(g.state == UIGestureRecognizerStateBegan){
        oldx = p.x;
    }
    dx = p.x - oldx;
    oldx = p.x;

    float x = a.mViewFrame.frame.origin.x+dx;
    if(x > 2728/2)
        x = 2728/2;
    if(x < -2728/2+1024)
        x = -2728/2+1024;
    [ViewUtil setFrame:a.mViewFrame x:x];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    API *a = [API getAPI];
    a.mViewFrame = [[UIView alloc] initWithFrame:CGRectMake(600, 0, 768, 1024)];
    
    UIImageView *f = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frame.png"]];
    [f setFrame:CGRectMake(-2728/2, 0, 2728, 768)];
    [a.mViewFrame addSubview:f];
    [self.view addSubview:a.mViewFrame];
    [a.mViewFrame setUserInteractionEnabled:NO];
    
    // Pan
    self.mGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFrame:)];
    [self.view  addGestureRecognizer:mGesture];
    
    
    UIButton *buttonCapture = [[UIButton alloc] initWithFrame:CGRectMake(910, 660, 105, 112)];
    [buttonCapture setAlpha:0.8];
    [buttonCapture addTarget:self action:@selector(clickCapture) forControlEvents:UIControlEventTouchUpInside];
    [buttonCapture setImage:[UIImage imageNamed:@"intro-btnTakePhoto.png"] forState:UIControlStateNormal];
    [self.view addSubview:buttonCapture];
    
    UIButton *buttonFlip = [[UIButton alloc] initWithFrame:CGRectMake(120, 660, 105, 112)];
    [buttonFlip setAlpha:0.8];
    [buttonFlip addTarget:self action:@selector(clickFlip) forControlEvents:UIControlEventTouchUpInside];
    [buttonFlip setImage:[UIImage imageNamed:@"intro-btnChangeCam.png"] forState:UIControlStateNormal];
    [self.view addSubview:buttonFlip];

    UIButton *buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(10, 660, 105, 112)];
    [buttonBack setAlpha:0.8];
    [buttonBack addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [buttonBack setImage:[UIImage imageNamed:@"share-btnBack.png"] forState:UIControlStateNormal];
    [self.view addSubview:buttonBack];

    
    
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

//    for(UIView *v in self.view.subviews){
//        BOOL setHidden = YES;
//        if(setHidden){
//            setHidden = NO;
//            for(UIView *v2 in v.subviews){
//                NSLog(@"v2 %@", v2);
//                if(v2.frame.size.height == 768)
//                    [v sendSubviewToBack:v2];
//            }
//        }
//    }
    
    
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
                                           
                                           if(x > 2728/2)
                                               x = 2728/2;
                                           if(x < -2728/2+1024)
                                               x = -2728/2+1024;
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

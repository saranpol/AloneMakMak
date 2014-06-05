//
//  UIImagePickerCustom.h
//  AloneMakMak
//
//  Created by saranpol on 5/31/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface UIImagePickerCustom : UIImagePickerController <UIAccelerometerDelegate>

@property (nonatomic, strong) CMMotionManager *mMotionManager;
@property (nonatomic, strong) NSOperationQueue *mQueue;
@property (nonatomic, assign) BOOL mIsInPreviewMode;
@property (nonatomic, strong) UIPanGestureRecognizer *mGesture;
@property (nonatomic, strong) UIImageView *mImageFrame;
@property (nonatomic, assign) NSInteger mImageID;
@end

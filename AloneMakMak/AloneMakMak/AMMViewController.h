//
//  AMMViewController.h
//  AloneMakMak
//
//  Created by saranpol on 5/31/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMMViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *mImageHead;

- (IBAction)clickTakePhoto:(id)sender;
- (IBAction)clickLibrary:(id)sender;

@end

//
//  ViewShare.h
//  AloneMakMak
//
//  Created by saranpol on 6/3/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewShare : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *mImageView;
@property (nonatomic, weak) IBOutlet UIImageView *mImageHead;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *mViewIndicator;

- (IBAction)clickShare:(id)sender;
- (IBAction)clickEmail:(id)sender;
- (IBAction)clickBack:(id)sender;

@end

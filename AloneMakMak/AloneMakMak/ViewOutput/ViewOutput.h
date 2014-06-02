//
//  ViewOutput.h
//  AloneMakMak
//
//  Created by saranpol on 5/31/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewOutput : UIViewController <UIDocumentInteractionControllerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *mImageView;
@property (nonatomic, weak) IBOutlet UIView *mViewContent;
//@property (nonatomic, strong) UIDocumentInteractionController *mDoc;

- (IBAction)clickBack:(id)sender;
- (IBAction)clickSave:(id)sender;


@end

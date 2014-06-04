//
//  ViewFacebook.h
//  AloneMakMak
//
//  Created by saranpol on 6/5/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFacebook : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *mWebView;

- (IBAction)clickBack:(id)sender;

@end

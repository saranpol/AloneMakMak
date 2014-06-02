//
//  ViewSendEmail.h
//  AloneMakMak
//
//  Created by saranpol on 6/3/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewSendEmail : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *mTextField;

- (IBAction)clickBack:(id)sender;
- (IBAction)clickSend:(id)sender;

@end

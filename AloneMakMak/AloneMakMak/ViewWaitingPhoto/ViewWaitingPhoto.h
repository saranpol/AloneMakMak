//
//  ViewWaitingPhoto.h
//  AloneMakMak
//
//  Created by saranpol on 6/15/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewWaitingPhoto : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *mTableView;

- (IBAction)clickBack:(id)sender;

@end

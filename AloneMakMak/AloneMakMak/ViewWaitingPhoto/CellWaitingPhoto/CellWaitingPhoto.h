//
//  CellWaitingPhoto.h
//  AloneMakMak
//
//  Created by saranpol on 6/15/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellWaitingPhoto : UITableViewCell


@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *mLoading;
@property (nonatomic, weak) IBOutlet UIButton *mButtonDelete;
@property (nonatomic, weak) IBOutlet UIButton *mButtonSend;

@property (nonatomic, weak) IBOutlet UIImageView *mImage;
@property (nonatomic, weak) IBOutlet UILabel *mEmail;
@property (nonatomic, assign) NSInteger mIndex;
@property (nonatomic, weak) UITableView *mTable;

- (IBAction)clickDelete:(id)sender;
- (IBAction)clickSend:(id)sender;


@end

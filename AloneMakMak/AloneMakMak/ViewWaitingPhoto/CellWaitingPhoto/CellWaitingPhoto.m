//
//  CellWaitingPhoto.m
//  AloneMakMak
//
//  Created by saranpol on 6/15/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "CellWaitingPhoto.h"
#import "API.h"

@implementation CellWaitingPhoto

@synthesize mImage;
@synthesize mEmail;
@synthesize mIndex;
@synthesize mTable;
@synthesize mLoading;
@synthesize mButtonDelete;
@synthesize mButtonSend;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickDelete:(id)sender {
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    [v show];
}

- (void)deleteThisRow {
    API *a = [API getAPI];
    NSMutableArray *saveArray = [a getObject:M_SAVE_PHOTO_EMAIL];
    [saveArray removeObjectAtIndex:mIndex];
    [mTable reloadData];
    [a saveObject:saveArray forKey:M_SAVE_PHOTO_EMAIL];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1){
        [self deleteThisRow];
    }
}

- (void)showError {
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [v show];
}

- (IBAction)clickSend:(id)sender {
    NSLog(@"Send");
    [mButtonDelete setEnabled:NO];
    [mButtonSend setEnabled:NO];
    [mLoading setHidden:NO];
    API *a = [API getAPI];
    [a api_upload:mImage.image
            email:mEmail.text
          success:^(id JSON){
              NSDictionary *json = (NSDictionary*)JSON;
              NSLog(@"%@", json);
              if(json){
                  NSNumber *success = [json objectForKey:@"success"];
                  if(success && [success integerValue] > 0){
                      [self deleteThisRow];
                  }
              }
              [mButtonDelete setEnabled:YES];
              [mButtonSend setEnabled:YES];
              [mLoading setHidden:YES];

          }failure:^(NSError *failure){
              NSLog(@"errorxxx %@", failure);
              [mButtonDelete setEnabled:YES];
              [mButtonSend setEnabled:YES];
              [mLoading setHidden:YES];
              [self showError];
          }];
}


@end

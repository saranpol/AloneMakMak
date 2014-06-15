//
//  ViewWaitingPhoto.m
//  AloneMakMak
//
//  Created by saranpol on 6/15/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "ViewWaitingPhoto.h"
#import "API.h"
#import "CellWaitingPhoto.h"

@implementation ViewWaitingPhoto

@synthesize mTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    API *a = [API getAPI];
    NSMutableArray *saveArray = [a getObject:M_SAVE_PHOTO_EMAIL];
    return (saveArray) ? [saveArray count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellWaitingPhoto *cell = [tableView dequeueReusableCellWithIdentifier:@"CellWaitingPhoto" forIndexPath:indexPath];
    API *a = [API getAPI];
    NSMutableArray *saveArray = [a getObject:M_SAVE_PHOTO_EMAIL];
    NSDictionary *d = [saveArray objectAtIndex:indexPath.row];
    cell.mIndex = indexPath.row;
    cell.mTable = mTableView;
    
    [cell.mEmail setText:[d objectForKey:@"Email"]];
    [cell.mImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:[d objectForKey:@"ImagePath"]]]];
    
    return cell;
}


@end

//
//  ViewSendEmail.m
//  AloneMakMak
//
//  Created by saranpol on 6/3/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "ViewSendEmail.h"
#import "API.h"

@implementation ViewSendEmail

@synthesize mTextField;
@synthesize mViewIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [mViewIndicator setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [mTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showError {
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [v show];
    [mViewIndicator setHidden:YES];
}

- (IBAction)clickSend:(id)sender {
    NSLog(@"Send");
    if(![mViewIndicator isHidden])
        return;
    [mViewIndicator setHidden:NO];
    if(!mTextField.text)
        mTextField.text = @"";
    API *a = [API getAPI];
    [a api_upload:a.mImageCurrent
            email:mTextField.text
          success:^(id JSON){
              NSDictionary *json = (NSDictionary*)JSON;
              NSLog(@"%@", json);
              if(json){
                  NSNumber *success = [json objectForKey:@"success"];
                  if(success && [success integerValue] > 0){
                      [self performSegueWithIdentifier:@"GotoViewThank" sender:nil];
                      [mViewIndicator setHidden:YES];
                      return;
                  }
              }
              [self showError];
          }failure:^(NSError *failure){
              NSLog(@"errorxxx %@", failure);
              [self showError];
          }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self clickSend:nil];
    [textField resignFirstResponder];
    return YES;
}

@end

//
//  VC_changePWD.m
//  WinningTicket
//
//  Created by Test User on 05/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_changePWD.h"

@interface VC_changePWD ()

@end

@implementation VC_changePWD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup_VIEW];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIView Cutomisation
-(void) setup_VIEW
{
    _TXT_currentPWD.layer.cornerRadius = 5.0f;
    _TXT_currentPWD.layer.masksToBounds = YES;
    _TXT_currentPWD.layer.borderWidth = 2.0f;
    _TXT_currentPWD.layer.borderColor = [UIColor grayColor].CGColor;
    
    _TXT_newPWD.layer.cornerRadius = 5.0f;
    _TXT_newPWD.layer.masksToBounds = YES;
    _TXT_newPWD.layer.borderWidth = 2.0f;
    _TXT_newPWD.layer.borderColor = [UIColor grayColor].CGColor;
    
    _TXT_confirmnewPWD.layer.cornerRadius = 5.0f;
    _TXT_confirmnewPWD.layer.masksToBounds = YES;
    _TXT_confirmnewPWD.layer.borderWidth = 2.0f;
    _TXT_confirmnewPWD.layer.borderColor = [UIColor grayColor].CGColor;
}


#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

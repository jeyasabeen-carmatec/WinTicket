//
//  VC_changePWD.m
//  WinningTicket
//
//  Created by Test User on 05/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_changePWD.h"
//#import "DGActivityIndicatorView.h"


@interface VC_changePWD ()<UITextFieldDelegate>
{
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
    UILabel *loadingLabel;
}

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
    _TXT_currentPWD.delegate=self;
    _TXT_currentPWD.tag=1;
    
    _TXT_newPWD.layer.cornerRadius = 5.0f;
    _TXT_newPWD.layer.masksToBounds = YES;
    _TXT_newPWD.layer.borderWidth = 2.0f;
    _TXT_newPWD.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_newPWD.tag=2;
    _TXT_newPWD.delegate=self;
    
    
    _TXT_confirmnewPWD.layer.cornerRadius = 5.0f;
    _TXT_confirmnewPWD.layer.masksToBounds = YES;
    _TXT_confirmnewPWD.layer.borderWidth = 2.0f;
    _TXT_confirmnewPWD.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_confirmnewPWD.tag=3;
    _TXT_confirmnewPWD.delegate=self;
    
    
    [self.actviewone stopAnimating];
    
    _Stat_label.hidden=YES;
[_done_Btn addTarget:self action:@selector(done_btnclicked) forControlEvents:UIControlEventTouchUpInside];
    
    VW_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    VW_overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    VW_overlay.clipsToBounds = YES;
    VW_overlay.layer.cornerRadius = 10.0;
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake(0, 0, activityIndicatorView.bounds.size.width, activityIndicatorView.bounds.size.height);
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, 200, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"Loading...";
    
    [VW_overlay addSubview:loadingLabel];
    activityIndicatorView.center = VW_overlay.center;
    [VW_overlay addSubview:activityIndicatorView];
    VW_overlay.center = self.view.center;
    [self.view addSubview:VW_overlay];
    _done_Btn.enabled = NO;
    
    VW_overlay.hidden = YES;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   NSInteger inte = textField.text.length;
    if(textField.tag==1)
    { if (inte <= 2)
    {
        
        _done_Btn.backgroundColor = [UIColor lightGrayColor];
        return YES;
        
    }
    else if(inte >= 12)
    {
        return NO;
    }
        
        return YES;
        
        
    }
    if(textField.tag==2)
    {
        if (inte <= 8)
        {
            
            _done_Btn.backgroundColor = [UIColor lightGrayColor];
            return YES;
            
        }
        else if(inte >= 12)
        {
            return NO;
        }
        
        return YES;

    }
    if(textField.tag == 3)
    {
     if (inte <= 8)
    {

    _done_Btn.backgroundColor = [UIColor colorWithRed:0.08 green:0.63 blue:0.85 alpha:1.0];
        _done_Btn.enabled = YES;
        return YES;
        
    }
    else if(inte >= 12)
    {
        return NO;
    }
    
    return YES;
    }
   return YES;
}
#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
      [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)done_btnclicked
{
    if([_TXT_currentPWD.text isEqualToString:@""])
    {
        [_TXT_currentPWD becomeFirstResponder];
    }
    else  if([_TXT_newPWD.text isEqualToString:@""])
    {
        [_TXT_newPWD becomeFirstResponder];
//        _Stat_label.hidden=NO;
//        [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
//        _Stat_label.text=@"Password length should be More than 8 characters";
    }
    else  if([_TXT_confirmnewPWD.text isEqualToString:@""])
    {
        [_TXT_confirmnewPWD becomeFirstResponder];
//        _Stat_label.hidden=NO;
//        [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
//        _Stat_label.text=@"Password length should be More than 8 characters";
    }
//    else if([_TXT_newPWD.text isEqualToString:_TXT_confirmnewPWD.text])
//    {
//        _Stat_label.hidden=NO;
//        [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
//        _Stat_label.text=@"Passwords are not matched";
//
//    }
    else
    {
        [activityIndicatorView startAnimating];
        VW_overlay.hidden=NO;
        [self performSelector:@selector(forgotapi) withObject:activityIndicatorView afterDelay:0.01];

    }
    

}
-(void)forgotapi
{
    NSString *current_pwd = _TXT_currentPWD.text;
    NSString *new_pwd = _TXT_newPWD.text;
    NSString *confirm_pwd=_TXT_confirmnewPWD.text;
    
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSDictionary   *parameters = @{ @"user": @{ @"current_password": current_pwd, @"password": new_pwd, @"password_confirmation": confirm_pwd } };
    self.actview.hidden=NO;
    [self.actviewone startAnimating];
    [self.view addSubview:_actview];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&error];

    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@users/change_password",SERVER_URL];
    
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPBody:postData];

    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   if (aData)
   {
    self.actview.hidden=YES;
    NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
    NSLog(@"The response %@",json_DATA);
    NSString *status=[json_DATA valueForKey:@"message"];
    

    if([status isEqualToString:@"Password has been changed successfully."])
    {
        
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
        
        NSString *password = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginPWD"];
        if (password) {
            [[NSUserDefaults standardUserDefaults] setValue:confirm_pwd forKey:@"loginPWD"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    _Stat_label.hidden=NO;
    [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
    _Stat_label.text=[json_DATA valueForKey:@"message"];
        
    }
    else
    {
        
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
    _Stat_label.hidden=NO;
    [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:3];
    _Stat_label.text=[json_DATA valueForKey:@"message"];
    _Stat_label.backgroundColor=[UIColor redColor];
     
     }

   [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"JsonEventlist"];
   [[NSUserDefaults standardUserDefaults] synchronize];
 }

}
- (void)hiddenLabel{
    _Stat_label.hidden = YES;
}
@end

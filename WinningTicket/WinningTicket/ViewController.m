//
//  ViewController.m
//  WinningTicket
//
//  Created by Test User on 22/02/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "ViewController.h"
#import "ACFloatingTextField.h"

@interface ViewController ()<UITextFieldDelegate>
{
    NSString *alert_TXT_email;
}

@end

@implementation ViewController

//updating
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FontAwesome" size:24.0f]
       } forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(backAction)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height <= 480)
        {
            // iPhone Classic
            negativeSpacer.width = 0;
        }
        else if(result.height <= 568)
        {
            // iPhone 5
            negativeSpacer.width = -12;
        }
        else
        {
            negativeSpacer.width = -16;
        }
    }
    else
    {
        negativeSpacer.width = -12;
    }
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, anotherButton] animated:NO];
    
    [self setup_VIEW];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Customisation
-(void) setup_VIEW
{
    
    NSString *user_name = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginEmail"];
    if (user_name)
    {
        _TXT_username.text = user_name;
    }
    
    _VW_holdCNT.center = self.view.center;
    _VW_content.layer.cornerRadius = 5.0f;
    _VW_content.layer.masksToBounds = YES;
    
//    _TXT_username.layer.cornerRadius = 5.0f;
//    _TXT_username.layer.masksToBounds = YES;
//    _TXT_username.layer.borderWidth = 2.0f;
//    _TXT_username.layer.borderColor = [UIColor whiteColor].CGColor;
//    _TXT_username.tag=1;
    
    _TXT_username.layer.cornerRadius = 5.0f;
    _TXT_username.layer.masksToBounds = YES;
    _TXT_username.layer.borderWidth = 2.0f;
    _TXT_username.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_username.tag = 1;
    
    _TXT_password.layer.cornerRadius = 5.0f;
    _TXT_password.layer.masksToBounds = YES;
    _TXT_password.layer.borderWidth = 2.0f;
    _TXT_password.layer.borderColor = [UIColor whiteColor].CGColor;
//    _TXT_password.enabled=NO;
    _TXT_password.tag=2;

    
    [_BTN_login addTarget:self action:@selector(action_LOGIN) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_signup addTarget:self action:@selector(action_SIGHN_UP) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_forget_PWD addTarget:self action:@selector(action_FORGET_PWD) forControlEvents:UIControlEventTouchUpInside];
//    _BTN_login.enabled=NO;

}

-(void) backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Handle UITextField While Editing
#pragma mark - UITextField Deligate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag==1)
    {
    [textField setTintColor:[UIColor whiteColor]];
    //if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
   // {
        //Keyboard becomes visible
       
    //}
    }
    [UIView beginAnimations:nil context:NULL];
    // [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height);
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==1)
    {
        NSString *text_to_compare = _TXT_username.text;
        
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([emailTest evaluateWithObject:text_to_compare] == NO)
        {
            _TXT_username.text = @"";
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Email ID!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //            [alert show];
            
            //if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            //{
            //keyboard will hide
            [UIView beginAnimations:nil context:NULL];
            // [UIView setAnimationDuration:0.25];
            self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
            [UIView commitAnimations];
            // }
            //{
            //    self.submit_action.enabled = NO;
            //}
            
            // if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            // {
            //keyboard will hide
                       // }
        }
        else{
            
            _TXT_password.enabled=YES;
            //            [_TXT_password becomeFirstResponder];
        }
    }
    [UIView beginAnimations:nil context:NULL];
    // [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    [UIView commitAnimations];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_TXT_username resignFirstResponder];
    [_TXT_password resignFirstResponder];
    
    return YES;
}

#pragma mark - Button Actions
-(void) action_LOGIN
{
    if([_TXT_username.text isEqualToString:@""])
    {
        [_TXT_username becomeFirstResponder];
        
    }
    else if([_TXT_password.text isEqualToString:@""])
    {
        [_TXT_password becomeFirstResponder];
    }
    else{
        [self apiLogin];
    }
}
-(void) action_SIGHN_UP
{
    
}
-(void) action_FORGET_PWD
{
    // The \n is required so that the alertcontroller keeps space for the message. Add as many \n as you like your textview height to be
    
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Enter Email Address"
                                                                              message: @"Please enter your email address and we’ll send you a password reset email."
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"user@email.com";
        textField.textColor = [UIColor blackColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }];
     self.submit_action.enabled = NO;
    
    self.submit_action = [UIAlertAction actionWithTitle:@"Submit"
                                             style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                alert_TXT_email= alertController.textFields[0].text;
                                                    [self forgot_PWD];

                                                }];

     [alertController addAction:self.submit_action];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)textDidChange:(UITextField *)textField {
    if (textField.text.length > 0)
    {
        NSString *text_to_compare = textField.text;
        
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([emailTest evaluateWithObject:text_to_compare] == NO)
        {
            self.submit_action.enabled = NO;
        }
        else
        {
            self.submit_action.enabled = YES;
            NSLog(@"Sucess alert button working perfect");
        }
    }
    else
    {
        self.submit_action.enabled = NO;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
//    if(textField.tag==2)
//    {
//        if(_TXT_password.text.length>0)
//        {
//            self.BTN_login.enabled = YES;
//            NSLog(@"password entered");
//            
//        }
//        else{
//            self.BTN_login.enabled = NO;
            
//        }
//    }
//    
//    else
//    {
//        self.BTN_login.enabled = NO;
//    }
    
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
//    return NO;
    return YES;
}

#pragma mark - Button Actions
-(void) apiLogin
{
    NSString *username = _TXT_username.text;
    NSString *password = _TXT_password.text;

    NSError *error;
    NSError *err;
    NSHTTPURLResponse *response = nil;
    NSDictionary *parameters = @{ @"user": @{ @"email":username , @"password":password } };

    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&err];
    NSString *urlGetuser = [NSString stringWithFormat:@"%@users/sign_in",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        
        if (_SWITCH_rememberme.on) {
            [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"loginEmail"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginEmail"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response %@",json_DATA);
        NSString *status = [json_DATA valueForKey:@"message"];
        
        
        if([status isEqualToString:@"Invalid Email or password."])
        {
            NSLog(@"please enter the correct email");
            UIAlertController *alertcontrollerone=[UIAlertController alertControllerWithTitle: @"Enter Email Address"message: @"Please enter your Correct email address."
                                                                               preferredStyle:UIAlertControllerStyleAlert];
            [alertcontrollerone addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
                
            }]];
            [self presentViewController:alertcontrollerone animated:YES completion:nil];
            
        }
        
        else   {
//            UIAlertController *alertcontrollerone=[UIAlertController alertControllerWithTitle: @"Email"message: @"Please Check Your Email"
//                                                                               preferredStyle:UIAlertControllerStyleAlert];
//            [alertcontrollerone addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                
//                
//            }]];
//            [self presentViewController:alertcontrollerone animated:YES completion:nil];
            status = [json_DATA valueForKey:@"authentication_token"];
            [[NSUserDefaults standardUserDefaults] setValue:status forKey:@"auth_token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self parse_listEvents_api];

            [self performSegueWithIdentifier:@"logintohomeidentifier" sender:self];
            
        }
        
        
        
    }
    NSLog(@"Error %@",err);
    UIAlertController *alertcontrollertwo=[UIAlertController alertControllerWithTitle: @"Server Not Coneected"message: @"Please Check your Connection."
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertcontrollertwo addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertcontrollertwo animated:YES completion:nil];

}

-(void)forgot_PWD
{
    NSString *email = alert_TXT_email;

    NSError *error;
    NSError *err;
    NSHTTPURLResponse *response = nil;
    NSDictionary *parameters = @{ @"user": @{ @"email": email } };

    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&err];
    NSString *urlGetuser =[NSString stringWithFormat:@"%@forgot_password",SERVER_USR];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response %@",json_DATA);
        NSString *status=[json_DATA objectForKey:@"message"];
        
        
        if([status isEqualToString:@"User not found."])
        {
            NSLog(@"tplease enter the correct email");
            UIAlertController *alertcontrollerone=[UIAlertController alertControllerWithTitle:nil message:status
                                                                               preferredStyle:UIAlertControllerStyleAlert];
            [alertcontrollerone addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }]];
            [self presentViewController:alertcontrollerone animated:YES completion:nil];
            
        }
        
        else
        {
            status = [json_DATA valueForKey:@"password"];
            
            UIAlertController *alertcontrollerone=[UIAlertController alertControllerWithTitle:nil message:status
                                                                               preferredStyle:UIAlertControllerStyleAlert];
            [alertcontrollerone addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }]];
            [self presentViewController:alertcontrollerone animated:YES completion:nil];
            
        }
        
        
        
    }
    NSLog(@"Error %@",err);
    UIAlertController *alertcontrollertwo=[UIAlertController alertControllerWithTitle: @"Server Not Coneected"message: @"Please Check your Connection."
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertcontrollertwo addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertcontrollertwo animated:YES completion:nil];


    
}


-(void) parse_listEvents_api
{
    NSError *error;
    NSHTTPURLResponse *response = nil;
    
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@events",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
//    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"JsonEventlist"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end

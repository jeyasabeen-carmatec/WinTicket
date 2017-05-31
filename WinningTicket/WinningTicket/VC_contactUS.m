//
//  VC_contactUS.m
//  WinningTicket
//
//  Created by Test User on 04/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_contactUS.h"

@interface VC_contactUS ()<UITextFieldDelegate,UITextViewDelegate>

@end

@implementation VC_contactUS

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup_VIEW];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, _VW_contents.frame.size.height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIview customisation
-(void) setup_VIEW
{
    CGRect frame_rect = _VW_contents.frame;
    frame_rect.size.width = _scroll_contents.frame.size.width;
    _VW_contents.frame = frame_rect;
    
    [_scroll_contents addSubview:_VW_contents];
    
    _TXT_fname.layer.cornerRadius = 5.0f;
    _TXT_fname.layer.masksToBounds = YES;
    _TXT_fname.layer.borderWidth = 2.0f;
    _TXT_fname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_fname.backgroundColor = [UIColor whiteColor];
    _TXT_fname.delegate=self;
    _TXT_fname.tag=1;
    
    _TXT_lname.layer.cornerRadius = 5.0f;
    _TXT_lname.layer.masksToBounds = YES;
    _TXT_lname.layer.borderWidth = 2.0f;
    _TXT_lname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_lname.backgroundColor = [UIColor whiteColor];
    _TXT_lname.delegate=self;
    _TXT_lname.tag=2;
    
    _TXT_email.layer.cornerRadius = 5.0f;
    _TXT_email.layer.masksToBounds = YES;
    _TXT_email.layer.borderWidth = 2.0f;
    _TXT_email.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_email.backgroundColor = [UIColor whiteColor];
    _TXT_email.delegate=self;
    _TXT_email.tag=3;
    
    _TXT_phone.layer.cornerRadius = 5.0f;
    _TXT_phone.layer.masksToBounds = YES;
    _TXT_phone.layer.borderWidth = 2.0f;
    _TXT_phone.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_phone.backgroundColor = [UIColor whiteColor];
    _TXT_phone.delegate=self;
    _TXT_phone.tag=4;
    
    _TXT_subject.layer.cornerRadius = 5.0f;
    _TXT_subject.layer.masksToBounds = YES;
    _TXT_subject.layer.borderWidth = 2.0f;
    _TXT_subject.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_subject.backgroundColor = [UIColor whiteColor];
    _TXT_subject.delegate=self;
    _TXT_subject.tag=5;
    
    _TXT_VW_message.layer.cornerRadius = 5.0f;
    _TXT_VW_message.layer.masksToBounds = YES;
    _TXT_VW_message.layer.borderWidth = 2.0f;
    _TXT_VW_message.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_VW_message.backgroundColor = [UIColor whiteColor];
    _TXT_VW_message.delegate=self;
    [_BTn_send addTarget:self action:@selector(send_Clicked) forControlEvents:UIControlEventTouchUpInside];
}
#pragma TextField_delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _TXT_VW_message.text=@"";
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==3)
    {
        NSString *text_to_compare = _TXT_email.text;
        
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([emailTest evaluateWithObject:text_to_compare] == NO)
        {
            _TXT_email.text = @"";
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
            [UIView beginAnimations:nil context:NULL];
            // [UIView setAnimationDuration:0.25];
            self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
            [UIView commitAnimations];
            
            // }
        }
        else{
            
            
            //            [_TXT_password becomeFirstResponder];
            
            
        }
        
    }
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
    [UIView beginAnimations:nil context:NULL];
    // [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    [UIView commitAnimations];
}



#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)send_Clicked
{
    
    NSString *text_to_compare=_TXT_phone.text;
    NSString *phoneRegex = @"[0-9]{10,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    if([_TXT_fname.text isEqualToString:@""])
    {
        [_TXT_fname becomeFirstResponder];
    }
    
    else  if([_TXT_lname.text isEqualToString:@""])
    {
        [_TXT_lname becomeFirstResponder];
        
    }
       else  if([_TXT_email.text isEqualToString:@""])
    {
        [_TXT_email becomeFirstResponder];
        
    }
    else if([_TXT_subject.text isEqualToString:@""])
    {
        [_TXT_subject becomeFirstResponder];
        
    }
    else if([_TXT_VW_message.text isEqualToString:@""])
    {
        [_TXT_VW_message becomeFirstResponder];
        
    }

    
    else if ([phoneTest evaluateWithObject:text_to_compare] == NO)
    {
        [_TXT_phone becomeFirstResponder];
    }
    
    else{
    
    NSString *fname = _TXT_fname.text;
    NSString *lname = _TXT_lname.text;
    //      NSString *email = _TXT_email.text;
    //
    //      NSString *username=_TXT_username.text;
       NSString *phone_num = _TXT_phone.text;
    NSString *email=_TXT_email.text;
    NSString *subject=_TXT_subject.text;
    NSString *mesage=_TXT_VW_message.text;

    
    
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSDictionary *parameters = @{ @"first_name": fname,
                                  @"last_name": lname,
                                  @"email": email,
                                  @"subject": subject,
                                  @"message": mesage,
                                  @"phone": phone_num };
    
    
//    self->activityIndicatorView.hidden=NO;
//    [self->activityIndicatorView startAnimating];
//    [self.view addSubview:activityIndicatorView];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&error];
    
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@home/contact_us",SERVER_URL];
    
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
//        self->activityIndicatorView.hidden=YES;
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response %@",json_DATA);
        NSString *status=[json_DATA valueForKey:@"status"];
        if([status isEqualToString:@"Success"])
        {
            UIAlertController *alertcontrollerone=[UIAlertController alertControllerWithTitle: @"Details"message: @"Suuccessfully Send" preferredStyle:UIAlertControllerStyleAlert];
            [alertcontrollerone addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }]];
            [self presentViewController:alertcontrollerone animated:YES completion:nil];
            
            
        }
        else
        {
            
            UIAlertController *alertcontrollertwo = [UIAlertController alertControllerWithTitle:@"Check Details" message: @"Please Check The Details" preferredStyle:UIAlertControllerStyleAlert];
            [alertcontrollertwo addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                //                [self performSegueWithIdentifier:@"success_segue" sender:self];
                
                
            }]];
            [self presentViewController:alertcontrollertwo animated:YES completion:nil];
//            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    
    
    
    else{
//        [activityIndicatorView stopAnimating];
//        VW_overlay.hidden = YES;
        
        UIAlertController *alertcontrollertwo=[UIAlertController alertControllerWithTitle: @"Server Not Coneected"message: @"Please Check your Connection."
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertcontrollertwo addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:alertcontrollertwo animated:YES completion:nil];
    }
    
    
    }
    
    
}
@end

//
//  VC_editAccount.m
//  WinningTicket
//
//  Created by Test User on 05/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_editAccount.h"
#import "DGActivityIndicatorView.h"

@interface VC_editAccount ()
{
    UIView *VW_overlay;
    DGActivityIndicatorView *activityIndicatorView;
}
@property(nonatomic,strong)NSArray *ARR_states;

@end

@implementation VC_editAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSError *error;
    NSMutableDictionary *json_DAT = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"state_response"] options:NSASCIIStringEncoding error:&error];
    NSLog(@"The response %@",json_DAT);
    self.ARR_states=[json_DAT allKeys];
    
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
    
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, _VW_contents.frame.size.height+200);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UIView Customize
-(void) setup_VIEW
{
    NSError *error;
   NSMutableDictionary *user_data=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"User_data"] options:NSASCIIStringEncoding error:&error];
    NSLog(@"the user data is:%@",user_data);
    
    CGRect content_frame = _VW_contents.frame;
    content_frame.size.width = _scroll_contents.frame.size.width;
    _VW_contents.frame = content_frame;
    
    [_scroll_contents addSubview:_VW_contents];
    
    _TXT_fname.layer.cornerRadius = 5.0f;
    _TXT_fname.layer.masksToBounds = YES;
    _TXT_fname.layer.borderWidth = 2.0f;
    _TXT_fname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_fname.text=[user_data valueForKey:@"first_name"];
    _TXT_fname.tag=1;

    _TXT_lname.layer.cornerRadius = 5.0f;
    _TXT_lname.layer.masksToBounds = YES;
    _TXT_lname.layer.borderWidth = 2.0f;
    _TXT_lname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_lname.text=[user_data valueForKey:@"last_name"];
    _TXT_lname.tag=2;
  
    _TXT_email.layer.cornerRadius = 5.0f;
    _TXT_email.layer.masksToBounds = YES;
    _TXT_email.layer.borderWidth = 2.0f;
    _TXT_email.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_email.text=[user_data valueForKey:@"email"];

    _TXT_username.layer.cornerRadius = 5.0f;
    _TXT_username.layer.masksToBounds = YES;
    _TXT_username.layer.borderWidth = 2.0f;
    _TXT_username.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_username.text=[user_data valueForKey:@"email"];
    
    
    _TXT_addr1.layer.cornerRadius = 5.0f;
    _TXT_addr1.layer.masksToBounds = YES;
    _TXT_addr1.layer.borderWidth = 2.0f;
    _TXT_addr1.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_addr1.text=[user_data valueForKey:@"address1"];
    _TXT_addr1.tag=3;
    
    _TXT_addr2.layer.cornerRadius = 5.0f;
    _TXT_addr2.layer.masksToBounds = YES;
    _TXT_addr2.layer.borderWidth = 2.0f;
    _TXT_addr2.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_addr2.text=[user_data valueForKey:@"address2"];
    _TXT_addr2.tag=4;

    
    _TXT_city.layer.cornerRadius = 5.0f;
    _TXT_city.layer.masksToBounds = YES;
    _TXT_city.layer.borderWidth = 2.0f;
    _TXT_city.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_city.text=[user_data valueForKey:@"city"];
    _TXT_city.tag=5;
    
    _TXT_state.layer.cornerRadius = 5.0f;
    _TXT_state.layer.masksToBounds = YES;
    _TXT_state.layer.borderWidth = 2.0f;
    _TXT_state.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_state.text=[user_data valueForKey:@"state"];
    _TXT_state.tag=6;
    
    _TXT_zip.layer.cornerRadius = 5.0f;
    _TXT_zip.layer.masksToBounds = YES;
    _TXT_zip.layer.borderWidth = 2.0f;
    _TXT_zip.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_zip.text=[user_data valueForKey:@"zipcode"];
    _TXT_zip.tag=7;
    
    _TXT_phone.layer.cornerRadius = 5.0f;
    _TXT_phone.layer.masksToBounds = YES;
    _TXT_phone.layer.borderWidth = 2.0f;
    _TXT_phone.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_phone.text=[user_data valueForKey:@"phone"];
    
    _state_pickerView = [[UIPickerView alloc] init];
    _state_pickerView.delegate = self;
    _state_pickerView.dataSource = self;
    
    UIToolbar* state_close = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    state_close.barStyle = UIBarStyleBlackTranslucent;
    [state_close sizeToFit];
    UILabel *statelbl=[[UILabel alloc]initWithFrame:CGRectMake(state_close.frame.size.width-250, 0, 100, state_close.frame.size.height)];
    [state_close addSubview:statelbl];
    statelbl.text=@"Select State";
    statelbl.textColor=[UIColor redColor];
    statelbl.backgroundColor=[UIColor clearColor];
    
    UIButton *close=[[UIButton alloc]init];
    close.frame=CGRectMake(state_close.frame.size.width - 100, 0, 100, state_close.frame.size.height);
    [close setTitle:@"close" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [numberToolbar setItems:[NSArray arrayWithObjects:close, nil]];
    [state_close addSubview:close];

    self.TXT_state.inputView=_state_pickerView;
    _TXT_state.inputAccessoryView=state_close;
    _TXT_state.tintColor=[UIColor clearColor];
    [_BTN_save addTarget:self action:@selector(save_clikced) forControlEvents:UIControlEventTouchUpInside];
    
//    [self State_api];
    
}
-(void)save_clikced
{
    if([_TXT_fname.text isEqualToString:@""])
    {
        [_TXT_fname becomeFirstResponder];
    }
    
    else  if([_TXT_lname.text isEqualToString:@""])
    {
        [_TXT_lname becomeFirstResponder];
        
    }
    else if([_TXT_addr1.text isEqualToString:@""])
    {
        [_TXT_addr1 becomeFirstResponder];
        
    }
    else  if([_TXT_addr2.text isEqualToString:@""])
    {
        [_TXT_addr2 becomeFirstResponder];
        
    }
    else if([_TXT_city.text isEqualToString:@""])
    {
        [_TXT_city becomeFirstResponder];
        
    }
    
    
    
    else if([_TXT_state.text isEqualToString:@""])
    {
        [_TXT_state becomeFirstResponder];
        
    }
    else if([_TXT_zip.text isEqualToString:@""])
    {
        [_TXT_zip becomeFirstResponder];
    }
    else{
    
    [self save_api_call];
}
}

-(void)closebuttonClick
{
    [self.TXT_state resignFirstResponder];
}




#pragma mark - BTN Actions
-(void)save_api_call
{
    
        NSString *fname = _TXT_fname.text;
        NSString *lname = _TXT_lname.text;
//        NSString *email = _TXT_email.text;
//
//        NSString *username=_TXT_username.text;
        NSString *addressone = _TXT_addr1.text;
        NSString *addresstwo = _TXT_addr2.text;
        NSString *city = _TXT_city.text;
        NSString *state = _TXT_state.text;

        NSString *phone_num = _TXT_phone.text;
    NSString *Zip_code=_TXT_zip.text;
   
        
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSDictionary *parameters = @{ @"user": @{ @"first_name":fname , @"last_name":lname , @"phone":phone_num, @"address1":addressone , @"address2":addresstwo , @"state":state, @"city":city , @"zipcode": Zip_code } };
    

    self->activityIndicatorView.hidden=NO;
    [self->activityIndicatorView startAnimating];
    [self.view addSubview:activityIndicatorView];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&error];
    
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@users/edit_profile",SERVER_URL];
    
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
        self->activityIndicatorView.hidden=YES;
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response %@",json_DATA);
        NSString *status=[json_DATA valueForKey:@"status"];
        if([status isEqualToString:@"Success"])
        {
            UIAlertController *alertcontrollerone=[UIAlertController alertControllerWithTitle: @"Details"message: @"Details Successfully Updated" preferredStyle:UIAlertControllerStyleAlert];
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
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }

        
        
        else{
            [activityIndicatorView stopAnimating];
            VW_overlay.hidden = YES;
            
            UIAlertController *alertcontrollertwo=[UIAlertController alertControllerWithTitle: @"Server Not Coneected"message: @"Please Check your Connection."
                                                                               preferredStyle:UIAlertControllerStyleAlert];
            [alertcontrollertwo addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }]];
            [self presentViewController:alertcontrollertwo animated:YES completion:nil];
        }
  
                      
                      
                    }
        
    

    




-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark PickerView DataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if(pickerView==_state_pickerView)
    {
        return 1;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == _state_pickerView) {
        return [_ARR_states count];
    }
    
    
    return 0;
}
#pragma mark - UIPickerViewDelegate


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView == _state_pickerView) {
        return _ARR_states[row];
    }
    
    return nil;
}


@end

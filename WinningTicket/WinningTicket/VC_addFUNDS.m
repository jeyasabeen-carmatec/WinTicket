//
//  VC_addFUNDS.m
//  WinningTicket
//
//  Created by Test User on 30/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_addFUNDS.h"

@interface VC_addFUNDS ()
@property(nonatomic,strong)NSArray *ARR_states;
@end

@implementation VC_addFUNDS

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
    [_scroll_Contents layoutIfNeeded];
//    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
//    {
        _scroll_Contents.contentSize = CGSizeMake(_scroll_Contents.frame.size.width, _VW_contents.frame.size.height+100);
//    }
//    else
//    {
//        _scroll_Contents.contentSize = CGSizeMake(_scroll_Contents.frame.size.width, 653);
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) setup_VIEW
{
    _BTN_10.layer.cornerRadius = 5.0f;
    _BTN_10.layer.masksToBounds = YES;
    _BTN_10.layer.borderWidth = 2.0f;
    _BTN_10.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    _BTN_10.titleLabel.textColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0];
    [_BTN_10 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    _BTN_25.layer.cornerRadius = 5.0f;
    _BTN_25.layer.masksToBounds = YES;
    _BTN_25.layer.borderWidth = 2.0f;
    _BTN_25.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    _BTN_25.titleLabel.textColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0];
    [_BTN_25 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    _BTN_50.layer.cornerRadius = 5.0f;
    _BTN_50.layer.masksToBounds = YES;
    _BTN_50.layer.borderWidth = 2.0f;
    _BTN_50.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    [_BTN_50 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
//    [_BTN_state addTarget:self action:@selector(ACTION_state) forControlEvents:UIControlEventTouchUpInside];
    
    _TXT_amount.layer.cornerRadius = 5.0f;
    _TXT_amount.layer.masksToBounds = YES;
    _TXT_amount.layer.borderWidth = 2.0f;
    _TXT_amount.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
//    _TXT_amount.titleLabel.textColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0];
    [_TXT_amount addTarget:self action:@selector(check_TXT_stat:) forControlEvents:UIControlEventEditingChanged];
    _TXT_amount.delegate=self;
    
    [_BTN_10 addTarget:self action:@selector(BTN_10Method) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_25 addTarget:self action:@selector(BTN_25Method) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_50 addTarget:self action:@selector(BTN_50Method) forControlEvents:UIControlEventTouchUpInside];
    
//    _PICK_state.hidden = YES;
//    _TOOL_state.hidden = YES;
    
    _TXT_firstname.layer.cornerRadius = 5.0f;
    _TXT_firstname.layer.masksToBounds = YES;
    _TXT_firstname.layer.borderWidth = 2.0f;
    _TXT_firstname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_firstname.backgroundColor = [UIColor whiteColor];
    
    _TXT_lastname.layer.cornerRadius = 5.0f;
    _TXT_lastname.layer.masksToBounds = YES;
    _TXT_lastname.layer.borderWidth = 2.0f;
    _TXT_lastname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_lastname.backgroundColor = [UIColor whiteColor];
    
    _TXT_address1.layer.cornerRadius = 5.0f;
    _TXT_address1.layer.masksToBounds = YES;
    _TXT_address1.layer.borderWidth = 2.0f;
    _TXT_address1.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_address1.backgroundColor = [UIColor whiteColor];
    
    _TXT_address2.layer.cornerRadius = 5.0f;
    _TXT_address2.layer.masksToBounds = YES;
    _TXT_address2.layer.borderWidth = 2.0f;
    _TXT_address2.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_address2.backgroundColor = [UIColor whiteColor];
    
    _TXT_city.layer.cornerRadius = 5.0f;
    _TXT_city.layer.masksToBounds = YES;
    _TXT_city.layer.borderWidth = 2.0f;
    _TXT_city.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_city.backgroundColor = [UIColor whiteColor];
    
    _TXT_state.layer.cornerRadius = 5.0f;
    _TXT_state.layer.masksToBounds = YES;
    _TXT_state.layer.borderWidth = 2.0f;
    _TXT_state.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_state.backgroundColor = [UIColor whiteColor];
    
    _TXT_zip.layer.cornerRadius = 5.0f;
    _TXT_zip.layer.masksToBounds = YES;
    _TXT_zip.layer.borderWidth = 2.0f;
    _TXT_zip.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_zip.backgroundColor = [UIColor whiteColor];
    
    _TXT_phonenumber.layer.cornerRadius = 5.0f;
    _TXT_phonenumber.layer.masksToBounds = YES;
    _TXT_phonenumber.layer.borderWidth = 2.0f;
    _TXT_phonenumber.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_phonenumber.backgroundColor = [UIColor whiteColor];
    
    CGRect frame_rct = _VW_contents.frame;
    frame_rct.size.width = _scroll_Contents.frame.size.width;
    _VW_contents.frame = frame_rct;
    
    [_scroll_Contents addSubview:_VW_contents];
    
    
    _state_pickerView=[[UIPickerView alloc]init];
    _state_pickerView.dataSource=self;
    _state_pickerView.delegate=self;

    
    
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
    _TXT_state.inputView=_state_pickerView;
    _TXT_state.inputAccessoryView=state_close;
    
    

}
-(void)closebuttonClick
{
    [_TXT_state resignFirstResponder];
}
#pragma mark - UIButton Actions
-(void) BTN_10Method
{
    
    NSLog(@"Button 10 tapped");
    NSString *temptext=_BTN_10.titleLabel.text;
    NSArray *arr=[temptext componentsSeparatedByString:@"$"];
    self.TXT_amount.text=[NSString stringWithFormat:@"%@.00",[arr objectAtIndex:1]];
    [_BTN_10 setBackgroundColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0]];
    [_BTN_10 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_BTN_25 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_25 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    [_BTN_50 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_50 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    
}
-(void) BTN_25Method
{
    NSLog(@"Button 25 tapped");
   NSString *temptext=_BTN_25.titleLabel.text;
    NSArray *arr=[temptext componentsSeparatedByString:@"$"];
    self.TXT_amount.text=[NSString stringWithFormat:@"%@.00",[arr objectAtIndex:1]];
    [_BTN_10 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_10 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    [_BTN_25 setBackgroundColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0]];
    [_BTN_25 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_BTN_50 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_50 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
}
-(void) BTN_50Method
{
    NSLog(@"Button 50 tapped");
    NSString *temptext=_BTN_50.titleLabel.text;
    NSArray *arr=[temptext componentsSeparatedByString:@"$"];
    self.TXT_amount.text=[NSString stringWithFormat:@"%@.00",[arr objectAtIndex:1]];
    [_BTN_10 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_10 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    [_BTN_25 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_25 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    [_BTN_50 setBackgroundColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0]];
    [_BTN_50 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
//-(void) ACTION_state
//{
//    _PICK_state.hidden = NO;
//    _TOOL_state.hidden = NO;
//}

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

// #6

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == _state_pickerView) {
        
        self.TXT_state.text=[_ARR_states objectAtIndex:row];
    }
}




#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


#pragma mark - IBAction Actions
-(IBAction)TAP_done
{
//    _PICK_state.hidden = YES;
//    _TOOL_state.hidden = YES;
    
    NSLog(@"Done Tapped");
}

#pragma mark - UITextFieldDeligate/UITextFieldDatasource
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_BTN_10 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_10 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    [_BTN_25 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_25 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    [_BTN_50 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_50 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _TXT_amount) {
        NSString *new_STR= _TXT_amount.text;
        NSArray *ARR_str = [new_STR componentsSeparatedByString:@"."];
        if (ARR_str.count == 1)
        {
            //        self.lbl.text = [NSString stringWithFormat:@"%@.00",new_STR];
            //        _txtfld.text = self.lbl.text;
            _TXT_amount.text = [NSString stringWithFormat:@"%@.00",new_STR];
        }
        else
        {
            NSString *temp_STR = [ARR_str objectAtIndex:1];
            if (temp_STR.length == 1) {
                //            self.lbl.text = [NSString stringWithFormat:@"%@0",new_STR];
                //            _txtfld.text = self.lbl.text;
                _TXT_amount.text = [NSString stringWithFormat:@"%@0",new_STR];
            }
            else
            {
                //            self.lbl.text = new_STR;
                //            _txtfld.text = self.lbl.text;
                _TXT_amount.text = new_STR;
            }
        }
    }
    if([_TXT_amount.text isEqualToString:@"10.00"])
        
    {
        [_BTN_10 setBackgroundColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0]];
        [_BTN_10 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _BTN_25.backgroundColor=[UIColor clearColor];
        _BTN_50.backgroundColor=[UIColor clearColor];
        
       
        
    }
    else if([_TXT_amount.text isEqualToString:@"25.00"])
        
    {
        [_BTN_25 setBackgroundColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0]];
        [_BTN_25 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _BTN_10.backgroundColor=[UIColor clearColor];
        _BTN_50.backgroundColor=[UIColor clearColor];
        
       
        
        
    }else if([_TXT_amount.text isEqualToString:@"50.00"])
        
    {
        [_BTN_50 setBackgroundColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0]];
        [_BTN_50 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _BTN_10.backgroundColor=[UIColor clearColor];
        _BTN_25.backgroundColor=[UIColor clearColor];

        
        
        
    }
    else{
        _TXT_amount.text=@"";
    }
    

}

-(void) check_TXT_stat :(id)sender
{
    
}

#pragma mark - API Integration
-(void)State_api
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@city_states/states",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
    NSLog(@"The response %@",json_DATA);
    //    NSString *status=[json_DATA objectForKey:@"United States"];
    _ARR_states = [json_DATA allKeys];
    
    
}

@end

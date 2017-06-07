//
//  VC_donate.m
//  WinningTicket
//
//  Created by Test User on 31/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_donate.h"
#import "DGActivityIndicatorView.h"
#import "DejalActivityView.h"


@interface VC_donate ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    UIView *VW_overlay;
    DGActivityIndicatorView *activityIndicatorView;
    NSMutableDictionary *states,*countryS;
}
@property (nonatomic, strong) NSArray *countrypicker,*statepicker,*oraganisationpicker,*arr;

@end

@implementation VC_donate
{
    float content_height;
    float original_height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap_DTECt:)];
    [tap setCancelsTouchesInView:NO];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    [self setup_view];
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
        _scroll_Contents.contentSize = CGSizeMake(_scroll_Contents.frame.size.width, original_height);
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

#pragma mark - UIView Customisation
-(void) setup_view
{
    CGRect final_frame = _TXTVW_organisationname.frame;
    final_frame.size.height = _TXTVW_organisationname.contentSize.height;
    _TXTVW_organisationname.frame = final_frame;
    
    final_frame = _lbl_titledonationAMT.frame;
    final_frame.origin.y = _TXTVW_organisationname.frame.origin.y + _TXTVW_organisationname.frame.size.height + 10;
    _lbl_titledonationAMT.frame = final_frame;
    
    final_frame = _lbl_currencyTYP.frame;
    final_frame.origin.y = _lbl_titledonationAMT.frame.origin.y + _lbl_titledonationAMT.frame.size.height + 10;
    _lbl_currencyTYP.frame = final_frame;
    
    final_frame = _TXT_getamount.frame;
    final_frame.origin.y = _lbl_currencyTYP.frame.origin.y;
    _TXT_getamount.frame = final_frame;
    
    CGRect VW_frame = _VW_organisationdetail.frame;
    VW_frame.size.height = _lbl_currencyTYP.frame.origin.y + _lbl_currencyTYP.frame.size.height + 10;
    VW_frame.size.width = _scroll_Contents.frame.size.width;
    _VW_organisationdetail.frame = VW_frame;
    
    [self.scroll_Contents addSubview:_VW_organisationdetail];

    VW_frame = _VW_titladdress.frame;
    VW_frame.origin.y = _VW_organisationdetail.frame.origin.y + _VW_organisationdetail.frame.size.height;
    VW_frame.size.width = _scroll_Contents.frame.size.width;
    _VW_titladdress.frame = VW_frame;
    
    [self.scroll_Contents addSubview:_VW_titladdress];
      [_BTN_edit addTarget:self action:@selector(edit_BTN_action:) forControlEvents:UIControlEventTouchUpInside];
    
    _TXTVW_organisationname.layer.cornerRadius=3.0f;
    _TXTVW_organisationname.layer.borderWidth=2.0f;
    _TXTVW_organisationname.layer.borderColor=[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    
    
    _TXT_getamount.layer.cornerRadius = 5.0f;
    _TXT_getamount.layer.masksToBounds = YES;
    _TXT_getamount.layer.borderWidth = 2.0f;
    _TXT_getamount.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    
    /*apr code*/
    _organisation_list = [[UIPickerView alloc] init];
    _organisation_list.delegate = self;
    _organisation_list.dataSource = self;
    /*setting the frames for address label and button in old*/
    CGRect frame_old;
    frame_old = _lbl_address.frame;
     frame_old.origin.y= _VW_titladdress.frame.size.height+_VW_titladdress.frame.origin.y+10;
    _lbl_address.frame=frame_old;
    [self get_EVENTS];
    NSData *aData=[[NSUserDefaults standardUserDefaults]valueForKey:@"User_data"] ;
    NSError *error;

    if(aData)
    {
        NSMutableDictionary *user_DICTIN = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"User_data"] options:NSASCIIStringEncoding error:&error];
        NSDictionary *user_data = [user_DICTIN valueForKey:@"user"];
        NSLog(@"VC donate display Address:%@",user_data);
        NSString *address_str=[NSString stringWithFormat:@"%@ %@\n%@,%@\n%@,%@\n%@,%@.\nPhone:%@",[user_data valueForKey:@"first_name"],[user_data valueForKey:@"last_name"],[user_data valueForKey:@"address1"],[user_data valueForKey:@"address2"],[user_data valueForKey:@"city"],[user_data valueForKey:@"state"],[user_data valueForKey:@"country"],[user_data valueForKey:@"zipcode"],[user_data valueForKey:@"phone"]];
        _lbl_address.text = address_str;
        _lbl_address.numberOfLines=0;
        [_lbl_address sizeToFit];
        
        _TXT_firstname.text = [user_data valueForKey:@"first_name"];
        _TXT_lastname.text = [user_data valueForKey:@"last_name"];
        _TXT_address1.text = [user_data valueForKey:@"address1"];
        _TXT_address2.text = [user_data valueForKey:@"address2"];
        _TXT_city.text = [user_data valueForKey:@"city"];
        _TXT_country.text = [user_data valueForKey:@"country"];
        _TXT_zip.text = [user_data valueForKey:@"zipcode"];
        _TXT_state.text = [user_data valueForKey:@"state"];
        _TXT_phonenumber.text = [user_data valueForKey:@"phone"];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    
    frame_old = _BTN_deposit.frame;
    frame_old.origin.y =  _lbl_address.frame.origin.y + _lbl_address.frame.size.height + 10;
    _BTN_deposit.frame=frame_old;
    /*setting the frames for address label and button in old*/
    
    UITapGestureRecognizer *tapToorganisation = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                       action:@selector(tappedToSelectOrganisation:)];
    tapToorganisation.delegate = self;
    [_organisation_list addGestureRecognizer:tapToorganisation];
    
    
    
        _VW_address.frame=CGRectMake(0, self.self.VW_titladdress.frame.origin.y+self.VW_titladdress.frame.size.height+10, self.scroll_Contents.frame.size.width, self.VW_address.frame.size.height);
        [self.scroll_Contents addSubview:_VW_address];
    _VW_address.hidden=YES;
    
    UIToolbar* conutry_close = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    conutry_close.barStyle = UIBarStyleBlackTranslucent;
    [conutry_close sizeToFit];
    
    UIButton *close=[[UIButton alloc]init];
    close.frame=CGRectMake(conutry_close.frame.size.width - 100, 0, 100, conutry_close.frame.size.height);
    [close setTitle:@"close" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [numberToolbar setItems:[NSArray arrayWithObjects:close, nil]];
    [conutry_close addSubview:close];
    _TXTVW_organisationname.inputAccessoryView=conutry_close;
    self.TXTVW_organisationname.inputView=_organisation_list;
    
    _contry_pickerView = [[UIPickerView alloc] init];
    _contry_pickerView.delegate = self;
    _contry_pickerView.dataSource = self;
    _state_pickerView = [[UIPickerView alloc] init];
    _state_pickerView.delegate = self;
    _state_pickerView.dataSource = self;
    UITapGestureRecognizer *tapToSelect = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(tappedToSelectRow:)];
    tapToSelect.delegate = self;
    [_contry_pickerView addGestureRecognizer:tapToSelect];
    UITapGestureRecognizer *satetap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(tappedToSelectRowstate:)];
    satetap.delegate = self;
    [_state_pickerView addGestureRecognizer:satetap];
    
    
    _TXT_country.inputAccessoryView=conutry_close;
    _TXT_state.inputAccessoryView=conutry_close;
    self.TXT_country.inputView = _contry_pickerView;
    self.TXT_state.inputView=_state_pickerView;
    _TXT_country.tintColor=[UIColor clearColor];
    _TXT_state.tintColor=[UIColor clearColor];
    [self Country_api];
    [self State_api];
    
    _TXT_firstname.layer.cornerRadius = 5.0f;
    _TXT_firstname.layer.masksToBounds = YES;
    _TXT_firstname.layer.borderWidth = 2.0f;
    _TXT_firstname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_firstname.backgroundColor = [UIColor whiteColor];
    _TXT_firstname.tag=1;
    _TXT_firstname.delegate=self;
    
    
    _TXT_lastname.layer.cornerRadius = 5.0f;
    _TXT_lastname.layer.masksToBounds = YES;
    _TXT_lastname.layer.borderWidth = 2.0f;
    _TXT_lastname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_lastname.backgroundColor = [UIColor whiteColor];
    _TXT_lastname.tag=2;
    _TXT_lastname.delegate=self;
    
    _TXT_address1.layer.cornerRadius = 5.0f;
    _TXT_address1.layer.masksToBounds = YES;
    _TXT_address1.layer.borderWidth = 2.0f;
    _TXT_address1.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_address1.backgroundColor = [UIColor whiteColor];
    _TXT_address1.tag=3;
    _TXT_address1.delegate=self;
    
    _TXT_address2.layer.cornerRadius = 5.0f;
    _TXT_address2.layer.masksToBounds = YES;
    _TXT_address2.layer.borderWidth = 2.0f;
    _TXT_address2.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_address2.backgroundColor = [UIColor whiteColor];
    _TXT_address2.tag=4;
    _TXT_address2.delegate=self;
    
    _TXT_city.layer.cornerRadius = 5.0f;
    _TXT_city.layer.masksToBounds = YES;
    _TXT_city.layer.borderWidth = 2.0f;
    _TXT_city.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_city.backgroundColor = [UIColor whiteColor];
    _TXT_city.tag=5;
    _TXT_city.delegate=self;
    
    _TXT_country.layer.cornerRadius = 5.0f;
    _TXT_country.layer.masksToBounds = YES;
    _TXT_country.layer.borderWidth = 2.0f;
    _TXT_country.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_country.backgroundColor = [UIColor whiteColor];
    _TXT_country.tag=6;
    _TXT_country.delegate=self;
    
    
    _TXT_state.layer.cornerRadius = 5.0f;
    _TXT_state.layer.masksToBounds = YES;
    _TXT_state.layer.borderWidth = 2.0f;
    _TXT_state.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_state.backgroundColor = [UIColor whiteColor];
    _TXT_state.tag=7;
    _TXT_state.delegate=self;
    
    _TXT_zip.layer.cornerRadius = 5.0f;
    _TXT_zip.layer.masksToBounds = YES;
    _TXT_zip.layer.borderWidth = 2.0f;
    _TXT_zip.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_zip.backgroundColor = [UIColor whiteColor];
    _TXT_zip.tag=8;
    _TXT_zip.delegate=self;
    
    _TXT_phonenumber.layer.cornerRadius = 5.0f;
    _TXT_phonenumber.layer.masksToBounds = YES;
    _TXT_phonenumber.layer.borderWidth = 2.0f;
    _TXT_phonenumber.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_phonenumber.backgroundColor = [UIColor whiteColor];
    _TXT_phonenumber.tag=9;
    _TXT_phonenumber.delegate=self;

    [_BTN_deposit addTarget:self action:@selector(Deposit_Pressed) forControlEvents:UIControlEventTouchUpInside];
    
    VW_overlay = [[UIView alloc]init];
    VW_overlay.frame = [UIScreen mainScreen].bounds;
    //    VW_overlay.center = self.view.center;
    
    [self.view addSubview:VW_overlay];
    VW_overlay.backgroundColor = [UIColor blackColor];
    VW_overlay.alpha = 0.2;
    
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor whiteColor]];
    
    CGRect frame_M = activityIndicatorView.frame;
    frame_M.origin.x = 0;
    frame_M.origin.y = 0;
    frame_M.size.width = VW_overlay.frame.size.width;
    frame_M.size.height = VW_overlay.frame.size.height;
    activityIndicatorView.frame = frame_M;
    
    [VW_overlay addSubview:activityIndicatorView];
    //        activityIndicatorView.center=myview.center;
    
    VW_overlay.hidden = YES;
    
      
    
}
-(void)closebuttonClick
{
    [_TXT_state resignFirstResponder];
    [_TXT_country resignFirstResponder];
    [_TXTVW_organisationname resignFirstResponder];
}

#pragma mark - Edit button Clicked 

-(void) edit_BTN_action : (id) sender
{
    if(_VW_address.hidden==YES)
    {
        original_height =  self.BTN_deposit.frame.origin.y + _BTN_deposit.frame.size.height + 20;
     
        
        
        [UIView beginAnimations:@"LeftFlip" context:nil];
        [UIView setAnimationDuration:0.5];
        _VW_address.frame=CGRectMake(_VW_titladdress.frame.origin.x,_VW_titladdress.frame.origin.y+60,self.scroll_Contents.frame.size.width,_VW_address.frame.size.height);
        [self.scroll_Contents addSubview:_VW_address];
        _VW_address.hidden=NO;
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_address cache:YES];
        [UIView commitAnimations];
        [UIView animateWithDuration:0.5 animations:^{
            
            /*Frame Change*/
            _lbl_address.hidden=YES;
            
            //            _proceed_TOPAY.frame=CGRectMake(_proceed_TOPAY.frame.origin.x
            //                                            ,  _VW_address.frame.origin.y+_VW_address.frame.size.height+10, _proceed_TOPAY.frame.size.width, _proceed_TOPAY.frame.size.height);
            
            _BTN_deposit.frame = CGRectMake(_BTN_deposit.frame.origin.x, _VW_address.frame.origin.y + _VW_address.frame.size.height + 15, _BTN_deposit.frame.size.width, _BTN_deposit.frame.size.height);
            
                    }];
        [UIView commitAnimations];
        
        _BTN_edit.enabled=NO;
        
        original_height =  self.BTN_deposit.frame.origin.y + _BTN_deposit.frame.size.height + 20;
        [self viewDidLayoutSubviews];
        
    }
    else{
        //        [self hideview];
        original_height = original_height - 100;
        _lbl_address.hidden=NO;
        [self viewDidLayoutSubviews];
    }
    
}


#pragma mark - Textfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 3 || textField.tag == 8 || textField.tag == 9)
    {
        [textField setTintColor:[UIColor whiteColor]];
        //if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        // {
        //Keyboard becomes visible
        [UIView beginAnimations:nil context:NULL];
        // [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0,-120,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
        //}
    }
    
    if (textField == _TXT_getamount) {
        NSString *new_STR= _TXT_getamount.text;
        NSArray *ARR_str = [new_STR componentsSeparatedByString:@"."];
        if (ARR_str.count == 1)
        {
            //        self.lbl.text = [NSString stringWithFormat:@"%@.00",new_STR];
            //        _txtfld.text = self.lbl.text;
            _TXT_getamount.text = [NSString stringWithFormat:@"%@.00",new_STR];
        }
        else
        {
            NSString *temp_STR = [ARR_str objectAtIndex:1];
            if (temp_STR.length == 1) {
                //            self.lbl.text = [NSString stringWithFormat:@"%@0",new_STR];
                //            _txtfld.text = self.lbl.text;
                _TXT_getamount.text = [NSString stringWithFormat:@"%@0",new_STR];
            }
            else
            {
                //            self.lbl.text = new_STR;
                //            _txtfld.text = self.lbl.text;
                _TXT_getamount.text = new_STR;
            }
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//        if(textField.tag==9)
//        {
    [UIView beginAnimations:nil context:NULL];
    
    self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    [UIView commitAnimations];
    [UIView beginAnimations:nil context:NULL];
    
    self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    [UIView commitAnimations];
      // }
}
//- (void)textViewDidChange:(UITextView *)textView
//{
//    CGFloat fixedWidth = textView.frame.size.width;
//    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//    CGRect newFrame = textView.frame;
//    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
//    textView.frame = newFrame;
//}

#pragma mark - UIPickerViewDataSource

// #3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == _contry_pickerView) {
        return 1;
    }if(pickerView==_state_pickerView)
    {
        return 1;
    }
    if(pickerView==_organisation_list)
    {
        return 1;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == _contry_pickerView) {
        return [self.countrypicker count];
    }
    if (pickerView == _state_pickerView) {
        return [self.statepicker count];
    }
    if (pickerView == _organisation_list) {
        return [self.oraganisationpicker count];
    }
    
    return 0;
}
#pragma mark - UIPickerViewDataSource
-(void)Country_api
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@city_states/countries",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData) {
        countryS = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response %@",countryS);
        self.countrypicker=[countryS allKeys];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    
    
    
}
-(void)State_api
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@city_states/states?country=%@",SERVER_URL,[countryS valueForKey:_TXT_country.text]];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData) {
        states = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response %@",states);
        self.statepicker=[states allKeys];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
        
}

#pragma mark - UIPickerViewDelegate


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == _contry_pickerView) {
        return self.countrypicker[row];
    }
    if (pickerView == _state_pickerView) {
        return self.statepicker[row];
    }
    if (pickerView == _organisation_list) {
        _arr=[_oraganisationpicker objectAtIndex:row];
        
        return [_arr objectAtIndex:1];
//        NSLog(@"the temp arr:%@",arr);
    }
    
    return nil;
}

// #6
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == _contry_pickerView) {
        self.TXT_country.text = self.countrypicker[row];
        [self State_api];
        self.TXT_state.enabled=YES;
    }
    if (pickerView == _state_pickerView) {
        
        self.TXT_state.text=self.statepicker[row];
        //        self.TXT_email.enabled=YES;
    }
    if (pickerView == _organisation_list) {
        if(_VW_address.hidden == NO)
        {
            CGRect final_frame = _TXTVW_organisationname.frame;
            final_frame.size.height = _TXTVW_organisationname.contentSize.height;
            _TXTVW_organisationname.frame = final_frame;
            
            final_frame = _lbl_titledonationAMT.frame;
            final_frame.origin.y = _TXTVW_organisationname.frame.origin.y + _TXTVW_organisationname.frame.size.height + 10;
            _lbl_titledonationAMT.frame = final_frame;
            
            final_frame = _lbl_currencyTYP.frame;
            final_frame.origin.y = _lbl_titledonationAMT.frame.origin.y + _lbl_titledonationAMT.frame.size.height + 10;
            _lbl_currencyTYP.frame = final_frame;
            
            final_frame = _TXT_getamount.frame;
            final_frame.origin.y = _lbl_currencyTYP.frame.origin.y;
            _TXT_getamount.frame = final_frame;
            
            CGRect VW_frame = _VW_organisationdetail.frame;
            VW_frame.size.height = _lbl_currencyTYP.frame.origin.y + _lbl_currencyTYP.frame.size.height + 10;
            VW_frame.size.width = _scroll_Contents.frame.size.width;
            _VW_organisationdetail.frame = VW_frame;
            
            VW_frame = _VW_titladdress.frame;
            VW_frame.origin.y = _VW_organisationdetail.frame.origin.y + _VW_organisationdetail.frame.size.height;
            VW_frame.size.width = _scroll_Contents.frame.size.width;
            _VW_titladdress.frame = VW_frame;
            
            CGRect frame_old;
            frame_old = _lbl_address.frame;
            frame_old.origin.y= _VW_titladdress.frame.size.height+_VW_titladdress.frame.origin.y+10;
            _lbl_address.frame=frame_old;
            
            frame_old = _BTN_deposit.frame;
            frame_old.origin.y =  _lbl_address.frame.origin.y + _lbl_address.frame.size.height + 10;
            _BTN_deposit.frame=frame_old;
            
            original_height =  self.BTN_deposit.frame.origin.y + _BTN_deposit.frame.size.height + 20;
            
            //        [UIView beginAnimations:@"LeftFlip" context:nil];
            [UIView setAnimationDuration:0.5];
            _VW_address.frame=CGRectMake(_VW_titladdress.frame.origin.x,_VW_titladdress.frame.origin.y+60,self.scroll_Contents.frame.size.width,_VW_address.frame.size.height);
            [self.scroll_Contents addSubview:_VW_address];
            _VW_address.hidden=NO;
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_address cache:YES];
            [UIView commitAnimations];
            [UIView animateWithDuration:0.5 animations:^{
                
                /*Frame Change*/
                _lbl_address.hidden=YES;
                
                //            _proceed_TOPAY.frame=CGRectMake(_proceed_TOPAY.frame.origin.x
                //                                            ,  _VW_address.frame.origin.y+_VW_address.frame.size.height+10, _proceed_TOPAY.frame.size.width, _proceed_TOPAY.frame.size.height);
                
                _BTN_deposit.frame = CGRectMake(_BTN_deposit.frame.origin.x, _VW_address.frame.origin.y + _VW_address.frame.size.height + 15, _BTN_deposit.frame.size.width, _BTN_deposit.frame.size.height);
                
            }];
            [UIView commitAnimations];
            
            _BTN_edit.enabled=NO;
            
            original_height =  self.BTN_deposit.frame.origin.y + _BTN_deposit.frame.size.height + 20;
            [self viewDidLayoutSubviews];
        }
        else
        {
            CGRect final_frame = _TXTVW_organisationname.frame;
            final_frame.size.height = _TXTVW_organisationname.contentSize.height;
            _TXTVW_organisationname.frame = final_frame;
            
            final_frame = _lbl_titledonationAMT.frame;
            final_frame.origin.y = _TXTVW_organisationname.frame.origin.y + _TXTVW_organisationname.frame.size.height + 10;
            _lbl_titledonationAMT.frame = final_frame;
            
            final_frame = _lbl_currencyTYP.frame;
            final_frame.origin.y = _lbl_titledonationAMT.frame.origin.y + _lbl_titledonationAMT.frame.size.height + 10;
            _lbl_currencyTYP.frame = final_frame;
            
            final_frame = _TXT_getamount.frame;
            final_frame.origin.y = _lbl_currencyTYP.frame.origin.y;
            _TXT_getamount.frame = final_frame;
            
            CGRect VW_frame = _VW_organisationdetail.frame;
            VW_frame.size.height = _lbl_currencyTYP.frame.origin.y + _lbl_currencyTYP.frame.size.height + 10;
            VW_frame.size.width = _scroll_Contents.frame.size.width;
            _VW_organisationdetail.frame = VW_frame;
            
            VW_frame = _VW_titladdress.frame;
            VW_frame.origin.y = _VW_organisationdetail.frame.origin.y + _VW_organisationdetail.frame.size.height;
            VW_frame.size.width = _scroll_Contents.frame.size.width;
            _VW_titladdress.frame = VW_frame;
            
            CGRect frame_old;
            frame_old = _lbl_address.frame;
            frame_old.origin.y= _VW_titladdress.frame.size.height+_VW_titladdress.frame.origin.y+10;
            _lbl_address.frame=frame_old;
            
            frame_old = _BTN_deposit.frame;
            frame_old.origin.y =  _lbl_address.frame.origin.y + _lbl_address.frame.size.height + 10;
            _BTN_deposit.frame=frame_old;
            
            _VW_address.frame=CGRectMake(0, self.self.VW_titladdress.frame.origin.y+self.VW_titladdress.frame.size.height+10, self.scroll_Contents.frame.size.width, self.VW_address.frame.size.height);
            _VW_address.hidden=YES;
        }
        [[NSUserDefaults standardUserDefaults] setValue:[self.arr objectAtIndex:0] forKey:@"event_id_donate"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        self.TXTVW_organisationname.text=[self.arr objectAtIndex:1];
    }
}

- (IBAction)tappedToSelectRow:(UITapGestureRecognizer *)tapRecognizer
{
    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat rowHeight = [_contry_pickerView rowSizeForComponent:0].height;
        CGRect selectedRowFrame = CGRectInset(_contry_pickerView.bounds, 0.0, (CGRectGetHeight(_contry_pickerView.frame) - rowHeight) / 2.0 );
        BOOL userTappedOnSelectedRow = (CGRectContainsPoint(selectedRowFrame, [tapRecognizer locationInView:_contry_pickerView]));
        if (userTappedOnSelectedRow) {
            NSInteger selectedRow = [_contry_pickerView selectedRowInComponent:0];
            [self pickerView:_contry_pickerView didSelectRow:selectedRow inComponent:0];
        }
    }
}
- (IBAction)tappedToSelectRowstate:(UITapGestureRecognizer *)tapRecognizer
{
    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat rowHeight = [_state_pickerView rowSizeForComponent:0].height;
        CGRect selectedRowFrame = CGRectInset(_state_pickerView.bounds, 0.0, (CGRectGetHeight(_state_pickerView.frame) - rowHeight) / 2.0 );
        BOOL userTappedOnSelectedRow = (CGRectContainsPoint(selectedRowFrame, [tapRecognizer locationInView:_state_pickerView]));
        if (userTappedOnSelectedRow) {
            NSInteger selectedRow = [_state_pickerView selectedRowInComponent:0];
            [self pickerView:_state_pickerView didSelectRow:selectedRow inComponent:0];
        }
    }
}
- (IBAction)tappedToSelectOrganisation:(UITapGestureRecognizer *)tapRecognizer
{
    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat rowHeight = [_organisation_list rowSizeForComponent:0].height;
        CGRect selectedRowFrame = CGRectInset(_organisation_list.bounds, 0.0, (CGRectGetHeight(_organisation_list.frame) - rowHeight) / 2.0 );
        BOOL userTappedOnSelectedRow = (CGRectContainsPoint(selectedRowFrame, [tapRecognizer locationInView:_organisation_list]));
        if (userTappedOnSelectedRow) {
            NSInteger selectedRow = [_organisation_list selectedRowInComponent:0];
            [self pickerView:_organisation_list didSelectRow:selectedRow inComponent:0];
        }
    }
    if(_VW_address.hidden == NO)
    {
        
        CGRect final_frame = _TXTVW_organisationname.frame;
        final_frame.size.height = _TXTVW_organisationname.contentSize.height;
        _TXTVW_organisationname.frame = final_frame;
        
        final_frame = _lbl_titledonationAMT.frame;
        final_frame.origin.y = _TXTVW_organisationname.frame.origin.y + _TXTVW_organisationname.frame.size.height + 10;
        _lbl_titledonationAMT.frame = final_frame;
        
        final_frame = _lbl_currencyTYP.frame;
        final_frame.origin.y = _lbl_titledonationAMT.frame.origin.y + _lbl_titledonationAMT.frame.size.height + 10;
        _lbl_currencyTYP.frame = final_frame;
        
        final_frame = _TXT_getamount.frame;
        final_frame.origin.y = _lbl_currencyTYP.frame.origin.y;
        _TXT_getamount.frame = final_frame;
        
        CGRect VW_frame = _VW_organisationdetail.frame;
        VW_frame.size.height = _lbl_currencyTYP.frame.origin.y + _lbl_currencyTYP.frame.size.height + 10;
        VW_frame.size.width = _scroll_Contents.frame.size.width;
        _VW_organisationdetail.frame = VW_frame;
        
        VW_frame = _VW_titladdress.frame;
        VW_frame.origin.y = _VW_organisationdetail.frame.origin.y + _VW_organisationdetail.frame.size.height;
        VW_frame.size.width = _scroll_Contents.frame.size.width;
        _VW_titladdress.frame = VW_frame;
        
        CGRect frame_old;
        frame_old = _lbl_address.frame;
        frame_old.origin.y= _VW_titladdress.frame.size.height+_VW_titladdress.frame.origin.y+10;
        _lbl_address.frame=frame_old;
        
        frame_old = _BTN_deposit.frame;
        frame_old.origin.y =  _lbl_address.frame.origin.y + _lbl_address.frame.size.height + 10;
        _BTN_deposit.frame=frame_old;
        
        original_height =  self.BTN_deposit.frame.origin.y + _BTN_deposit.frame.size.height + 20;
        
        
        
//        [UIView beginAnimations:@"LeftFlip" context:nil];
        [UIView setAnimationDuration:0.5];
        _VW_address.frame=CGRectMake(_VW_titladdress.frame.origin.x,_VW_titladdress.frame.origin.y+60,self.scroll_Contents.frame.size.width,_VW_address.frame.size.height);
        [self.scroll_Contents addSubview:_VW_address];
        _VW_address.hidden=NO;
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_address cache:YES];
        [UIView commitAnimations];
        [UIView animateWithDuration:0.5 animations:^{
            
            /*Frame Change*/
            _lbl_address.hidden=YES;
            
            //            _proceed_TOPAY.frame=CGRectMake(_proceed_TOPAY.frame.origin.x
            //                                            ,  _VW_address.frame.origin.y+_VW_address.frame.size.height+10, _proceed_TOPAY.frame.size.width, _proceed_TOPAY.frame.size.height);
            
            _BTN_deposit.frame = CGRectMake(_BTN_deposit.frame.origin.x, _VW_address.frame.origin.y + _VW_address.frame.size.height + 15, _BTN_deposit.frame.size.width, _BTN_deposit.frame.size.height);
            
        }];
        [UIView commitAnimations];
        
        _BTN_edit.enabled=NO;
        
        original_height =  self.BTN_deposit.frame.origin.y + _BTN_deposit.frame.size.height + 20;
        [self viewDidLayoutSubviews];
    }
    else
    {
        CGRect final_frame = _TXTVW_organisationname.frame;
        final_frame.size.height = _TXTVW_organisationname.contentSize.height;
        _TXTVW_organisationname.frame = final_frame;
        
        final_frame = _lbl_titledonationAMT.frame;
        final_frame.origin.y = _TXTVW_organisationname.frame.origin.y + _TXTVW_organisationname.frame.size.height + 10;
        _lbl_titledonationAMT.frame = final_frame;
        
        final_frame = _lbl_currencyTYP.frame;
        final_frame.origin.y = _lbl_titledonationAMT.frame.origin.y + _lbl_titledonationAMT.frame.size.height + 10;
        _lbl_currencyTYP.frame = final_frame;
        
        final_frame = _TXT_getamount.frame;
        final_frame.origin.y = _lbl_currencyTYP.frame.origin.y;
        _TXT_getamount.frame = final_frame;
        
        CGRect VW_frame = _VW_organisationdetail.frame;
        VW_frame.size.height = _lbl_currencyTYP.frame.origin.y + _lbl_currencyTYP.frame.size.height + 10;
        VW_frame.size.width = _scroll_Contents.frame.size.width;
        _VW_organisationdetail.frame = VW_frame;
        
        VW_frame = _VW_titladdress.frame;
        VW_frame.origin.y = _VW_organisationdetail.frame.origin.y + _VW_organisationdetail.frame.size.height;
        VW_frame.size.width = _scroll_Contents.frame.size.width;
        _VW_titladdress.frame = VW_frame;
        
        CGRect frame_old;
        frame_old = _lbl_address.frame;
        frame_old.origin.y= _VW_titladdress.frame.size.height+_VW_titladdress.frame.origin.y+10;
        _lbl_address.frame=frame_old;
        
        frame_old = _BTN_deposit.frame;
        frame_old.origin.y =  _lbl_address.frame.origin.y + _lbl_address.frame.size.height + 10;
        _BTN_deposit.frame=frame_old;
        
        _VW_address.frame=CGRectMake(0, self.self.VW_titladdress.frame.origin.y+self.VW_titladdress.frame.size.height+10, self.scroll_Contents.frame.size.width, self.VW_address.frame.size.height);
        _VW_address.hidden=YES;
    }
    [[NSUserDefaults standardUserDefaults] setValue:[self.arr objectAtIndex:0] forKey:@"event_id_donate"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    self.TXTVW_organisationname.text=[self.arr objectAtIndex:1];
}
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}


#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)Deposit_Pressed
{
    _VW_address.hidden=NO;
  /*if([_TXTVW_organisationname.text isEqualToString:@""])
  {
      [_TXTVW_organisationname becomeFirstResponder];
  }
    else if([_TXT_getamount.text isEqualToString:@""])
    {
        [_TXT_getamount becomeFirstResponder];
    }
    else
    {
    NSString *amount = _TXT_getamount.text;
       // int  k=[amount intValue];
        
        NSString *eventid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"event_id_donate"]];
       // int j=[eventid intValue];
        
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *number_amount = [f numberFromString:amount];
        NSNumber *number_eventID = [f numberFromString:eventid];
    
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
//        NSDictionary *parameters = @{ @"price": @10,
//                                      @"event_id": @55 };
        NSDictionary *parameters = @{ @"price":number_amount,
                                      @"event_id":number_eventID };
           NSLog(@"the post data is:%@",parameters);
//    self->activityIndicatorView.hidden=NO;
//    [self->activityIndicatorView startAnimating];
//    [self.view addSubview:activityIndicatorView];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&error];
    NSString *urlGetuser =[NSString stringWithFormat:@"%@contributors/create",SERVER_URL];
        NSLog(@"The url iS:%@",urlGetuser);
    
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"POST"];
        [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPBody:postData];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
//        self->activityIndicatorView.hidden=YES;
        NSMutableDictionary *json_DATA_one = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"error is:%@",error);
//        NSLog(@"The response %@",json_DATA_one);
        NSString *status=[json_DATA_one valueForKey:@"message"];
        if([status isEqualToString:@"Successfully donated."])
        {
            NSLog(@"The response %@",json_DATA_one);
            UIAlertController *alertcontrollerone=[UIAlertController alertControllerWithTitle: @"Details"message: @"Details Successfully Posted" preferredStyle:UIAlertControllerStyleAlert];
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
    
    
    
    else
    {
        
        UIAlertController *alertcontrollertwo=[UIAlertController alertControllerWithTitle: @"Server Not Coneected"message: @"Please Check your Connection."
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertcontrollertwo addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:alertcontrollertwo animated:YES completion:nil];
    }
    }*/
    
    NSLog(@"Sighn UP");
    NSString *text_to_compare=_TXT_phonenumber.text;
    NSString *phoneRegex = @"[0-9]{10,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    
    if([_TXTVW_organisationname.text isEqualToString:@""])
    {
        [_TXTVW_organisationname becomeFirstResponder];
    }
    else if([_TXT_getamount.text isEqualToString:@""])
    {
        [_TXT_getamount becomeFirstResponder];
    }
     else  if([_TXT_firstname.text isEqualToString:@""])
    {
        [_TXT_firstname becomeFirstResponder];
    }
    
    else  if([_TXT_lastname.text isEqualToString:@""])
    {
        [_TXT_lastname becomeFirstResponder];
        
    }
    else if([_TXT_address1.text isEqualToString:@""])
    {
        [_TXT_address1 becomeFirstResponder];
        
    }
    else  if([_TXT_address2.text isEqualToString:@""])
    {
        [_TXT_address2 becomeFirstResponder];
        
    }
    else if([_TXT_city.text isEqualToString:@""])
    {
        [_TXT_city becomeFirstResponder];
        
    }
    
    
    else if ([phoneTest evaluateWithObject:text_to_compare] == NO)
    {
        [_TXT_phonenumber becomeFirstResponder];
    }
    
    else if([_TXT_phonenumber.text isEqualToString:@""])
    {
        [_TXT_phonenumber becomeFirstResponder];
        
    }
    
    else if([_TXT_state.text isEqualToString:@""])
    {
        [_TXT_state becomeFirstResponder];
        
    }
    else if([_TXT_country.text isEqualToString:@""])
    {
        [_TXT_country becomeFirstResponder];
        
    }

    else
    {
        VW_overlay.hidden=NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(donatio_API) withObject:activityIndicatorView afterDelay:0.01];
    }
}
-(void)donatio_API
{
    NSString *fname = _TXT_firstname.text;
    NSString *lastName= _TXT_lastname.text;
    NSString *address1 = _TXT_address1.text;
    NSString *address2 = _TXT_address2.text;
    NSString *city = _TXT_city.text;
    NSString *country = _TXT_country.text;
    NSString *zip = _TXT_zip.text;
    NSString *state = _TXT_state.text;
    NSString *phonenumber = _TXT_phonenumber.text;
    
    NSString *state_code = [states valueForKey:state];
    NSString *country_code = [countryS valueForKey:country];
    
    NSString *amount = _TXT_getamount.text;
    NSString *eventid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"event_id_donate"]];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *number_amount = [f numberFromString:amount];
    NSNumber *number_eventID = [f numberFromString:eventid];
    
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSDictionary *parameters = @{ @"billing_address":@{@"first_name":fname,@"last_name":lastName,@"address_line1":address1,@"address_line2":address2,@"city":city,@"country":country_code,@"zip_code":zip,@"state":state_code,@"phone":phonenumber},@"event_id":number_eventID,@"price":number_amount };
    NSLog(@"the post data is:%@",parameters);
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&error];
    NSString *urlGetuser =[NSString stringWithFormat:@"%@contributors/donation_order",SERVER_URL];
    NSLog(@"The url iS:%@",urlGetuser);
    
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"POST"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPBody:postData];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        NSMutableDictionary *json_DATA_one = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"Data from Donate VC:%@",json_DATA_one);
        NSString *status=[json_DATA_one valueForKey:@"status"];
        if([status isEqualToString:@"Success"])
        {
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[json_DATA_one valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            //                [alert show];
            [self get_client_TOKEN];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[json_DATA_one valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        
    }
    else
    {
        VW_overlay.hidden = YES;
        [activityIndicatorView stopAnimating];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Check your Connection." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}



-(IBAction)TAP_done
{
    _PICK_state.hidden = YES;
    _TOOL_state.hidden = YES;
    
    NSLog(@"Done Tapped");
}

-(void) ACTION_state
{
    _PICK_state.hidden = NO;
    _TOOL_state.hidden = NO;
}

-(void) get_EVENTS
{
    _oraganisationpicker = [[[NSUserDefaults standardUserDefaults] valueForKey:@"eventsStored"] valueForKey:@"events"];
}


-(void) Tap_DTECt :(UITapGestureRecognizer *)sender
{
}
#pragma mark - Tap Gesture
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [_TXT_getamount resignFirstResponder];
    
    if ([touch.view isDescendantOfView:_BTN_edit]) {
        return NO;
    }
    else if ([touch.view isDescendantOfView:_BTN_deposit]) {
        return NO;
    }
    return YES;
}

#pragma mark - Generate Client Token
-(void) get_client_TOKEN
{
    NSError *error;
    NSHTTPURLResponse *response = nil;
    
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSString *urlGetuser = [NSString stringWithFormat:@"%@contributors/client_token",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        
        NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        
        NSLog(@"Client Token = %@",[dict valueForKey:@"client_token"]);
        VW_overlay.hidden = YES;
        [activityIndicatorView stopAnimating];
        
        self.braintree = [Braintree braintreeWithClientToken:[dict valueForKey:@"client_token"]];
        NSLog(@"dddd = %@",self.braintree);
        
        BTDropInViewController *dropInViewController = [self.braintree dropInViewControllerWithDelegate:self];
        // This is where you might want to customize your Drop in. (See below.)
        
        // The way you present your BTDropInViewController instance is up to you.
        // In this example, we wrap it in a new, modally presented navigation controller:
        dropInViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                              target:self
                                                                                                              action:@selector(userDidCancelPayment)];
        dropInViewController.view.tintColor = _BTN_deposit.backgroundColor;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dropInViewController];
        UIImage *new_image = [UIImage imageNamed:@"UI_01"];
        UIImageView *temp_IMG = [[UIImageView alloc]initWithFrame:navigationController.navigationBar.frame];
        temp_IMG.image = new_image;
        
        UIImage *newImage = [temp_IMG.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIGraphicsBeginImageContextWithOptions(temp_IMG.image.size, NO, newImage.scale);
        [[UIColor blackColor] set];
        [newImage drawInRect:CGRectMake(0, 0, temp_IMG.image.size.width, newImage.size.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        temp_IMG.image = newImage;
        
        [navigationController.navigationBar setBackgroundImage:temp_IMG.image
                                                 forBarMetrics:UIBarMetricsDefault];
        navigationController.navigationBar.shadowImage = [UIImage new];
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

-(void) create_payment
{
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSString *naunce_STR = [[NSUserDefaults standardUserDefaults] valueForKey:@"NAUNCETOK"];
    NSDictionary *parameters = @{ @"nonce":naunce_STR};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&error];
    NSString *urlGetuser =[NSString stringWithFormat:@"%@payments/create",SERVER_URL];
    NSLog(@"The url iS:%@",urlGetuser);
    
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"POST"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPBody:postData];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        NSMutableDictionary *json_DATA_one = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"Data from Donate VC generate client TOK : \n%@",json_DATA_one);
    }
}

#pragma mark - Braintree Integration
- (void)dropInViewController:(__unused BTDropInViewController *)viewController didSucceedWithPaymentMethod:(BTPaymentMethod *)paymentMethod {
    [self postNonceToServer:paymentMethod.nonce]; // Send payment method nonce to your server
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dropInViewControllerDidCancel:(__unused BTDropInViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)userDidCancelPayment {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) postNonceToServer :(NSString *)str
{
    NSLog(@"Post %@",str);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nonce" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
    
    if (str)
    {
        [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"NAUNCETOK"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self create_payment];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Payment Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

@end

//
//  VC_billingAddr.m
//  WinningTicket
//
//  Created by Test User on 09/05/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_billingAddr.h"

@interface VC_billingAddr ()
{
    float original_height;
    float BTN_originY;
    
    CGRect lbl_origin_FRAME;
}
@property (nonatomic, strong) NSArray *countrypicker,*statepicker;
@property(nonatomic,strong)NSMutableDictionary *json_DATA;/*for getting the JSON data  */
@end

@implementation VC_billingAddr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSError *error;
//    NSMutableDictionary *json_DAT = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"state_response"] options:NSASCIIStringEncoding error:&error];
//    NSLog(@"The response %@",json_DAT);
//    self.ARR_states=[json_DAT allKeys];
  [self setup_VIEW];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width,original_height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Uiview Customisation
-(void) setup_VIEW
{
    
    
    
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

    
    
    NSError *error;
    NSMutableDictionary *user_data=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"User_data"] options:NSASCIIStringEncoding error:&error];
    NSLog(@"the user data is:%@",user_data);
    

    
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
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, anotherButton ] animated:NO];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    self.navigationItem.title = @"Add Recipient";
    
    self.lbl_name_ticket.text=@"Winning Ticket";
    int qtynum = [[[NSUserDefaults standardUserDefaults] valueForKey:@"QTY"]intValue];
    self.lbl_qty.text=[NSString stringWithFormat:@"Qty:%d",qtynum];
    
    NSString *show = @"Winning Ticket";
    NSString *place = @"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event";
    NSString *ticketnumber = @"56A8WQ";
    NSString *club_name = @"Grand Cypress Country Club";
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@\n%@ - %@",show,place,ticketnumber,club_name];
    
    text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
    text = [text stringByReplacingOccurrencesOfString:@"(null)" withString:@"Not Mentioned"];
    
    if ([self.lbl_des_cription respondsToSelector:@selector(setAttributedText:)])
    {
    NSDictionary *attribs = @{
                                 NSForegroundColorAttributeName: self.lbl_des_cription.textColor,
                                 NSFontAttributeName: self.lbl_des_cription.font
                              };
    NSMutableAttributedString *attributedText =
       [[NSMutableAttributedString alloc] initWithString:text
                                                   attributes:attribs];
    

    NSRange plce = [text rangeOfString:place];
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]}range:plce];
    self.lbl_des_cription.attributedText = attributedText;
    }
    else
    {
        self.lbl_des_cription.text = text;
    }
    
    _lbl_des_cription.numberOfLines = 0;
    [_lbl_des_cription sizeToFit];
    original_height= _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 40;
    CGRect frame_NEW;
    
    frame_NEW = _VW_line1.frame;
    frame_NEW.origin.y = _lbl_des_cription.frame.origin.y + _lbl_des_cription.frame.size.height + 10;
    _VW_line1.frame = frame_NEW;
    
    frame_NEW = _lbl_sub_total.frame;
    frame_NEW.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
    _lbl_sub_total.frame = frame_NEW;
    
    frame_NEW = _lbl_sub_amount.frame;
    frame_NEW.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
    _lbl_sub_amount.frame = frame_NEW;
    
    frame_NEW = _VW_line2.frame;
    frame_NEW.origin.y = _lbl_sub_total.frame.origin.y + _lbl_sub_total.frame.size.height + 10;
    _VW_line2.frame = frame_NEW;
    
    frame_NEW = _lbl_total.frame;
    frame_NEW.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
    _lbl_total.frame = frame_NEW;
    
    frame_NEW = _lbl_total_amount.frame;
    frame_NEW.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
    _lbl_total_amount.frame = frame_NEW;
    
    frame_NEW = _VW_main.frame;
    frame_NEW.size.height = _lbl_total.frame.origin.y + _VW_line2.frame.size.height + 15;
    _VW_main.frame = frame_NEW;
    
    float heiht1 = _VW_main.frame.size.height;
    
    self.VW_main.frame = CGRectMake(0,0,
                                    self.scroll_contents.bounds.size.width,_lbl_des_cription.frame.size.height);
    [self.scroll_contents addSubview:self.VW_main];
    
    _lbl_agree.text = @"You will not be charged until you confirm your order";
    _lbl_agree.numberOfLines = 0;
    [_lbl_agree sizeToFit];
    
    [_BTN_edit addTarget:self action:@selector(edit_BTN_action:) forControlEvents:UIControlEventTouchUpInside];
    
    frame_NEW = _VW_titladdress.frame;
    frame_NEW.origin.y = _scroll_contents.frame.origin.y + heiht1;
    frame_NEW.size.width = _scroll_contents.frame.size.width;
    _VW_titladdress.frame = frame_NEW;
    [self.scroll_contents addSubview:self.VW_titladdress];
    
    NSString *address_str=[NSString stringWithFormat:@"%@ %@\n%@,%@\n%@,%@\n%@%@",[user_data valueForKey:@"first_name"],[user_data valueForKey:@"last_name"],[user_data valueForKey:@"address1"],[user_data valueForKey:@"address2"],[user_data valueForKey:@"city"],[user_data valueForKey:@"state"],[user_data valueForKey:@"country"],[user_data valueForKey:@"zipcode"]];
    
    _lbl_address.text = address_str;
    [_lbl_address sizeToFit];
    
    frame_NEW=_lbl_address.frame;
    frame_NEW.origin.x=_VW_titladdress.frame.origin.x+10;
    frame_NEW.origin.y=_VW_titladdress.frame.origin.y+_VW_titladdress.frame.size.height+10;
    _lbl_address.frame=frame_NEW;
    
    frame_NEW = _lbl_agree.frame;
    
    frame_NEW.origin.y = _lbl_address.frame.origin.y + _lbl_address.frame.size.height + 25;
    _lbl_agree.frame = frame_NEW;

    [_BTN_checkout addTarget:self action:@selector(chckout_ACtin:) forControlEvents:UIControlEventTouchUpInside];
    
    frame_NEW = _BTN_checkout.frame;
    
    frame_NEW.origin.y = _lbl_agree.frame.origin.y + _lbl_agree.frame.size.height + 20;
    _BTN_checkout.frame = frame_NEW;
    
    _VW_address.frame=CGRectMake(_VW_titladdress.frame.origin.x,_VW_titladdress.frame.origin.y+60,self.scroll_contents.frame.size.width,_VW_address.frame.size.height);
    [self.scroll_contents addSubview:_VW_address];
    _VW_address.hidden=YES;
    
    _contry_pickerView = [[UIPickerView alloc] init];
    _contry_pickerView.delegate = self;
    _contry_pickerView.dataSource = self;

    _state_pickerView=[[UIPickerView alloc]init];
    _state_pickerView.dataSource=self;
    _state_pickerView.delegate=self;
    
    
    
    UITapGestureRecognizer *tapToSelect = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(tappedToSelectRow:)];
    tapToSelect.delegate = self;
    [_contry_pickerView addGestureRecognizer:tapToSelect];
    
    _TXT_country.inputView=_contry_pickerView;
    
    UITapGestureRecognizer *satetap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(tappedToSelectRowstate:)];
    satetap.delegate = self;
    [_state_pickerView addGestureRecognizer:satetap];

    
    
    
    UIToolbar* conutry_close = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    conutry_close.barStyle = UIBarStyleBlackTranslucent;
    [conutry_close sizeToFit];
    
    UIButton *btn=[[UIButton alloc]init];
    btn.frame=CGRectMake(conutry_close.frame.size.width - 100, 0, 100, conutry_close.frame.size.height);
    [btn setTitle:@"close" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [numberToolbar setItems:[NSArray arrayWithObjects:close, nil]];
    [conutry_close addSubview:btn];
    _TXT_country.inputAccessoryView=conutry_close;
    

    
    
    
    UIToolbar* state_close = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    state_close.barStyle = UIBarStyleBlackTranslucent;
    [state_close sizeToFit];
//    UILabel *statelbl=[[UILabel alloc]initWithFrame:CGRectMake(state_close.frame.size.width-250, 0, 100, state_close.frame.size.height)];
//    [state_close addSubview:statelbl];
//    statelbl.text=@"Select State";
//    statelbl.textColor=[UIColor redColor];
//    statelbl.backgroundColor=[UIColor clearColor];
    
    UIButton *close=[[UIButton alloc]init];
    close.frame=CGRectMake(state_close.frame.size.width - 100, 0, 100, state_close.frame.size.height);
    [close setTitle:@"close" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [numberToolbar setItems:[NSArray arrayWithObjects:close, nil]];
    [state_close addSubview:close];
    _TXT_state.inputView=_state_pickerView;
    _TXT_state.inputAccessoryView=state_close;
    
    [self Country_api];
    [self State_api];

    
}
-(void)closebuttonClick
{
    [_TXT_state resignFirstResponder];
    [_TXT_country resignFirstResponder];
}


#pragma mark - button Selectors
-(void) backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void) edit_BTN_action : (id) sender
{
    if(_VW_address.hidden==YES)
    {
        
        lbl_origin_FRAME = _lbl_agree.frame;
        BTN_originY = _BTN_checkout.frame.origin.y;
        
        
        [UIView beginAnimations:@"LeftFlip" context:nil];
        [UIView setAnimationDuration:0.5];
        _VW_address.frame=CGRectMake(_VW_titladdress.frame.origin.x,_VW_titladdress.frame.origin.y+60,self.scroll_contents.frame.size.width,_VW_address.frame.size.height);
        [self.scroll_contents addSubview:_VW_address];
        _VW_address.hidden=NO;
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_address cache:YES];
        [UIView commitAnimations];
        [UIView animateWithDuration:0.5 animations:^{
            _lbl_address.hidden=YES;
            _lbl_agree.frame = CGRectMake(_lbl_agree.frame.origin.x, _VW_address.frame.origin.y + _VW_address.frame.size.height+10 , _lbl_agree.frame.size.width, _lbl_agree.frame.size.height+10);
            _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _lbl_agree.frame.origin.y + _lbl_agree.frame.size.height + 10, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
        }];
        [UIView commitAnimations];
        original_height =  self.BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 20;
        [self viewDidLayoutSubviews];

    }
    else{
//        [self hideview];
        original_height = original_height - 100;
        _lbl_address.hidden=NO;
        [self viewDidLayoutSubviews];
    }

}

-(void)hideview
{
    lbl_origin_FRAME.origin.y = _VW_address.frame.origin.y;
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.5];
    _VW_address.hidden=YES;
    [UIView transitionWithView:_VW_address
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:NULL
                    completion:NULL];
  
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_address cache:YES];
    [UIView commitAnimations];
    [UIView animateWithDuration:0.5 animations:^{
        
        
        _lbl_agree.frame = lbl_origin_FRAME;
        _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, BTN_originY, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
    }];
    [UIView commitAnimations];
}



-(void) chckout_ACtin : (id) sender
{
    NSLog(@"Chekout Tapped");
    
    [self performSegueWithIdentifier:@"billaddretocheckoutdetail" sender:self];
}
#pragma mark textfieldDelegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
       [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag==3)
    {
        [textField setTintColor:[UIColor whiteColor]];
        //if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        // {
        //Keyboard becomes visible
        [UIView beginAnimations:nil context:NULL];
        // [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
        //}
    }
    if(textField.tag==8)
    {
        [textField setTintColor:[UIColor whiteColor]];
        //if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        // {
        //Keyboard becomes visible
        [UIView beginAnimations:nil context:NULL];
        // [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
        //}
    }

    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==8)
    {
        [UIView beginAnimations:nil context:NULL];
   
        self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
                [UIView beginAnimations:nil context:NULL];
  
        self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }
}
#pragma mark - UIPickerViewDataSource

// #3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == _contry_pickerView) {
        return 1;
    }if(pickerView==_state_pickerView)
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
    self.json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
    NSLog(@"The response %@",self.json_DATA);
    self.countrypicker=[self.json_DATA allKeys];
    
   
    
    
}
-(void)State_api
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@city_states/states?country=%@",SERVER_URL,[self.json_DATA valueForKey:_TXT_country.text]];
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
    self.statepicker=[json_DATA allKeys];
    
    
}

#pragma mark - UIPickerViewDelegate


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == _contry_pickerView) {
        return self.countrypicker[row];
    }
    if (pickerView == _state_pickerView) {
        return self.statepicker[row];
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
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}
@end

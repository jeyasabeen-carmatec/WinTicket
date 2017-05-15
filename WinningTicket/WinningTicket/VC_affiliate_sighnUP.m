//
//  VC_affiliate_sighnUP.m
//  WinningTicket
//
//  Created by Test User on 17/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_affiliate_sighnUP.h"

@interface VC_affiliate_sighnUP ()<UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) NSArray *countrypicker,*statepicker;
@property(nonatomic,strong)NSMutableDictionary *json_DATA;/*for getting the JSON data  */


@end

@implementation VC_affiliate_sighnUP

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setup_VIEW];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
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
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, anotherButton ] animated:NO];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, _IMG_BG.frame.origin.y + _IMG_BG.frame.size.height + 5 + _IMG_logo_WT.frame.size.height + 40);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Customise View
-(void) setup_VIEW
{
    CGRect frame = _VW_contents.frame;
    frame.size.width = self.navigationController.navigationBar.frame.size.width - 20;
    _VW_contents.frame = frame;
    frame.origin.x = 10.0f;
    frame.origin.y = self.navigationController.navigationBar.frame.size.height;
    CGRect new_frame = [UIScreen mainScreen].bounds;
//    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
//    {
//        frame.origin.y = 288.0f;
//    }
    frame.size.height = new_frame.origin.y + new_frame.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    _scroll_contents.frame = frame;
    
    new_frame = _IMG_logo_WT.frame;
    new_frame.origin.y = 0;
    new_frame.origin.x = _scroll_contents.frame.size.width/2 - _IMG_logo_WT.frame.size.width/2;
    _IMG_logo_WT.frame = new_frame;
    
    [_scroll_contents addSubview:_IMG_logo_WT];
    
    new_frame = _VW_contents.frame;
    new_frame.origin.y = _IMG_logo_WT.frame.size.height + 20;
    _VW_contents.frame = new_frame;
    
    [_scroll_contents addSubview:_VW_contents];
    
//    _TXT_phone_num.layer.cornerRadius = 5.0f;
//    _TXT_phone_num.layer.masksToBounds = YES;
//    _TXT_phone_num.layer.borderWidth = 2.0f;
//    _TXT_phone_num.layer.borderColor = [UIColor whiteColor].CGColor;
//    
    
    _TXT_golfcoursename.layer.cornerRadius = 5.0f;
    _TXT_golfcoursename.layer.masksToBounds = YES;
    _TXT_golfcoursename.layer.borderWidth = 2.0f;
    _TXT_golfcoursename.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_golfcoursename.tag=1;
    _TXT_golfcoursename.delegate=self;
    
    _TXT_F_name.layer.cornerRadius = 5.0f;
    _TXT_F_name.layer.masksToBounds = YES;
    _TXT_F_name.layer.borderWidth = 2.0f;
    _TXT_F_name.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_F_name.tag=2;
    _TXT_F_name.delegate=self;
//    _TXT_F_name.enabled=NO;


    _TXT_L_name.layer.cornerRadius = 5.0f;
    _TXT_L_name.layer.masksToBounds = YES;
    _TXT_L_name.layer.borderWidth = 2.0f;
    _TXT_L_name.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_L_name.tag=3;
    _TXT_L_name.delegate=self;
//    _TXT_L_name.enabled=NO;


    _TXT_titl.layer.cornerRadius = 5.0f;
    _TXT_titl.layer.masksToBounds = YES;
    _TXT_titl.layer.borderWidth = 2.0f;
    _TXT_titl.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_titl.tag=4;
    _TXT_titl.delegate=self;
//    _TXT_titl.enabled=NO;


    _TXT_addr1.layer.cornerRadius = 5.0f;
    _TXT_addr1.layer.masksToBounds = YES;
    _TXT_addr1.layer.borderWidth = 2.0f;
    _TXT_addr1.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_addr1.tag=5;
    _TXT_addr1.delegate=self;
//    _TXT_addr1.enabled=NO;

    
    _TXT_addr2.layer.cornerRadius = 5.0f;
    _TXT_addr2.layer.masksToBounds = YES;
    _TXT_addr2.layer.borderWidth = 2.0f;
    _TXT_addr2.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_addr2.tag=6;
    _TXT_addr2.delegate=self;
//    _TXT_addr2.enabled=NO;

    
    _TXT_city.layer.cornerRadius = 5.0f;
    _TXT_city.layer.masksToBounds = YES;
    _TXT_city.layer.borderWidth = 2.0f;
    _TXT_city.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_city.tag=7;
    _TXT_city.delegate=self;
//    _TXT_city.enabled=NO;


    
    _TXT_phone_num.layer.cornerRadius = 5.0f;
    _TXT_phone_num.layer.masksToBounds = YES;
    _TXT_phone_num.layer.borderWidth = 2.0f;
    _TXT_phone_num.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_phone_num.tag=8;
    _TXT_phone_num.delegate=self;
//    _TXT_phone_num.enabled=NO;


    _TXT_country.layer.cornerRadius = 5.0f;
    _TXT_country.layer.masksToBounds = YES;
    _TXT_country.layer.borderWidth = 2.0f;
    _TXT_country.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_country.tag=9;
    _TXT_country.delegate=self;
//    _TXT_country.enabled=NO;


    
    _TXT_state.layer.cornerRadius = 5.0f;
    _TXT_state.layer.masksToBounds = YES;
    _TXT_state.layer.borderWidth = 2.0f;
    _TXT_state.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_state.tag=10;
    _TXT_state.delegate=self;
//    _TXT_state.enabled=NO;


    _TXT_zip.layer.cornerRadius = 5.0f;
    _TXT_zip.layer.masksToBounds = YES;
    _TXT_zip.layer.borderWidth = 2.0f;
    _TXT_zip.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_zip.tag=11;
    _TXT_zip.delegate=self;
//    _TXT_zip.enabled=NO;


    _TXT_email.layer.cornerRadius = 5.0f;
    _TXT_email.layer.masksToBounds = YES;
    _TXT_email.layer.borderWidth = 2.0f;
    _TXT_email.layer.borderColor = [UIColor whiteColor].CGColor;
    _TXT_email.tag=12;
    _TXT_email.delegate=self;
//    _TXT_email.enabled=NO;

    
    [_BTN_sighnUP addTarget:self action:@selector(btn_sign_up) forControlEvents:UIControlEventTouchUpInside];
    
    
    
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

    
    UIToolbar* conutry_close = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    conutry_close.barStyle = UIBarStyleBlackTranslucent;
    [conutry_close sizeToFit];
    
    UIButton *close=[[UIButton alloc]init];
    close.frame=CGRectMake(conutry_close.frame.size.width - 100, 0, 100, conutry_close.frame.size.height);
    [close setTitle:@"close" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(countrybuttonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [numberToolbar setItems:[NSArray arrayWithObjects:close, nil]];
    [conutry_close addSubview:close];
    _TXT_country.inputAccessoryView=conutry_close;
    _TXT_state.inputAccessoryView=conutry_close;

    
    self.TXT_country.inputView = _contry_pickerView;
    self.TXT_state.inputView=_state_pickerView;
   


    _TXT_country.tintColor=[UIColor clearColor];
    _TXT_state.tintColor=[UIColor clearColor];
    
//    self.pickerNames = @[ @"Objective-C", @"Swift", @"Java", @"C", @"C++", @"Other"];
    [self Country_api];
//    [self State_api];
    
}

-(void)countrybuttonClick
{
    [self.TXT_country resignFirstResponder];
    [self.TXT_state resignFirstResponder];
}


#pragma mark-TextField Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [_TXT_addr1 resignFirstResponder];
//    [_TXT_addr2 resignFirstResponder];
//    [_TXT_zip resignFirstResponder];
//    [_TXT_city resignFirstResponder];
//    [_TXT_phone_num resignFirstResponder];
//    [_TXT_country resignFirstResponder];
//    [_TXT_state resignFirstResponder];
//    [_TXT_email resignFirstResponder];
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
    if(textField.tag==11)
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
    if(textField.tag==12)
    {
        [textField setTintColor:[UIColor whiteColor]];
        //if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        // {
        //Keyboard becomes visible
        [UIView beginAnimations:nil context:NULL];
        // [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0,-140,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
        //}
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        if(textField.tag==1)
    {
        if(textField.text.length==0)
        {
            
        }
        NSInteger inte = textField.text.length;
        if (inte <2 && inte > 30)
        {
            return NO;
        }
        else
            _TXT_F_name.enabled=YES;
        return YES;
        
        
    }
    if(textField.tag==2)
    {
        NSInteger inte = textField.text.length;
        if (inte <2 && inte > 30)
        {
            return NO;
            
        }
        else
            _TXT_L_name.enabled=YES;
        return YES;
    }
    
    
    if(textField.tag==3)
    {
        NSInteger inte = textField.text.length;
        if (inte <2 && inte > 255)
        {
            return NO;
            
        }
        else
            _TXT_titl.enabled=YES;
        return YES;
        
    }
    if(textField.tag==4)
    {
        NSInteger inte = textField.text.length;
        if (inte <2 && inte > 255)
        {
            return NO;
            
        }
        else
            _TXT_addr1.enabled=YES;
        return YES;
    }
    if(textField.tag==5)
    {
        NSInteger inte = textField.text.length;
        if (inte <1 && inte > 255)
        {
            return NO;
            
        }
        else
            _TXT_addr2.enabled=YES;
        return YES;
    }
    if(textField.tag==6)
    {
        NSInteger inte = textField.text.length;
        if (inte <5 && inte > 30)
        {
            return NO;
            
        }
        else
            _TXT_city.enabled=YES;
        return YES;
    }
    
    if(textField.tag==7)
    {
        NSInteger inte = textField.text.length;
        if (inte <2 && inte > 30)
        {
            return NO;
            
        }
        else
            _TXT_phone_num.enabled=YES;
        return YES;
    }
    if(textField.tag==8)
    {
        NSInteger inte = textField.text.length;
        if (inte <2 && inte > 15)
        {
            return NO;
            
        }
        else
            _TXT_country.enabled=YES;
        return YES;
    }
    if(textField.tag==9)
    {
        NSInteger inte = textField.text.length;
        if (inte <2 && inte > 30)
        {
            return NO;
            
        }
        else
            _TXT_state.enabled=YES;
        return YES;
    }
    if(textField.tag==10)
    {
        NSInteger inte = textField.text.length;
        if (inte <2 && inte > 30)
        {
            return NO;
            
        }
        else
            _TXT_zip.enabled=YES;
        return YES;
    }
    if(textField.tag==11)
    {
        NSInteger inte = textField.text.length;
        if (inte <2 && inte > 30)
        {
            return NO;
            
        }
        else
            _TXT_email.enabled=YES;
        return YES;
    }

    
    
    
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==12)
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
#pragma mark - Button Actions
-(void) btn_sign_up
{
    NSLog(@"Sighn UP");
    NSString *text_to_compare=_TXT_phone_num.text;
    NSString *phoneRegex = @"[0-9]{10,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    if([_TXT_golfcoursename.text isEqualToString:@""])
    {
        [_TXT_golfcoursename becomeFirstResponder];
    }
    
    
    else if([_TXT_F_name.text isEqualToString:@""])
    {
        [_TXT_F_name becomeFirstResponder];
    }
    
    else  if([_TXT_L_name.text isEqualToString:@""])
    {
        [_TXT_L_name becomeFirstResponder];
        
    }
    else if([_TXT_titl.text isEqualToString:@""])
    {
        [_TXT_titl becomeFirstResponder];
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
    
    
    else if ([phoneTest evaluateWithObject:text_to_compare] == NO)
    {
        [_TXT_phone_num becomeFirstResponder];
    }
    
    else if([_TXT_phone_num.text isEqualToString:@""])
    {
        [_TXT_phone_num becomeFirstResponder];
        
    }
    else if([_TXT_country.text isEqualToString:@""])
    {
        [_TXT_country becomeFirstResponder];
    }
    
    else if([_TXT_state.text isEqualToString:@""])
    {
        [_TXT_state becomeFirstResponder];
        
    }
    else if([_TXT_zip.text isEqualToString:@""])
    {
        [_TXT_zip becomeFirstResponder];
        
    }
    
    else if([_TXT_email.text isEqualToString:@""])
    {
        [_TXT_email becomeFirstResponder];
        
    }

    else{
        
//        [self api_integration];
        NSLog(@"Validation are aperfect:");
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
    _json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
    NSLog(@"The response %@",_json_DATA);
    self.countrypicker=[_json_DATA allKeys];
    
    
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
        self.TXT_zip.enabled=YES;
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

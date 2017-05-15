//
//  VC_donate.m
//  WinningTicket
//
//  Created by Test User on 31/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_donate.h"

@interface VC_donate ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) NSArray *countrypicker,*statepicker;

@property(nonatomic,strong)NSMutableDictionary *json_DATA;/*for getting the JSON data  */

@end

@implementation VC_donate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSError *error;
//    NSMutableDictionary *json_DAT = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"state_response"] options:NSASCIIStringEncoding error:&error];
//    NSLog(@"The response %@",json_DAT);
//    self.ARR_states=[json_DAT allKeys];
    
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
        _scroll_Contents.contentSize = CGSizeMake(_scroll_Contents.frame.size.width, _VW_contents.frame.size.height);
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
    CGRect contentframe = _VW_contents.frame;
    contentframe.size.width = _scroll_Contents.frame.size.width;
    _VW_contents.frame = contentframe;
    
    [_BTN_state addTarget:self action:@selector(ACTION_state) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *str_orgname = @"Make A Wish Foundation of Central Florida";
    _TXTVW_organisationname.text = str_orgname;

    _TXT_getamount.layer.cornerRadius = 5.0f;
    _TXT_getamount.layer.masksToBounds = YES;
    _TXT_getamount.layer.borderWidth = 2.0f;
    _TXT_getamount.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    
    CGRect _f = self.TXTVW_organisationname.frame;
    _f.size.height = self.TXTVW_organisationname.contentSize.height;
    self.TXTVW_organisationname.frame = _f;
    
    float framehight = _TXTVW_organisationname.frame.origin.y + _TXTVW_organisationname.frame.size.height;
    
    CGRect frame_new;
    
    
    
    frame_new = _lbl_titledonationAMT.frame;
    frame_new.origin.y = _lbl_titledonationAMT.frame.origin.y + framehight;
    _lbl_titledonationAMT.frame = frame_new;
    
    frame_new = _lbl_currencyTYP.frame;
    frame_new.origin.y = _lbl_currencyTYP.frame.origin.y + framehight;
    _lbl_currencyTYP.frame = frame_new;
    
    frame_new = _TXT_getamount.frame;
    frame_new.origin.y = _TXT_getamount.frame.origin.y + framehight;
    _TXT_getamount.frame = frame_new;
    
    frame_new = _VW_organisationdetail.frame;
    frame_new.size.height = _VW_organisationdetail.frame.size.height + framehight;
//    frame_new.size.width = _scroll_Contents.frame.size.width;
    _VW_organisationdetail.frame = frame_new;
    
    
    frame_new = _lbl_titlbillingaddress.frame;
    frame_new.origin.y = _lbl_titlbillingaddress.frame.origin.y + framehight;
    _lbl_titlbillingaddress.frame = frame_new;
    
    _TXT_firstname.layer.cornerRadius = 5.0f;
    _TXT_firstname.layer.masksToBounds = YES;
    _TXT_firstname.layer.borderWidth = 2.0f;
    _TXT_firstname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_firstname.backgroundColor = [UIColor whiteColor];
    frame_new = _TXT_firstname.frame;
    frame_new.origin.y = _TXT_firstname.frame.origin.y + framehight;
    _TXT_firstname.frame = frame_new;
    
    _TXT_lastname.layer.cornerRadius = 5.0f;
    _TXT_lastname.layer.masksToBounds = YES;
    _TXT_lastname.layer.borderWidth = 2.0f;
    _TXT_lastname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_lastname.backgroundColor = [UIColor whiteColor];
    frame_new = _TXT_lastname.frame;
    frame_new.origin.y = _TXT_lastname.frame.origin.y + framehight;
    _TXT_lastname.frame = frame_new;
    
    _TXT_address1.layer.cornerRadius = 5.0f;
    _TXT_address1.layer.masksToBounds = YES;
    _TXT_address1.layer.borderWidth = 2.0f;
    _TXT_address1.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_address1.backgroundColor = [UIColor whiteColor];
    frame_new = _TXT_address1.frame;
    frame_new.origin.y = _TXT_address1.frame.origin.y + framehight;
    _TXT_address1.frame = frame_new;
    
    _TXT_address2.layer.cornerRadius = 5.0f;
    _TXT_address2.layer.masksToBounds = YES;
    _TXT_address2.layer.borderWidth = 2.0f;
    _TXT_address2.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_address2.backgroundColor = [UIColor whiteColor];
    frame_new = _TXT_address2.frame;
    frame_new.origin.y = _TXT_address2.frame.origin.y + framehight;
    _TXT_address2.frame = frame_new;
    
    _TXT_city.layer.cornerRadius = 5.0f;
    _TXT_city.layer.masksToBounds = YES;
    _TXT_city.layer.borderWidth = 2.0f;
    _TXT_city.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_city.backgroundColor = [UIColor whiteColor];
    frame_new = _TXT_city.frame;
    frame_new.origin.y = _TXT_city.frame.origin.y + framehight;
    _TXT_city.frame = frame_new;
    
    _TXT_country.layer.cornerRadius = 5.0f;
    _TXT_country.layer.masksToBounds = YES;
    _TXT_country.layer.borderWidth = 2.0f;
    _TXT_country.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_country.backgroundColor = [UIColor whiteColor];
    _TXT_country.tag=5;
    frame_new = _TXT_country.frame;
    frame_new.origin.y = _TXT_country.frame.origin.y + framehight;
    _TXT_country.frame = frame_new;

    
    _TXT_state.layer.cornerRadius = 5.0f;
    _TXT_state.layer.masksToBounds = YES;
    _TXT_state.layer.borderWidth = 2.0f;
    _TXT_state.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_state.backgroundColor = [UIColor whiteColor];
    frame_new = _TXT_state.frame;
    frame_new.origin.y = _TXT_state.frame.origin.y + framehight;
    _TXT_state.frame = frame_new;
    
    _TXT_zip.layer.cornerRadius = 5.0f;
    _TXT_zip.layer.masksToBounds = YES;
    _TXT_zip.layer.borderWidth = 2.0f;
    _TXT_zip.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_zip.backgroundColor = [UIColor whiteColor];
    frame_new = _TXT_zip.frame;
    frame_new.origin.y = _TXT_zip.frame.origin.y + framehight;
    _TXT_zip.frame = frame_new;
    
    _TXT_phonenumber.layer.cornerRadius = 5.0f;
    _TXT_phonenumber.layer.masksToBounds = YES;
    _TXT_phonenumber.layer.borderWidth = 2.0f;
    _TXT_phonenumber.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_phonenumber.backgroundColor = [UIColor whiteColor];
    frame_new = _TXT_phonenumber.frame;
    frame_new.origin.y = _TXT_phonenumber.frame.origin.y + framehight;
    _TXT_phonenumber.frame = frame_new;
    
    frame_new = _BTN_deposit.frame;
    frame_new.origin.y = _BTN_deposit.frame.origin.y + framehight;
    _BTN_deposit.frame = frame_new;
    
    frame_new = _BTN_state.frame;
    frame_new.origin.y = _BTN_state.frame.origin.y + framehight;
    _BTN_state.frame = frame_new;
    
    frame_new = _lbl_dropdown.frame;
    frame_new.origin.y = _lbl_dropdown.frame.origin.y + framehight;
    _lbl_dropdown.frame = frame_new;
    
    contentframe = _VW_contents.frame;
    contentframe.size.height = _BTN_deposit.frame.origin.y + _BTN_deposit.frame.size.height + 20;
    _VW_contents.frame = contentframe;
    
    [_scroll_Contents addSubview:_VW_contents];
    
    _PICK_state.hidden = YES;
    _TOOL_state.hidden = YES;
    
    _state_pickerView=[[UIPickerView alloc]init];
    _state_pickerView.dataSource=self;
    _state_pickerView.delegate=self;
    
    
    
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
    [close addTarget:self action:@selector(closebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [numberToolbar setItems:[NSArray arrayWithObjects:close, nil]];
    [conutry_close addSubview:close];
    _TXT_country.inputAccessoryView=conutry_close;
    _TXT_state.inputAccessoryView=conutry_close;
    self.TXT_country.inputView = _contry_pickerView;
    self.TXT_state.inputView=_state_pickerView;
    _TXT_country.tintColor=[UIColor clearColor];
    _TXT_state.tintColor=[UIColor clearColor];
    [self Country_api];
    [self State_api];
}
-(void)closebuttonClick
{
    [_TXT_state resignFirstResponder];
    [_TXT_country resignFirstResponder];
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


#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
@end

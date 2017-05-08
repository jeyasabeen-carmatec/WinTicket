//
//  VC_donate.m
//  WinningTicket
//
//  Created by Test User on 31/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_donate.h"

@interface VC_donate ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)NSArray *ARR_states;


@end

@implementation VC_donate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

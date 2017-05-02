//
//  VC_addFUNDS.m
//  WinningTicket
//
//  Created by Test User on 30/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_addFUNDS.h"

@interface VC_addFUNDS ()

@end

@implementation VC_addFUNDS

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
    
    [_BTN_state addTarget:self action:@selector(ACTION_state) forControlEvents:UIControlEventTouchUpInside];
    
    _TXT_amount.layer.cornerRadius = 5.0f;
    _TXT_amount.layer.masksToBounds = YES;
    _TXT_amount.layer.borderWidth = 2.0f;
    _TXT_amount.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
//    _TXT_amount.titleLabel.textColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0];
    [_TXT_amount addTarget:self action:@selector(check_TXT_stat:) forControlEvents:UIControlEventEditingChanged];
    
    [_BTN_10 addTarget:self action:@selector(BTN_10Method) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_25 addTarget:self action:@selector(BTN_25Method) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_50 addTarget:self action:@selector(BTN_50Method) forControlEvents:UIControlEventTouchUpInside];
    
    _PICK_state.hidden = YES;
    _TOOL_state.hidden = YES;
    
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
}

#pragma mark - UIButton Actions
-(void) BTN_10Method
{
    NSLog(@"Button 10 tapped");
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
    [_BTN_10 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_10 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    [_BTN_25 setBackgroundColor:[UIColor whiteColor]];
    [_BTN_25 setTitleColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0] forState:UIControlStateNormal];
    
    [_BTN_50 setBackgroundColor:[UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0]];
    [_BTN_50 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void) ACTION_state
{
    _PICK_state.hidden = NO;
    _TOOL_state.hidden = NO;
}


#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


#pragma mark - IBAction Actions
-(IBAction)TAP_done
{
    _PICK_state.hidden = YES;
    _TOOL_state.hidden = YES;
    
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
}

-(void) check_TXT_stat :(id)sender
{
    
}

@end

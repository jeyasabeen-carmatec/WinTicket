//
//  VC_editAccount.m
//  WinningTicket
//
//  Created by Test User on 05/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_editAccount.h"

@interface VC_editAccount ()

@end

@implementation VC_editAccount

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
#pragma mark - UIView Customize
-(void) setup_VIEW
{
    CGRect content_frame = _VW_contents.frame;
    content_frame.size.width = _scroll_contents.frame.size.width;
    _VW_contents.frame = content_frame;
    
    [_scroll_contents addSubview:_VW_contents];
    
    _TXT_fname.layer.cornerRadius = 5.0f;
    _TXT_fname.layer.masksToBounds = YES;
    _TXT_fname.layer.borderWidth = 2.0f;
    _TXT_fname.layer.borderColor = [UIColor grayColor].CGColor;

    _TXT_lname.layer.cornerRadius = 5.0f;
    _TXT_lname.layer.masksToBounds = YES;
    _TXT_lname.layer.borderWidth = 2.0f;
    _TXT_lname.layer.borderColor = [UIColor grayColor].CGColor;
  
    _TXT_email.layer.cornerRadius = 5.0f;
    _TXT_email.layer.masksToBounds = YES;
    _TXT_email.layer.borderWidth = 2.0f;
    _TXT_email.layer.borderColor = [UIColor grayColor].CGColor;

    _TXT_username.layer.cornerRadius = 5.0f;
    _TXT_username.layer.masksToBounds = YES;
    _TXT_username.layer.borderWidth = 2.0f;
    _TXT_username.layer.borderColor = [UIColor grayColor].CGColor;
    
    _TXT_addr1.layer.cornerRadius = 5.0f;
    _TXT_addr1.layer.masksToBounds = YES;
    _TXT_addr1.layer.borderWidth = 2.0f;
    _TXT_addr1.layer.borderColor = [UIColor grayColor].CGColor;
    
    _TXT_addr2.layer.cornerRadius = 5.0f;
    _TXT_addr2.layer.masksToBounds = YES;
    _TXT_addr2.layer.borderWidth = 2.0f;
    _TXT_addr2.layer.borderColor = [UIColor grayColor].CGColor;
    
    _TXT_city.layer.cornerRadius = 5.0f;
    _TXT_city.layer.masksToBounds = YES;
    _TXT_city.layer.borderWidth = 2.0f;
    _TXT_city.layer.borderColor = [UIColor grayColor].CGColor;
    
    _TXT_state.layer.cornerRadius = 5.0f;
    _TXT_state.layer.masksToBounds = YES;
    _TXT_state.layer.borderWidth = 2.0f;
    _TXT_state.layer.borderColor = [UIColor grayColor].CGColor;
    
    _TXT_zip.layer.cornerRadius = 5.0f;
    _TXT_zip.layer.masksToBounds = YES;
    _TXT_zip.layer.borderWidth = 2.0f;
    _TXT_zip.layer.borderColor = [UIColor grayColor].CGColor;
    
    _TXT_phone.layer.cornerRadius = 5.0f;
    _TXT_phone.layer.masksToBounds = YES;
    _TXT_phone.layer.borderWidth = 2.0f;
    _TXT_phone.layer.borderColor = [UIColor grayColor].CGColor;
}


#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end

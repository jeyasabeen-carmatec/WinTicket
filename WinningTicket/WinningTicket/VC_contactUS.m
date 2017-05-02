//
//  VC_contactUS.m
//  WinningTicket
//
//  Created by Test User on 04/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_contactUS.h"

@interface VC_contactUS ()

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
    
    _TXT_lname.layer.cornerRadius = 5.0f;
    _TXT_lname.layer.masksToBounds = YES;
    _TXT_lname.layer.borderWidth = 2.0f;
    _TXT_lname.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_lname.backgroundColor = [UIColor whiteColor];
    
    _TXT_email.layer.cornerRadius = 5.0f;
    _TXT_email.layer.masksToBounds = YES;
    _TXT_email.layer.borderWidth = 2.0f;
    _TXT_email.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_email.backgroundColor = [UIColor whiteColor];
    
    _TXT_phone.layer.cornerRadius = 5.0f;
    _TXT_phone.layer.masksToBounds = YES;
    _TXT_phone.layer.borderWidth = 2.0f;
    _TXT_phone.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_phone.backgroundColor = [UIColor whiteColor];
    
    _TXT_subject.layer.cornerRadius = 5.0f;
    _TXT_subject.layer.masksToBounds = YES;
    _TXT_subject.layer.borderWidth = 2.0f;
    _TXT_subject.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_subject.backgroundColor = [UIColor whiteColor];
    
    _TXT_VW_message.layer.cornerRadius = 5.0f;
    _TXT_VW_message.layer.masksToBounds = YES;
    _TXT_VW_message.layer.borderWidth = 2.0f;
    _TXT_VW_message.layer.borderColor = [UIColor grayColor].CGColor;
    _TXT_VW_message.backgroundColor = [UIColor whiteColor];
}

#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

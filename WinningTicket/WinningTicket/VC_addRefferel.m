//
//  VC_addRefferel.m
//  WinningTicket
//
//  Created by Test User on 21/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_addRefferel.h"

@interface VC_addRefferel ()

@end

@implementation VC_addRefferel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_view layoutIfNeeded];
    _scroll_view.contentSize = CGSizeMake(_scroll_view.frame.size.width, _VW_content.frame.size.height);
    
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
-(void) setupView
{
    CGRect new_frame;
    new_frame = _VW_content.frame;
    new_frame.origin.y = 0;
    new_frame.origin.x = 0;
    new_frame.size.width = _scroll_view.frame.size.width;
    _VW_content.frame = new_frame;
    [self.scroll_view addSubview:_VW_content];
    
    [self componentsize];
}
-(void)componentsize
{
    _TXT_referal_name.layer.cornerRadius=5;
    _TXT_referal_name.layer.borderWidth=1;
    _TXT_referal_email.layer.cornerRadius=5;
    _TXT_referal_email.layer.borderWidth=1;
    _TXT_referal_phone.layer.cornerRadius=5;
    _TXT_referal_phone.layer.borderWidth=1;
    _BTN_sponsor.layer.cornerRadius=5;
    _BTN_sponsor.layer.borderWidth=1;
    _BTN_event_organoser.layer.cornerRadius=5;
    _BTN_event_organoser.layer.borderWidth=1;
    _BTN_participant.layer.cornerRadius=5;
    _BTN_participant.layer.borderWidth=1;
    
    [_BTN_sponsor addTarget:self action:@selector(changeButtonBackGroundColor:) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_event_organoser addTarget:self action:@selector(changeButtonBackGroundColor:) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_participant addTarget:self action:@selector(changeButtonBackGroundColor:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)changeButtonBackGroundColor:(UIButton *) sender
{
    if(sender.tag==1)
    {
        [_BTN_sponsor setBackgroundColor:[UIColor lightGrayColor]];
        [_BTN_event_organoser setBackgroundColor:[UIColor clearColor]];
        [_BTN_participant setBackgroundColor:[UIColor clearColor]];
        
    }
    if(sender.tag==2)
    {
        [_BTN_event_organoser setBackgroundColor:[UIColor lightGrayColor]];
        [_BTN_sponsor setBackgroundColor:[UIColor clearColor]];
        
        [_BTN_participant setBackgroundColor:[UIColor clearColor]];
        
    }if(sender.tag==3)
    {
        [_BTN_participant setBackgroundColor:[UIColor lightGrayColor]];
        [_BTN_sponsor setBackgroundColor:[UIColor clearColor]];
        [_BTN_event_organoser setBackgroundColor:[UIColor clearColor]];
    }
    
}

#pragma mark - IBActions
- (IBAction)BTN_back:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end

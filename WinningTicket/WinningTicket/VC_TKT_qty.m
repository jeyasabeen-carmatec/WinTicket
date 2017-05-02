//
//  VC_TKT_qty.m
//  WinningTicket
//
//  Created by Test User on 28/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_TKT_qty.h"

@interface VC_TKT_qty ()
{
    float original_height;
}

@end

@implementation VC_TKT_qty

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_FRAME];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    [self setup_VIEW];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, original_height);
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
    self.navigationItem.title = @"Purchase Tickets";
}

-(void) backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void) setup_FRAME
{
    [_scroll_contents addSubview:_VW_qtycontent];
    [_scroll_contents addSubview:_VW_line1];
    [_scroll_contents addSubview:_VW_line2];
    [_scroll_contents addSubview:_VW_promo];
    
    _TXT_qty.text = @"1";
    NSString *show = @"Winning Ticket";
    NSString *place = @"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event";
    NSString *ticketnumber = @"56A8WQ";
    NSString *club_name = @"Grand Cypress Country Club";
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@\n%@ - %@",show,place,ticketnumber,club_name];
    
    text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
    text = [text stringByReplacingOccurrencesOfString:@"(null)" withString:@"Not Mentioned"];
    
    // If attributed text is supported (iOS6+)
    if ([self.lbl_ticketdetail respondsToSelector:@selector(setAttributedText:)]) {
        
        // Define general attributes for the entire text
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.lbl_ticketdetail.textColor,
                                  NSFontAttributeName: self.lbl_ticketdetail.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:text
                                               attributes:attribs];
        
        // Red text attributes
        //            UIColor *redColor = [UIColor redColor];
        NSRange cmp = [text rangeOfString:show];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0]}
                                range:cmp];
        
        NSRange plce = [text rangeOfString:place];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]}
                                range:plce];
        
        
        self.lbl_ticketdetail.attributedText = attributedText;
    }
    else
    {
        self.lbl_ticketdetail.text = text;
    }
    
    self.lbl_ticketdetail.numberOfLines = 0;
    [self.lbl_ticketdetail sizeToFit];
    
    float qty_frame_Y = _lbl_ticketdetail.frame.size.height;
    
    CGRect frame_ST = _VW_qtycontent.frame;
    frame_ST.origin.y = _VW_qtycontent.frame.origin.y + qty_frame_Y;
    _VW_qtycontent.frame = frame_ST;
    
    frame_ST = _lbl_arrowpromocode.frame;
    frame_ST.origin.y = _lbl_arrowpromocode.frame.origin.y + qty_frame_Y;
    _lbl_arrowpromocode.frame = frame_ST;
    
    frame_ST = _BTN_promocode.frame;
    frame_ST.origin.y = _BTN_promocode.frame.origin.y + qty_frame_Y;
    _BTN_promocode.frame = frame_ST;
    
    [_BTN_promocode addTarget:self action:@selector(BTN_promocode_TAP) forControlEvents:UIControlEventTouchUpInside];
    
    frame_ST = _VW_promo.frame;
    frame_ST.origin.y = _VW_promo.frame.origin.y + qty_frame_Y;
    _VW_promo.frame = frame_ST;
    
    frame_ST = _VW_line1.frame;
    frame_ST.origin.y = _VW_line1.frame.origin.y + qty_frame_Y;
    _VW_line1.frame = frame_ST;
    
    frame_ST = _lbl_titleSubtotal.frame;
    frame_ST.origin.y = _lbl_titleSubtotal.frame.origin.y + qty_frame_Y;
    _lbl_titleSubtotal.frame = frame_ST;
    
    frame_ST = _lbl_datasubtotal.frame;
    frame_ST.origin.y = _lbl_datasubtotal.frame.origin.y + qty_frame_Y;
    _lbl_datasubtotal.frame = frame_ST;
    
    frame_ST = _VW_line2.frame;
    frame_ST.origin.y = _VW_line2.frame.origin.y + qty_frame_Y;
    _VW_line2.frame = frame_ST;
    
    frame_ST = _lbl_titleTotal.frame;
    frame_ST.origin.y = _lbl_titleTotal.frame.origin.y + qty_frame_Y;
    _lbl_titleTotal.frame = frame_ST;
    
    frame_ST = _lbl_dataTotal.frame;
    frame_ST.origin.y = _lbl_dataTotal.frame.origin.y + qty_frame_Y;
    _lbl_dataTotal.frame = frame_ST;
    
    frame_ST = _BTN_checkout.frame;
    frame_ST.origin.y = _BTN_checkout.frame.origin.y + qty_frame_Y;
    _BTN_checkout.frame = frame_ST;
    
    _VW_promo.layer.borderWidth = 2.0f;
    _VW_promo.layer.borderColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.0].CGColor;
    _VW_promo.hidden = YES;
    
    original_height = _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 40;
    
    frame_ST = _scroll_contents.frame;
    frame_ST.size.height = [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height;
    _scroll_contents.frame = frame_ST;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap_DTECt:)];
    [tap setCancelsTouchesInView:NO];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

-(void) Tap_DTECt :(UITapGestureRecognizer *)sender
{
}
#pragma mark - Tap Gesture
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [_TXT_qty resignFirstResponder];
    
    if ([touch.view isDescendantOfView:_BTN_promocode]) {
        return NO;
    }
    else if ([touch.view isDescendantOfView:_BTN_checkout]) {
        return NO;
    }
    return YES;
}

#define MAX_LENGTH 2
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= MAX_LENGTH && range.length == 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - UIButton Actions
-(void) BTN_promocode_TAP
{
    if (_VW_promo.hidden == YES) {
        //    _BTN_promocode.hidden = YES;
        float btn_ht = _BTN_promocode.frame.size.height + 10;
        CGRect promoFRAME = _VW_promo.frame;
        promoFRAME.origin.y = _BTN_promocode.frame.origin.y + btn_ht;
        _VW_promo.frame = promoFRAME;
        
        _lbl_arrowpromocode.text = @"";
        
        //    [UIView transitionWithView:_BTN_promocode
        //                      duration:0.4
        //                       options:UIViewAnimationOptionTransitionCurlUp
        //                    animations:NULL
        //                    completion:NULL];
        //    [self.BTN_promocode  setHidden:YES];
        //    _lbl_arrowpromocode.hidden = YES;
        
        
        float newHT = _BTN_promocode.frame.size.height + 10;
        
        [UIView animateWithDuration:0.5 animations:^{
            _VW_line1.frame = CGRectMake(_VW_line1.frame.origin.x, _VW_line1.frame.origin.y + newHT, _VW_line1.frame.size.width, _VW_line1.frame.size.height);
            _lbl_titleSubtotal.frame = CGRectMake(_lbl_titleSubtotal.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + newHT, _lbl_titleSubtotal.frame.size.width, _lbl_titleSubtotal.frame.size.height);
            _lbl_datasubtotal.frame = CGRectMake(_lbl_datasubtotal.frame.origin.x, _lbl_datasubtotal.frame.origin.y + newHT, _lbl_datasubtotal.frame.size.width, _lbl_datasubtotal.frame.size.height);
            
            _VW_line2.frame = CGRectMake(_VW_line2.frame.origin.x, _VW_line2.frame.origin.y + newHT, _VW_line2.frame.size.width, _VW_line2.frame.size.height);
            _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _lbl_titleTotal.frame.origin.y + newHT, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
            _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _lbl_dataTotal.frame.origin.y + newHT, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
            
            _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _BTN_checkout.frame.origin.y + newHT, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
            
        }];
        
        
        [UIView beginAnimations:@"LeftFlip" context:nil];
        [UIView setAnimationDuration:0.8];
        _VW_promo.hidden = NO;
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_promo cache:YES];
        [UIView commitAnimations];
        
        original_height = original_height + 100;
        [self viewDidLayoutSubviews];
    }
    else
    {
        [self hide_PROMO];
        original_height = original_height - 100;
        [self viewDidLayoutSubviews];
    }
}
-(void) hide_PROMO
{
    [UIView transitionWithView:_VW_promo
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:NULL
                    completion:NULL];
    [_VW_promo  setHidden:YES];
    
    float btn_ht = _BTN_promocode.frame.size.height + 10;
    
    [UIView animateWithDuration:0.5 animations:^{
        _VW_line1.frame = CGRectMake(_VW_line1.frame.origin.x, _VW_line1.frame.origin.y - btn_ht, _VW_line1.frame.size.width, _VW_line1.frame.size.height);
        _lbl_titleSubtotal.frame = CGRectMake(_lbl_titleSubtotal.frame.origin.x, _lbl_titleSubtotal.frame.origin.y - btn_ht, _lbl_titleSubtotal.frame.size.width, _lbl_titleSubtotal.frame.size.height);
        _lbl_datasubtotal.frame = CGRectMake(_lbl_datasubtotal.frame.origin.x, _lbl_datasubtotal.frame.origin.y - btn_ht, _lbl_datasubtotal.frame.size.width, _lbl_datasubtotal.frame.size.height);
        
        _VW_line2.frame = CGRectMake(_VW_line2.frame.origin.x, _VW_line2.frame.origin.y - btn_ht, _VW_line2.frame.size.width, _VW_line2.frame.size.height);
        _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _lbl_titleTotal.frame.origin.y - btn_ht, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
        _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _lbl_dataTotal.frame.origin.y - btn_ht, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
        
        _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _BTN_checkout.frame.origin.y - btn_ht, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
        
    }];
    _lbl_arrowpromocode.text = @"";
}

#pragma mark - Pass value to CHKout detail
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSString *STR_chk = _TXT_qty.text;
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    if (STR_chk.length !=0 )
    {
        
        for (int i = 0; i < [STR_chk length]; i++) {
            unichar c = [STR_chk characterAtIndex:i];
            if ([myCharSet characterIsMember:c]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:STR_chk forKey:@"QUANTITY"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                return YES;
            }
        }
    }
    else
    {
        return NO;
    }
    for (int i = 0; i < [STR_chk length]; i++) {
        unichar c = [STR_chk characterAtIndex:i];
        if (![myCharSet characterIsMember:c]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter quantity" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

@end

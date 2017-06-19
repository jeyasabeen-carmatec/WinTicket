//
//  donate_purchase_VC.m
//  WinningTicket
//
//  Created by Test User on 15/06/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "donate_purchase_VC.h"
//#import "DejalActivityView.h"
//#import "DGActivityIndicatorView.h"
@interface donate_purchase_VC ()

@end

@implementation donate_purchase_VC
{
    NSMutableDictionary *states,*countryS;
    NSString *cntry_name,*conty_code;
    
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
    UILabel *loadingLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   [self setup_VIEW];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FontAwesome" size:32.0f]
       } forState:UIControlStateNormal];
    
    //    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cross"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, _VW_contents.frame.size.height);
}

-(void) setup_VIEW
{
    VW_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    VW_overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    VW_overlay.clipsToBounds = YES;
    VW_overlay.layer.cornerRadius = 10.0;
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake(0, 0, activityIndicatorView.bounds.size.width, activityIndicatorView.bounds.size.height);
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, 200, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"Loading...";
    
    [VW_overlay addSubview:loadingLabel];
    activityIndicatorView.center = VW_overlay.center;
    [VW_overlay addSubview:activityIndicatorView];
    VW_overlay.center = self.view.center;
    [self.view addSubview:VW_overlay];
    
    VW_overlay.hidden = YES;
    
    NSMutableDictionary *temp_resp = [[NSUserDefaults standardUserDefaults] valueForKey:@"donate_Deatils"];
    NSMutableDictionary *address_dictin = [temp_resp valueForKey:@"billing_address"];
    
    
    NSLog(@"The Response in Donate Purchase \n%@",temp_resp);
    
       [_BTN_order2 addTarget:self action:@selector(BTN_order2action) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect rect_content,frame_rect;
    rect_content = _VW_contents.frame;
    rect_content.size.width = self.View_Nav_Top.frame.size.width;
    NSString *email = [temp_resp valueForKey:@"email"];
    email = [email stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
    _lbl_email.text = [temp_resp valueForKey:@"email"];
    
    [self Country_api];
    conty_code  = [address_dictin valueForKey:@"country"];
    NSArray *temp = [countryS allKeysForObject:conty_code];
    cntry_name = [temp lastObject];
    
    [self State_api];
    NSString *state_code = [address_dictin valueForKey:@"state"];
    NSArray *temp_arr = [states allKeysForObject:state_code];
    NSString *state_name = [temp_arr lastObject];
    
    NSString *zip_code = [address_dictin valueForKey:@"zip_code"];
    
    
    
    NSString *address_str = [NSString stringWithFormat:@"%@ %@\n%@,%@\n%@,%@\n%@,%@.\nPhone:%@",[address_dictin valueForKey:@"first_name"],[address_dictin valueForKey:@"last_name"],[address_dictin valueForKey:@"address_line1"],[address_dictin valueForKey:@"address_line2"],[address_dictin valueForKey:@"city"],state_name,cntry_name,zip_code,[address_dictin valueForKey:@"phone"]];
    address_str = [address_str stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
    
    _lbl_address.text = [NSString stringWithFormat:@"%@",address_str];
    _lbl_address.numberOfLines = 0;
    [_lbl_address sizeToFit];
    
    frame_rect = _lbl_address.frame;
    frame_rect.size.height = _lbl_address.frame.size.height;
    _lbl_address.frame = frame_rect;
    
    
    frame_rect = _lbl_titl_payment_info.frame;
    frame_rect.origin.y = _lbl_address.frame.origin.y + _lbl_address.frame.size.height + 10;
    _lbl_titl_payment_info.frame = frame_rect;
    
    
    _lbl_data_payment_info.text = @"Credit / Debit Card";
    frame_rect = _lbl_data_payment_info.frame;
    frame_rect.origin.y = _lbl_titl_payment_info.frame.origin.y + _lbl_titl_payment_info.frame.size.height + 10;
    _lbl_data_payment_info.frame = frame_rect;
    
    frame_rect = _VW_line1.frame;
    frame_rect.origin.y = _lbl_data_payment_info.frame.origin.y + _lbl_data_payment_info.frame.size.height + 10;
    _VW_line1.frame = frame_rect;
    
    NSString *show = @"Winning Ticket";
    //    NSString *place = @"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event";
    NSString *ticketnumber = [temp_resp valueForKey:@"code"];
    NSString *club_name = [temp_resp valueForKey:@"event_name"];
//    NSString *qty = [NSString stringWithFormat:@"Qty: %@",[temp_resp valueForKey:@"quantity"]];
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@ - %@\n",show,ticketnumber,club_name];
    
    text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
    text = [text stringByReplacingOccurrencesOfString:@"(null)" withString:@"Not Mentioned"];
    _lbl_datasubtotal.text = [NSString stringWithFormat:@"$ %.02f",[[temp_resp valueForKey:@"price"] floatValue]];
    _lbl_datatotal.text = _lbl_datasubtotal.text;
    

    
    // If attributed text is supported (iOS6+)
    if ([self.lbl_ticketDetail respondsToSelector:@selector(setAttributedText:)]) {
        
        // Define general attributes for the entire text
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.lbl_ticketDetail.textColor,
                                  NSFontAttributeName: self.lbl_ticketDetail.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:text
                                               attributes:attribs];
        
        // Red text attributes
        //            UIColor *redColor = [UIColor redColor];
        NSRange cmp = [text rangeOfString:show];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0]}
                                range:cmp];
        
        
//        NSRange qt = [text rangeOfString:qty];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]}
//                                range:qt];
        
        
        self.lbl_ticketDetail.attributedText = attributedText;
    }
    else
    {
        self.lbl_ticketDetail.text = text;
    }
    
    self.lbl_ticketDetail.numberOfLines = 0;
    [self.lbl_ticketDetail sizeToFit];
    
    
    frame_rect = _lbl_ticketDetail.frame;
    frame_rect.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        frame_rect.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 5;
    }
    _lbl_ticketDetail.frame = frame_rect;
    
    frame_rect = _img_icon.frame;
    frame_rect.origin.y = _lbl_ticketDetail.frame.origin.y + 10;
    _img_icon.frame = frame_rect;
    
    float chk_ht = _lbl_ticketDetail.frame.size.height;
    frame_rect = _VW_line2.frame;
    frame_rect.origin.y = _lbl_ticketDetail.frame.origin.y + _lbl_ticketDetail.frame.size.height + 10;
    //    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    //    {
    if (chk_ht < _img_icon.frame.size.height + 10) {
        frame_rect.origin.y = _img_icon.frame.origin.y + _img_icon.frame.size.height + 10;
    }
    else
    {
        frame_rect.origin.y = _lbl_ticketDetail.frame.origin.y + _lbl_ticketDetail.frame.size.height + 10;
    }
    //    }
    
    _VW_line2.frame = frame_rect;
    
    frame_rect = _lbl_titleSubtotal.frame;
    frame_rect.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
    _lbl_titleSubtotal.frame = frame_rect;
    
    
    
    frame_rect = _lbl_datasubtotal.frame;
    frame_rect.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
    _lbl_datasubtotal.frame = frame_rect;
    
    frame_rect = _VW_line3.frame;
    frame_rect.origin.y = _lbl_datasubtotal.frame.origin.y + _lbl_datasubtotal.frame.size.height + 10;
    _VW_line3.frame = frame_rect;
    
    frame_rect = _lbl_titletotal.frame;
    frame_rect.origin.y = _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10;
    _lbl_titletotal.frame = frame_rect;
    
    frame_rect = _lbl_datatotal.frame;
    frame_rect.origin.y = _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10;
    _lbl_datatotal.frame = frame_rect;
    
    frame_rect = _BTN_order2.frame;
    frame_rect.origin.y = _lbl_datatotal.frame.origin.y + _lbl_datatotal.frame.size.height + 10;
    _BTN_order2.frame = frame_rect;
    
    frame_rect = _lbl_norms.frame;
    frame_rect.origin.y = _BTN_order2.frame.origin.y + _BTN_order2.frame.size.height + 10;
    _lbl_norms.frame = frame_rect;
    
    rect_content.size.height = _lbl_norms.frame.origin.y + _lbl_norms.frame.size.height + 20;
    
    _VW_contents.frame = rect_content;
    
    CGRect newframe = _VW_contents.frame;
    newframe.size.width = _scroll_contents.frame.size.width;
    _VW_contents.frame = newframe;
    
    [_scroll_contents addSubview:_VW_contents];
}

-(void) backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - UIButton Actions
//-(void) BTN_order1action
//{
//    NSLog(@"BTN_order1action tapped");
//    [self performSegueWithIdentifier:@"orderdetailidentifier" sender:self];
//}
-(void) BTN_order2action
{
    [self performSegueWithIdentifier:@"donate_purchase_home" sender:self];
}

#pragma mark - States and Country
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
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        countryS = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response %@",countryS);
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
    }
    
    
}
-(void)State_api
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@city_states/states?country=%@",SERVER_URL,conty_code];
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
    }
}



@end

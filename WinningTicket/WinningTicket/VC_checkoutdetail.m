//
//  VC_checkoutdetail.m
//  WinningTicket
//
//  Created by Test User on 28/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_checkoutdetail.h"

@interface VC_checkoutdetail ()

@end

@implementation VC_checkoutdetail

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
    
//    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cross"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
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
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, _VW_contents.frame.size.height + 20);
}

-(void) setup_VIEW
{
    
//    [_BTN_order1 addTarget:self action:@selector(BTN_order1action) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_order2 addTarget:self action:@selector(BTN_order2action) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect rect_content,frame_rect;
    rect_content = _VW_contents.frame;
    rect_content.size.width = self.navigationController.navigationBar.frame.size.width;
    
    _lbl_address.text = @"John Doe\n6803 Melaluca Rd\nGreenacres, FL 33463-5938\nUnited States\nPhone +1 (561) 251-9792";
    _lbl_address.numberOfLines = 0;
    [_lbl_address sizeToFit];
    
    frame_rect = _lbl_address.frame;
    frame_rect.size.height = _lbl_address.frame.size.height;
    _lbl_address.frame = frame_rect;
    
    frame_rect = _lbl_titlepaymentInfo.frame;
    frame_rect.origin.y = _lbl_address.frame.origin.y + _lbl_address.frame.size.height + 10;
    _lbl_titlepaymentInfo.frame = frame_rect;
    
    _lbl_paymentInfo.text = @"Credit/ Debit Card";
    
    frame_rect = _lbl_paymentInfo.frame;
    frame_rect.origin.y = _lbl_titlepaymentInfo.frame.origin.y + _lbl_titlepaymentInfo.frame.size.height + 10;
    _lbl_paymentInfo.frame = frame_rect;
    
    frame_rect = _VW_line1.frame;
    frame_rect.origin.y = _lbl_paymentInfo.frame.origin.y + _lbl_paymentInfo.frame.size.height + 10;
    _VW_line1.frame = frame_rect;
    
    frame_rect = _img_icon.frame;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        frame_rect.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
    }
    else
    {
        frame_rect.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 25;
    }
    
    
    _img_icon.frame = frame_rect;
    
    NSString *show = @"Winning Ticket";
    NSString *place = @"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event";
    NSString *ticketnumber = @"56A8WQ";
    NSString *club_name = @"Grand Cypress Country Club";
    NSString *qty = @"Qty: 3";
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@\n%@ - %@\n%@",show,place,ticketnumber,club_name,qty];
    
    text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
    text = [text stringByReplacingOccurrencesOfString:@"(null)" withString:@"Not Mentioned"];
    
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
        
        NSRange plce = [text rangeOfString:place];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]}
                                range:plce];
        
        NSRange qt = [text rangeOfString:qty];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]}
                                range:qt];
        
        
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
    NSLog(@"BTN_order2action tapped");
    [self performSegueWithIdentifier:@"purchaseidentifier" sender:self];
}

@end

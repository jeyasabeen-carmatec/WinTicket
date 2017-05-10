//
//  VC_billingAddr.m
//  WinningTicket
//
//  Created by Test User on 09/05/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_billingAddr.h"

@interface VC_billingAddr ()

@end

@implementation VC_billingAddr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setup_VIEW];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 20);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Uiview Customisation
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
    self.navigationItem.title = @"Add Recipient";
    
    self.lbl_name_ticket.text=@"Winning Ticket";
    int qtynum = [[[NSUserDefaults standardUserDefaults] valueForKey:@"QUANTITY"]intValue];
    self.lbl_qty.text=[NSString stringWithFormat:@"Qty:%d",qtynum];
    
    NSString *show = @"Winning Ticket";
    NSString *place = @"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event";
    NSString *ticketnumber = @"56A8WQ";
    NSString *club_name = @"Grand Cypress Country Club";
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@\n%@ - %@",show,place,ticketnumber,club_name];
    
    text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
    text = [text stringByReplacingOccurrencesOfString:@"(null)" withString:@"Not Mentioned"];
    
    if ([self.lbl_des_cription respondsToSelector:@selector(setAttributedText:)])
    {
    NSDictionary *attribs = @{
                                 NSForegroundColorAttributeName: self.lbl_des_cription.textColor,
                                 NSFontAttributeName: self.lbl_des_cription.font
                              };
    NSMutableAttributedString *attributedText =
       [[NSMutableAttributedString alloc] initWithString:text
                                                   attributes:attribs];
    

    NSRange plce = [text rangeOfString:place];
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]}range:plce];
    self.lbl_des_cription.attributedText = attributedText;
    }
    else
    {
        self.lbl_des_cription.text = text;
    }
    
    _lbl_des_cription.numberOfLines = 0;
    [_lbl_des_cription sizeToFit];
    
    CGRect frame_NEW;
    
    frame_NEW = _VW_line1.frame;
    frame_NEW.origin.y = _lbl_des_cription.frame.origin.y + _lbl_des_cription.frame.size.height + 10;
    _VW_line1.frame = frame_NEW;
    
    frame_NEW = _lbl_sub_total.frame;
    frame_NEW.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
    _lbl_sub_total.frame = frame_NEW;
    
    frame_NEW = _lbl_sub_amount.frame;
    frame_NEW.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
    _lbl_sub_amount.frame = frame_NEW;
    
    frame_NEW = _VW_line2.frame;
    frame_NEW.origin.y = _lbl_sub_total.frame.origin.y + _lbl_sub_total.frame.size.height + 10;
    _VW_line2.frame = frame_NEW;
    
    frame_NEW = _lbl_total.frame;
    frame_NEW.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
    _lbl_total.frame = frame_NEW;
    
    frame_NEW = _lbl_total_amount.frame;
    frame_NEW.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
    _lbl_total_amount.frame = frame_NEW;
    
    frame_NEW = _VW_main.frame;
    frame_NEW.size.height = _lbl_total.frame.origin.y + _VW_line2.frame.size.height + 15;
    _VW_main.frame = frame_NEW;
    
    float heiht1 = _VW_main.frame.size.height;
    
    self.VW_main.frame = CGRectMake(0,0,
                                    self.scroll_contents.bounds.size.width,_lbl_des_cription.frame.size.height);
    [self.scroll_contents addSubview:self.VW_main];
    
    _lbl_agree.text = @"You will not be charged until you confirm your order";
    _lbl_agree.numberOfLines = 0;
    [_lbl_agree sizeToFit];
    
    [_BTN_edit addTarget:self action:@selector(edit_BTN_action:) forControlEvents:UIControlEventTouchUpInside];
    
    frame_NEW = _VW_titladdress.frame;
    frame_NEW.origin.y = _scroll_contents.frame.origin.y + heiht1;
    frame_NEW.size.width = _scroll_contents.frame.size.width;
    _VW_titladdress.frame = frame_NEW;
    [self.scroll_contents addSubview:self.VW_titladdress];
    
    frame_NEW = _lbl_agree.frame;
    frame_NEW.origin.y = _VW_titladdress.frame.origin.y + _VW_titladdress.frame.size.height + 10;
    _lbl_agree.frame = frame_NEW;

    [_BTN_checkout addTarget:self action:@selector(chckout_ACtin:) forControlEvents:UIControlEventTouchUpInside];
    
    frame_NEW = _BTN_checkout.frame;
    frame_NEW.origin.y = _lbl_agree.frame.origin.y + _lbl_agree.frame.size.height + 10;
    _BTN_checkout.frame = frame_NEW;
}

#pragma mark - button Selectors
-(void) backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void) edit_BTN_action : (id) sender
{
    NSLog(@"Edit Tapped");
}

-(void) chckout_ACtin : (id) sender
{
    NSLog(@"Chekout Tapped");
    [self performSegueWithIdentifier:@"billaddretocheckoutdetail" sender:self];
}

@end

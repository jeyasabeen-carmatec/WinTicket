//
//  VC_affiliate_sighnUP.m
//  WinningTicket
//
//  Created by Test User on 17/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_affiliate_sighnUP.h"

@interface VC_affiliate_sighnUP ()

@end

@implementation VC_affiliate_sighnUP

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
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, _IMG_BG.frame.origin.y + _IMG_BG.frame.size.height + 5 + _IMG_logo_WT.frame.size.height + 20);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Customise View
-(void) setup_VIEW
{
    CGRect frame = _VW_contents.frame;
    frame.size.width = self.navigationController.navigationBar.frame.size.width - 20;
    _VW_contents.frame = frame;
    frame.origin.x = 10.0f;
    frame.origin.y = self.navigationController.navigationBar.frame.size.height;
    CGRect new_frame = [UIScreen mainScreen].bounds;
//    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
//    {
//        frame.origin.y = 288.0f;
//    }
    frame.size.height = new_frame.origin.y + new_frame.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    _scroll_contents.frame = frame;
    
    new_frame = _IMG_logo_WT.frame;
    new_frame.origin.y = 0;
    new_frame.origin.x = _scroll_contents.frame.size.width/2 - _IMG_logo_WT.frame.size.width/2;
    _IMG_logo_WT.frame = new_frame;
    
    [_scroll_contents addSubview:_IMG_logo_WT];
    
    new_frame = _VW_contents.frame;
    new_frame.origin.y = _IMG_logo_WT.frame.size.height + 20;
    _VW_contents.frame = new_frame;
    
    [_scroll_contents addSubview:_VW_contents];
    
    _TXT_phone_num.layer.cornerRadius = 5.0f;
    _TXT_phone_num.layer.masksToBounds = YES;
    _TXT_phone_num.layer.borderWidth = 2.0f;
    _TXT_phone_num.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_golfcoursename.layer.cornerRadius = 5.0f;
    _TXT_golfcoursename.layer.masksToBounds = YES;
    _TXT_golfcoursename.layer.borderWidth = 2.0f;
    _TXT_golfcoursename.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_F_name.layer.cornerRadius = 5.0f;
    _TXT_F_name.layer.masksToBounds = YES;
    _TXT_F_name.layer.borderWidth = 2.0f;
    _TXT_F_name.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_L_name.layer.cornerRadius = 5.0f;
    _TXT_L_name.layer.masksToBounds = YES;
    _TXT_L_name.layer.borderWidth = 2.0f;
    _TXT_L_name.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_titl.layer.cornerRadius = 5.0f;
    _TXT_titl.layer.masksToBounds = YES;
    _TXT_titl.layer.borderWidth = 2.0f;
    _TXT_titl.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_addr1.layer.cornerRadius = 5.0f;
    _TXT_addr1.layer.masksToBounds = YES;
    _TXT_addr1.layer.borderWidth = 2.0f;
    _TXT_addr1.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_addr2.layer.cornerRadius = 5.0f;
    _TXT_addr2.layer.masksToBounds = YES;
    _TXT_addr2.layer.borderWidth = 2.0f;
    _TXT_addr2.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_city.layer.cornerRadius = 5.0f;
    _TXT_city.layer.masksToBounds = YES;
    _TXT_city.layer.borderWidth = 2.0f;
    _TXT_city.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_phone_num.layer.cornerRadius = 5.0f;
    _TXT_phone_num.layer.masksToBounds = YES;
    _TXT_phone_num.layer.borderWidth = 2.0f;
    _TXT_phone_num.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_country.layer.cornerRadius = 5.0f;
    _TXT_country.layer.masksToBounds = YES;
    _TXT_country.layer.borderWidth = 2.0f;
    _TXT_country.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_state.layer.cornerRadius = 5.0f;
    _TXT_state.layer.masksToBounds = YES;
    _TXT_state.layer.borderWidth = 2.0f;
    _TXT_state.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_zip.layer.cornerRadius = 5.0f;
    _TXT_zip.layer.masksToBounds = YES;
    _TXT_zip.layer.borderWidth = 2.0f;
    _TXT_zip.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _TXT_email.layer.cornerRadius = 5.0f;
    _TXT_email.layer.masksToBounds = YES;
    _TXT_email.layer.borderWidth = 2.0f;
    _TXT_email.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end

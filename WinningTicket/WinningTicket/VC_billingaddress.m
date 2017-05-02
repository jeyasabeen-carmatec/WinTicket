//
//  VC_billingaddress.m
//  WinningTicket
//
//  Created by Test User on 27/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_billingaddress.h"
#import <QuartzCore/QuartzCore.h>

@interface VC_billingaddress ()
{
    float orginal_height;
}

@end

@implementation VC_billingaddress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_BTN_state addTarget:self action:@selector(ACTION_state) forControlEvents:UIControlEventTouchUpInside];
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
    
//    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cross"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
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
    [self setup_VIEW];
}


-(void) backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, orginal_height);
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
    _PICK_state.hidden = YES;
    _TOOL_state.hidden = YES;
    
//    _TXT_firstname.layer.cornerRadius = 5.0f;
//    _TXT_firstname.layer.masksToBounds = YES;
//    _TXT_firstname.layer.borderWidth = 2.0f;
//    _TXT_firstname.layer.borderColor = [UIColor grayColor].CGColor;
//    _TXT_firstname.backgroundColor = [UIColor whiteColor];
    
//    _TXT_lastname.layer.cornerRadius = 5.0f;
//    _TXT_lastname.layer.masksToBounds = YES;
//    _TXT_lastname.layer.borderWidth = 2.0f;
//    _TXT_lastname.layer.borderColor = [UIColor grayColor].CGColor;
//    _TXT_lastname.backgroundColor = [UIColor whiteColor];
    
//    _TXT_address1.layer.cornerRadius = 5.0f;
//    _TXT_address1.layer.masksToBounds = YES;
//    _TXT_address1.layer.borderWidth = 2.0f;
//    _TXT_address1.layer.borderColor = [UIColor grayColor].CGColor;
//    _TXT_address1.backgroundColor = [UIColor whiteColor];
    
//    _TXT_address2.layer.cornerRadius = 5.0f;
//    _TXT_address2.layer.masksToBounds = YES;
//    _TXT_address2.layer.borderWidth = 2.0f;
//    _TXT_address2.layer.borderColor = [UIColor grayColor].CGColor;
//    _TXT_address2.backgroundColor = [UIColor whiteColor];
    
//    _TXT_city.layer.cornerRadius = 5.0f;
//    _TXT_city.layer.masksToBounds = YES;
//    _TXT_city.layer.borderWidth = 2.0f;
//    _TXT_city.layer.borderColor = [UIColor grayColor].CGColor;
//    _TXT_city.backgroundColor = [UIColor whiteColor];
    
//    _TXT_state.layer.cornerRadius = 5.0f;
//    _TXT_state.layer.masksToBounds = YES;
//    _TXT_state.layer.borderWidth = 2.0f;
//    _TXT_state.layer.borderColor = [UIColor grayColor].CGColor;
//    _TXT_state.backgroundColor = [UIColor whiteColor];
    
//    _TXT_zip.layer.cornerRadius = 5.0f;
//    _TXT_zip.layer.masksToBounds = YES;
//    _TXT_zip.layer.borderWidth = 2.0f;
//    _TXT_zip.layer.borderColor = [UIColor grayColor].CGColor;
//    _TXT_zip.backgroundColor = [UIColor whiteColor];
    
//    _TXT_phonenumber.layer.cornerRadius = 5.0f;
//    _TXT_phonenumber.layer.masksToBounds = YES;
//    _TXT_phonenumber.layer.borderWidth = 2.0f;
//    _TXT_phonenumber.layer.borderColor = [UIColor grayColor].CGColor;
//    _TXT_phonenumber.backgroundColor = [UIColor whiteColor];
    
    orginal_height = _scroll_contents.frame.size.height;
    
    CGRect frame_new = _scroll_contents.frame;
    frame_new.size.height = [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height - 50;
    _scroll_contents.frame = frame_new;
}

#pragma mark - UIButton Actions
-(void) ACTION_state
{
    _PICK_state.hidden = NO;
    _TOOL_state.hidden = NO;
}

#pragma mark - IBAction Actions
-(IBAction)TAP_done
{
    _PICK_state.hidden = YES;
    _TOOL_state.hidden = YES;
    
    NSLog(@"Done Tapped");
}

@end

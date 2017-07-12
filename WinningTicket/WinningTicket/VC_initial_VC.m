//
//  VC_initial_VC.m
//  WinningTicket
//
//  Created by Test User on 09/05/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_initial_VC.h"

@interface VC_initial_VC ()
{
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
}

@end

@implementation VC_initial_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    VW_overlay = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    VW_overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    VW_overlay.clipsToBounds = YES;
//    VW_overlay.layer.cornerRadius = 10.0;
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake(0, 0, activityIndicatorView.bounds.size.width, activityIndicatorView.bounds.size.height);
    
    //    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, 200, 22)];
    //    loadingLabel.backgroundColor = [UIColor clearColor];
    //    loadingLabel.textColor = [UIColor whiteColor];
    //    loadingLabel.adjustsFontSizeToFitWidth = YES;
    //    loadingLabel.textAlignment = NSTextAlignmentCenter;
    //    loadingLabel.text = @"Loading...";
    //
    //    [VW_overlay addSubview:loadingLabel];
    activityIndicatorView.center = VW_overlay.center;
    [VW_overlay addSubview:activityIndicatorView];
    VW_overlay.center = self.view.center;
    [self.view addSubview:VW_overlay];
    
    VW_overlay.hidden = YES;
    
    NSString *loginSTAT = [[NSUserDefaults standardUserDefaults] valueForKey:@"LoginSTAT"];
    if (loginSTAT)
    {
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        if ([loginSTAT isEqualToString:@"affiliate"])
        {
            [self performSelector:@selector(loadinitialaffiliate)
                       withObject:activityIndicatorView
                       afterDelay:0.0];
        }
        else if ([loginSTAT isEqualToString:@"contributor"])
        {
            [self performSelector:@selector(loadinitialhome)
                       withObject:activityIndicatorView
                       afterDelay:0.0];
        }
    }
}
-(void)loadinitialhome
{
//    [activityIndicatorView stopAnimating];
//    VW_overlay.hidden = YES;
   
        NSError *error;
        NSHTTPURLResponse *response = nil;
        
        NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
        
        NSString *urlGetuser =[NSString stringWithFormat:@"%@events",SERVER_URL];
        NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:urlProducts];
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
        //    [request setHTTPShouldHandleCookies:NO];
        NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (aData)
        {
            [activityIndicatorView stopAnimating];
            VW_overlay.hidden = YES;
            
            [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"JsonEventlist"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
             [self performSegueWithIdentifier:@"initialtohome" sender:self];
        }
        else
        {
            [activityIndicatorView stopAnimating];
            VW_overlay.hidden = YES;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Interrupted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
    
   
}
-(void)loadinitialaffiliate
{
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
    [self performSegueWithIdentifier:@"initialtoafiliatehome" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end

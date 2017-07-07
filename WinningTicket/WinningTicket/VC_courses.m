//
//  VC_courses.m
//  WinningTicket
//
//  Created by Test User on 02/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_courses.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface VC_courses ()<CLLocationManagerDelegate>
{
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
    CLLocationManager *locationManager;
}

@end

@implementation VC_courses

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self setup_VIEW];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    [self setup_VIEW];
}

-(void) setup_VIEW
{
    [_segment_bottom setSelectedSegmentIndex:1];
    [_tab_HOME setSelectedItem:[_tab_HOME.items objectAtIndex:1]];
    for (int i=0; i<[self.segment_bottom.subviews count]; i++)
    {
        [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:nil];
        if (![[self.segment_bottom.subviews objectAtIndex:i]isSelected])
        {
            UIColor *tintcolor=[UIColor clearColor];
            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
        }
        else
        {
            //            UIColor *tintcolor=[UIColor blueColor];
            //            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
        }
    }
    
    VW_overlay = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    VW_overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    VW_overlay.clipsToBounds = YES;
    VW_overlay.layer.cornerRadius = 10.0;
    
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
    
    //Add google map in current controller
    [self add_GMAP];
}

#pragma mark - Tabbar deligate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([item.title isEqualToString:@"EVENTS"])
    {
        NSLog(@"Events selected");
        [_segment_bottom setSelectedSegmentIndex:0];
        for (int i=0; i<[self.segment_bottom.subviews count]; i++)
        {
            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:nil];
            if (![[self.segment_bottom.subviews objectAtIndex:i]isSelected])
            {
                UIColor *tintcolor=[UIColor clearColor];
                [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
            else
            {
                //            UIColor *tintcolor=[UIColor blueColor];
                //            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
        }
        [self performSegueWithIdentifier:@"eventssegueidentifier" sender:self];
        
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(parse_listEvents_api) withObject:activityIndicatorView afterDelay:0.01];
    }
    else if ([item.title isEqualToString:@"COURSES"])
    {
        NSLog(@"COURSES selected");
        [_segment_bottom setSelectedSegmentIndex:1];
        for (int i=0; i<[self.segment_bottom.subviews count]; i++)
        {
            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:nil];
            if (![[self.segment_bottom.subviews objectAtIndex:i]isSelected])
            {
                UIColor *tintcolor=[UIColor clearColor];
                [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
            else
            {
                //            UIColor *tintcolor=[UIColor blueColor];
                //            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
        }
    }
    else
    {
        NSLog(@"ACCOUNT selected");
        [_segment_bottom setSelectedSegmentIndex:2];
        for (int i=0; i<[self.segment_bottom.subviews count]; i++)
        {
            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:nil];
            if (![[self.segment_bottom.subviews objectAtIndex:i]isSelected])
            {
                UIColor *tintcolor=[UIColor clearColor];
                [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
            else
            {
                //            UIColor *tintcolor=[UIColor blueColor];
                //            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
        }
        [self performSegueWithIdentifier:@"accountidentifier" sender:self];
    }
}

-(void) parse_listEvents_api
{
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
        
        //        [self performSegueWithIdentifier:@"logintohomeidentifier" sender:self];
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Interrupted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

#pragma mark - Google Maps
-(void) add_GMAP
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}

#pragma mark - Location Manager
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    [locationManager stopUpdatingLocation];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude
                                                            longitude:newLocation.coordinate.longitude
                                                                 zoom:6];
//    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    [self.mapView animateToCameraPosition:camera];
}
@end

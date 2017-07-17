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
#import <QuartzCore/QuartzCore.h>
#import "HMSegmentedControl.h"

#import "WinningTicket_Universal-Swift.h"

@interface VC_courses ()<CLLocationManagerDelegate>
{
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
    CLLocationManager *locationManager;
    
    UIColor *color_OLD;
}
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
//@property (nonatomic, retain) IBOutlet courseCollectionCELL *Collection_cell;

@end

@implementation VC_courses

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup_VIEW];
    
    color_OLD = _VW_navBAR.backgroundColor;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self.Collection_course registerNib:[UINib nibWithNibName:@"courseCollectionCELL~iPad" bundle:nil]  forCellWithReuseIdentifier:@"courseceldentifier"];
    }
    else
    {
        [self.Collection_course registerNib:[UINib nibWithNibName:@"courseCollectionCELL" bundle:nil]  forCellWithReuseIdentifier:@"courseceldentifier"];
    }
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
    
    [self addSEgmentedControl];
    [self add_GMAP];
    
    _tbl_courses.estimatedRowHeight = 10.0;
    _tbl_courses.rowHeight = UITableViewAutomaticDimension;
    _tbl_courses.hidden = YES;
    
    _tbl_searchResults.estimatedRowHeight = 10.0;
    _tbl_searchResults.rowHeight = UITableViewAutomaticDimension;
    _tbl_searchResults.hidden = YES;
    
    _search_BAR.hidden = YES;
    [_BTN_close addTarget:self action:@selector(MET_nav_Close) forControlEvents:UIControlEventTouchUpInside];
    _BTN_close.hidden = YES;
    
    [_BTN_toggle setTitle:@"LIST\t" forState:UIControlStateNormal];
    [_BTN_toggle addTarget:self action:@selector(MET_toggle_TAP) forControlEvents:UIControlEventTouchUpInside];
    
    [_BTN_search addTarget:self action:@selector(MET_serch_TAP) forControlEvents:UIControlEventTouchUpInside];
}

#pragma add _ Custom Segmentcontrol
-(void) addSEgmentedControl
{
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:_VW_segment.frame];
    self.segmentedControl4.sectionTitles = @[@"  ALL  ", @" PUBLIC ",@"PRIVATE"];
    
    self.segmentedControl4.backgroundColor = [UIColor colorWithRed:0.97 green:0.96 blue:0.96 alpha:1.0];
    self.segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1.0],NSFontAttributeName:[UIFont fontWithName:@"GothamMedium" size:18]};
    self.segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : _segment_bottom.tintColor,NSFontAttributeName:[UIFont fontWithName:@"GothamMedium" size:17]};
    self.segmentedControl4.selectionIndicatorColor = _segment_bottom.tintColor;
    //    self.segmentedControl4.selectionIndicatorColor
    self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl4.selectionIndicatorHeight = 7.0f;
    
    [self.segmentedControl4 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.segmentedControl4];
}
#pragma mark - Segment Button IBACTION
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl4
{
    NSLog(@"Selected index %ld (via UIControlEventValueChanged) aaa", (long)segmentedControl4.selectedSegmentIndex);
    switch (segmentedControl4.selectedSegmentIndex) {
        case 0:
            NSLog(@"Index 0");
            break;
            
        case 1:
            NSLog(@"Index 1");
            break;
            
        case 2:
            NSLog(@"Index 2");
            break;
            
        default:
            break;
    }
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

#pragma mark - UIButton Methords
-(void) MET_toggle_TAP
{
    if (_tbl_courses.hidden == YES)
    {
        _mapView.hidden = YES;
        _tbl_courses.hidden = NO;
        [_BTN_toggle setTitle:@"MAP\t" forState:UIControlStateNormal];
    }
    else
    {
        _tbl_courses.hidden = YES;
        _mapView.hidden = NO;
        [_BTN_toggle setTitle:@"LIST\t" forState:UIControlStateNormal];
    }
}

-(void) MET_serch_TAP
{
    
    [UIView transitionWithView:_Lbl_navTITLE
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _Lbl_navTITLE.hidden = YES;
                    }
                    completion:NULL];
    
    [UIView transitionWithView:_BTN_search
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _BTN_search.hidden = YES;
                    }
                    completion:NULL];
    
    
//    _VW_navBAR.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.0];
    [UIView animateWithDuration:0.4 animations:^{
        _VW_navBAR.layer.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.0].CGColor;
    } completion:NULL];
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.4];
    _search_BAR.hidden = NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_search_BAR cache:YES];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.4];
    _BTN_close.hidden = NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_BTN_close cache:YES];
    [UIView commitAnimations];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
}

-(void) MET_nav_Close
{
    [self.view endEditing:YES];
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.4];
    _Lbl_navTITLE.hidden = NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_Lbl_navTITLE cache:YES];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.4];
    _BTN_search.hidden = NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_BTN_search cache:YES];
    [UIView commitAnimations];
    
    [UIView animateWithDuration:0.4 animations:^{
        _VW_navBAR.layer.backgroundColor = color_OLD.CGColor;
    } completion:NULL];
    
    [UIView transitionWithView:_search_BAR
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _search_BAR.hidden = YES;
                    }
                    completion:NULL];
    
    [UIView transitionWithView:_BTN_close
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _BTN_close.hidden = YES;
                    }
                    completion:NULL];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - Tableview Datasource/Deligate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    Course_tblCELL *cell = (Course_tblCELL *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"Course_tblCELL~iPad" owner:self options:nil];
        }
        else
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"Course_tblCELL" owner:self options:nil];
        }
        cell = [nib objectAtIndex:0];
    }
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 93;
//}

#pragma mark - UIsearchbar Deligates
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - Uicollection view Datasource/ Deligate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_Collection_course.frame.size.width - 20, _Collection_course.frame.size.height - 20);
}
- (courseCollectionCELL *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    courseCollectionCELL *cell = (courseCollectionCELL*)[self.Collection_course dequeueReusableCellWithReuseIdentifier:@"courseceldentifier" forIndexPath:indexPath];
    cell.lbl_corsename.text = @"Testing";
    
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 1.0f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    
    return cell;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_Collection_course.collectionViewLayout invalidateLayout];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
    float pageWidth = _Collection_course.frame.size.width - 10; // width + space
    
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset)
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    else
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0)
        newTargetOffset = 0;
    else if (newTargetOffset > scrollView.contentSize.width)
        newTargetOffset = scrollView.contentSize.width;
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset, scrollView.contentOffset.y) animated:YES];
}

@end

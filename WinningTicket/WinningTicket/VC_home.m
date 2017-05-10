//
//  VC_home.m
//  WinningTicket
//
//  Created by Test User on 27/02/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_home.h"
#import "TBL_VW_Cell_EVENTS.h"
#import "DejalActivityView.h"
#import "DGActivityIndicatorView.h"

@interface VC_home ()
{
    NSArray *ARR_allevent,*ARR_upcommingevent;
    UIView *VW_overlay;
    DGActivityIndicatorView *activityIndicatorView;
}

@end

@implementation VC_home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    _tbl_all_event.estimatedRowHeight = 10.0;
    _tbl_all_event.rowHeight = UITableViewAutomaticDimension;
    
    [self get_Data];
    [self setup_VIEW];
    [self setup_VIEW];
    
    VW_overlay = [[UIView alloc]init];
    VW_overlay.frame = [UIScreen mainScreen].bounds;
    //    VW_overlay.center = self.view.center;
    
    [self.view addSubview:VW_overlay];
    VW_overlay.backgroundColor = [UIColor blackColor];
    VW_overlay.alpha = 0.2;
    
    
    
    
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor whiteColor]];
    
    CGRect frame_M = activityIndicatorView.frame;
    frame_M.origin.x = 0;
    frame_M.origin.y = 0;
    frame_M.size.width = VW_overlay.frame.size.width;
    frame_M.size.height = VW_overlay.frame.size.height;
    activityIndicatorView.frame = frame_M;
    
    [VW_overlay addSubview:activityIndicatorView];
    //        activityIndicatorView.center=myview.center;
    
    VW_overlay.hidden = YES;
    
    
    
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

-(void) backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Customise view
-(void) setup_VIEW
{
    [_tab_HOME setSelectedItem:[_tab_HOME.items objectAtIndex:0]];
    [_segment_bottom setSelectedSegmentIndex:0];
    
    
    
    _lbl_titl_event_code.hidden = YES;
    _VW_hold_code.hidden = YES;
    _BTN_cancel.hidden = YES;
    _BTN_enter_event_code.hidden = YES;
    _BTN_enter_event_code.enabled = NO;
    _BTN_enter_event_code.alpha = 0.5;
    [_BTN_view_all_event addTarget:self action:@selector(BTN_enter_event_code:) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_cancel addTarget:self action:@selector(BTN_cancel:) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_enter_event_code addTarget:self action:@selector(BTN_enter_code:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _TXT_0.tag = 0;
    _TXT_1.tag = 1;
    _TXT_2.tag = 2;
    _TXT_3.tag = 3;
    _TXT_4.tag = 4;
    _TXT_5.tag = 5;
    
//    ARR_allevent = [[NSMutableArray alloc]init];
    
//    NSDictionary *temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event",@"Event_Name",@"Feb 25, 2017 11:30AM EST",@"Event_Time", nil];
//    [ARR_allevent addObject:temp_Dictn];
//    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Murray Bros. Caddyshack Charity Golf Tournament",@"Event_Name",@"Mar 22, 2017 03:00PM EST",@"Event_Time", nil];
//    [ARR_allevent addObject:temp_Dictn];
//    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Susan G Komen 2017 Golf Classic",@"Event_Name",@"Mar 31,2017 11:00AM EST",@"Event_Time", nil];
//    [ARR_allevent addObject:temp_Dictn];
//    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event",@"Event_Name",@"Feb 25, 2017 11:30AM EST",@"Event_Time", nil];
//    [ARR_allevent addObject:temp_Dictn];
//    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Murray Bros. Caddyshack Charity Golf Tournament",@"Event_Name",@"Mar 22, 2017 03:00PM EST",@"Event_Time", nil];
//    [ARR_allevent addObject:temp_Dictn];
//    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Susan G Komen 2017 Golf Classic",@"Event_Name",@"Mar 31,2017 11:00AM EST",@"Event_Time", nil];
//    [ARR_allevent addObject:temp_Dictn];
//    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event",@"Event_Name",@"Feb 25, 2017 11:30AM EST",@"Event_Time", nil];
//    [ARR_allevent addObject:temp_Dictn];
//    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Murray Bros. Caddyshack Charity Golf Tournament",@"Event_Name",@"Mar 22, 2017 03:00PM EST",@"Event_Time", nil];
//    [ARR_allevent addObject:temp_Dictn];
//    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Susan G Komen 2017 Golf Classic",@"Event_Name",@"Mar 31,2017 11:00AM EST",@"Event_Time", nil];
//    [ARR_allevent addObject:temp_Dictn];
//    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event",@"Event_Name",@"Feb 25, 2017 11:30AM EST",@"Event_Time", nil];
//    [ARR_allevent addObject:temp_Dictn];
    

    if (_BTN_view_all_event.hidden == YES) {
    
        _TXT_0.text = @"";
        _TXT_1.text = @"";
        _TXT_2.text = @"";
        _TXT_3.text = @"";
        _TXT_4.text = @"";
        _TXT_5.text = @"";
        
        [UIView beginAnimations:@"LeftFlip" context:nil];
        [UIView setAnimationDuration:0.8];
        _BTN_view_all_event.hidden = NO;
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_BTN_view_all_event cache:YES];
        [UIView commitAnimations];
        
        _lbl_titl_event_code.hidden = YES;
        
        [UIView transitionWithView:_VW_hold_code
                          duration:0.4
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:NULL
                        completion:NULL];
        [self.VW_hold_code  setHidden:YES];
        
        [UIView animateWithDuration:0.5 animations:^{
            _lbl_upcoming_event.frame = CGRectMake(_lbl_upcoming_event.frame.origin.x, _lbl_upcoming_event.frame.origin.y - 90, _lbl_upcoming_event.frame.size.width, _lbl_upcoming_event.frame.size.height);
            _scroll_content.frame = CGRectMake(_scroll_content.frame.origin.x, _scroll_content.frame.origin.y - 90, _scroll_content.frame.size.width, _scroll_content.frame.size.height + 90);
            _VW_hold_BTN.frame = CGRectMake(_VW_hold_BTN.frame.origin.x, _VW_hold_BTN.frame.origin.y, _VW_hold_BTN.frame.size.width, _VW_hold_BTN.frame.size.height - 90);
        }];
        [UIView commitAnimations];
        
        [UIView transitionWithView:_BTN_cancel
                          duration:0.1
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:NULL
                        completion:NULL];
        [self.BTN_cancel  setHidden:YES];
        
        [UIView transitionWithView:_BTN_enter_event_code
                          duration:0.4
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:NULL
                        completion:NULL];
        [self.BTN_enter_event_code  setHidden:YES];
    }
    
    CGRect new_frame = _tbl_upcomming_event.frame;
    new_frame.size.height = [self upcommingEvent_height];
    _tbl_upcomming_event.frame = new_frame;
    
    new_frame = _lbl_titleallevents.frame;
    new_frame.origin.y = _tbl_upcomming_event.frame.origin.y + [self upcommingEvent_height] + 10;
    _lbl_titleallevents.frame = new_frame;
    
    new_frame = _VW_allevent_HEAD.frame;
    new_frame.origin.y = _lbl_titleallevents.frame.origin.y + _lbl_titleallevents.frame.size.height + 10;
    _VW_allevent_HEAD.frame = new_frame;
    
    new_frame = _tbl_all_event.frame;
    new_frame.origin.y = _VW_allevent_HEAD.frame.origin.y + _VW_allevent_HEAD.frame.size.height;
    new_frame.size.height = [self allEvent_height];
    _tbl_all_event.frame = new_frame;
    
    new_frame = _BTN_all_event.frame;
    new_frame.origin.y = _tbl_all_event.frame.origin.y + [self allEvent_height] + 10;
    new_frame.size.height = _BTN_all_event.frame.size.height;
    _BTN_all_event.frame = new_frame;
//    [_VW_Scroll_CONTENT addSubview:_BTN_all_event];
    
    CGRect frame = _scroll_content.frame;
    frame.origin.y = 0.0f;
    frame.origin.x = 0.0f;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = _BTN_all_event.frame.origin.y + _BTN_all_event.frame.size.height + 20;
    _VW_Scroll_CONTENT.frame = frame;
    
    [_scroll_content addSubview:_VW_Scroll_CONTENT];
//    CGRect new_frame = _scroll_content.frame;
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
        [self performSegueWithIdentifier:@"courseviewcontroller" sender:self];
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
        [self performSegueWithIdentifier:@"accountsviewcontroller" sender:self];
    }
}


#pragma mark - Scroll view
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scroll_content layoutIfNeeded];
    [_tbl_upcomming_event layoutIfNeeded];
    [_tbl_all_event layoutIfNeeded];
    _scroll_content.contentSize = CGSizeMake(_scroll_content.frame.size.width, _VW_Scroll_CONTENT.frame.size.height);
}

#pragma mark - Determine Height
- (CGFloat)upcommingEvent_height
{
    [_tbl_upcomming_event layoutIfNeeded];
    
    NSLog(@"Upcomming event Height = %f",[_tbl_upcomming_event contentSize].height);
    
    return [_tbl_upcomming_event contentSize].height;
    
}
- (CGFloat)allEvent_height
{
    [_tbl_all_event layoutIfNeeded];
    
    NSLog(@"All event Height = %f",[_tbl_all_event contentSize].height);
    
    return [_tbl_all_event contentSize].height;
    
}

#pragma Mark - UITableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tbl_all_event)
    {
        return [ARR_allevent count];
    }
    if (tableView == _tbl_upcomming_event)
    {
//        return [ARR_upcommingevent count];
        return [ARR_upcommingevent count];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    TBL_VW_Cell_EVENTS *cell = (TBL_VW_Cell_EVENTS *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
           nib = [[NSBundle mainBundle] loadNibNamed:@"TBL_VW_Cell_EVENTS~iPad" owner:self options:nil];
        }
        else
        {
           nib = [[NSBundle mainBundle] loadNibNamed:@"TBL_VW_Cell_EVENTS" owner:self options:nil];
        }
        cell = [nib objectAtIndex:0];
    }
    if (tableView == _tbl_upcomming_event)
    {
//        NSDictionary *temp_DICN = [ARR_allevent objectAtIndex:indexPath.row];
//        cell.lbl_event_name.text = [temp_DICN valueForKey:@"Event_Name"];
//        cell.lbl_event_time.text = [temp_DICN valueForKey:@"Event_Time"];
        NSDictionary *temp_DICN = [ARR_upcommingevent objectAtIndex:indexPath.row];
        cell.lbl_event_name.text = [temp_DICN valueForKey:@"name"];
        cell.lbl_event_name.numberOfLines = 0;
        [cell.lbl_event_name sizeToFit];
        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
//        
//        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//        [dateFormatter setTimeZone:gmt];
//        NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
        
        cell.lbl_event_time.text = [self getLocalDateTimeFromUTC:[temp_DICN valueForKey:@"start_date"]];
        
        [cell.BTN_View_detail setTag:indexPath.row];
        [cell.BTN_View_detail addTarget:self action:@selector(BTN_UP_COMNG_EVENT:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        //        cell.lbl_event_name.text = [temp_DICN valueForKey:@"Event_Name"];
        //        cell.lbl_event_time.text = [temp_DICN valueForKey:@"Event_Time"];
        NSDictionary *temp_DICN = [ARR_allevent objectAtIndex:indexPath.row];
        cell.lbl_event_name.text = [temp_DICN valueForKey:@"name"];
        cell.lbl_event_name.numberOfLines = 0;
        [cell.lbl_event_name sizeToFit];
        
        //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
        //
        //        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        //        [dateFormatter setTimeZone:gmt];
        //        NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
        
        cell.lbl_event_time.text = [self getLocalDateTimeFromUTC:[temp_DICN valueForKey:@"start_date"]];
        
        [cell.BTN_View_detail setTag:indexPath.row];
        [cell.BTN_View_detail addTarget:self action:@selector(BTN_ALL_EVENT:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.95 alpha:1.0];
    } else {
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    }
}

#pragma mark - Button Events

-(void) BTN_UP_COMNG_EVENT : (UIButton *) sender
{
    NSIndexPath *buttonIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    NSLog(@"From Delete Skill %ld",(long)buttonIndexPath.row);
    NSString *index_str = [NSString stringWithFormat:@"%ld",(long)buttonIndexPath.row];
    NSLog(@"Index path of Upcomming Event %@",index_str);
    NSLog(@"thedata:%@",[ARR_upcommingevent objectAtIndex:[index_str intValue]]);
    NSDictionary *dictdat =[ARR_upcommingevent objectAtIndex:[index_str intValue]];
    [[NSUserDefaults standardUserDefaults] setValue:[dictdat valueForKey:@"id"] forKey:@"event_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"event_id"]);
    
//    [self geteventcode];
    VW_overlay.hidden = NO;
    [activityIndicatorView startAnimating];
    [self performSelector:@selector(geteventcode) withObject:activityIndicatorView afterDelay:0.01];
}
-(void) BTN_ALL_EVENT : (UIButton *) sender
{
    NSIndexPath *buttonIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    NSLog(@"From Delete Skill %ld",(long)buttonIndexPath.row);
    
    NSString *index_str = [NSString stringWithFormat:@"%ld",(long)buttonIndexPath.row];
    
    NSLog(@"Index path of All Event %@",index_str);
    
    NSDictionary *dictdat =[ARR_allevent objectAtIndex:[index_str intValue]];
    [[NSUserDefaults standardUserDefaults] setValue:[dictdat valueForKey:@"id"] forKey:@"event_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    [self performSegueWithIdentifier:@"hometoeventdetail" sender:self];
    VW_overlay.hidden = NO;
    [activityIndicatorView startAnimating];
    [self performSelector:@selector(geteventcode) withObject:activityIndicatorView afterDelay:0.01];
}

#pragma mark - Button Actions
-(void)BTN_enter_event_code:(id)sender
{
    [UIView transitionWithView:_BTN_view_all_event
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:NULL
                    completion:NULL];
    [self.BTN_view_all_event  setHidden:YES];
    
    _lbl_titl_event_code.hidden = NO;
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.8];
    _VW_hold_code.hidden = NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_hold_code cache:YES];
    [UIView commitAnimations];
    
    [UIView animateWithDuration:0.5 animations:^{
        _lbl_upcoming_event.frame = CGRectMake(_lbl_upcoming_event.frame.origin.x, _lbl_upcoming_event.frame.origin.y + 90, _lbl_upcoming_event.frame.size.width, _lbl_upcoming_event.frame.size.height);
        _scroll_content.frame = CGRectMake(_scroll_content.frame.origin.x, _scroll_content.frame.origin.y + 90, _scroll_content.frame.size.width, _scroll_content.frame.size.height - 90);
        _VW_hold_BTN.frame = CGRectMake(_VW_hold_BTN.frame.origin.x, _VW_hold_BTN.frame.origin.y, _VW_hold_BTN.frame.size.width, _VW_hold_BTN.frame.size.height + 90);
    }];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.4];
    _BTN_cancel.hidden=NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_BTN_cancel cache:YES];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.8];
    _BTN_enter_event_code.hidden = NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_BTN_enter_event_code cache:YES];
    [UIView commitAnimations];
}

-(void) BTN_cancel :(id)sender
{
    _TXT_0.text = @"";
    _TXT_1.text = @"";
    _TXT_2.text = @"";
    _TXT_3.text = @"";
    _TXT_4.text = @"";
    _TXT_5.text = @"";
    
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.8];
    _BTN_view_all_event.hidden = NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_BTN_view_all_event cache:YES];
    [UIView commitAnimations];
    
    _lbl_titl_event_code.hidden = YES;
    
    [UIView transitionWithView:_VW_hold_code
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:NULL
                    completion:NULL];
    [self.VW_hold_code  setHidden:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        _lbl_upcoming_event.frame = CGRectMake(_lbl_upcoming_event.frame.origin.x, _lbl_upcoming_event.frame.origin.y - 90, _lbl_upcoming_event.frame.size.width, _lbl_upcoming_event.frame.size.height);
        _scroll_content.frame = CGRectMake(_scroll_content.frame.origin.x, _scroll_content.frame.origin.y - 90, _scroll_content.frame.size.width, _scroll_content.frame.size.height + 90);
        _VW_hold_BTN.frame = CGRectMake(_VW_hold_BTN.frame.origin.x, _VW_hold_BTN.frame.origin.y, _VW_hold_BTN.frame.size.width, _VW_hold_BTN.frame.size.height - 90);
    }];
    [UIView commitAnimations];
    
    [UIView transitionWithView:_BTN_cancel
                      duration:0.1
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:NULL
                    completion:NULL];
    [self.BTN_cancel  setHidden:YES];
    
    [UIView transitionWithView:_BTN_enter_event_code
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:NULL
                    completion:NULL];
    [self.BTN_enter_event_code  setHidden:YES];
}
-(void)BTN_enter_code:(id)sender
{
    NSLog(@"Enter Code Tapped");
    
    VW_overlay.hidden = NO;
    [activityIndicatorView startAnimating];
    
    [self performSelector:@selector(get_EVENTDETAIL) withObject:activityIndicatorView afterDelay:0.01];
}

#pragma mark - Textfield editing
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str_0,*str_1,*str_2,*str_3,*str_4,*str_5;
    str_0 = _TXT_0.text;
    str_1 = _TXT_1.text;
    str_2 = _TXT_2.text;
    str_3 = _TXT_3.text;
    str_4 = _TXT_4.text;
    str_5 = _TXT_5.text;
    if (string.length > 0)
    {
        NSInteger nextTag = textField.tag + 1;
        UIResponder* nextResponder;
        
        if (textField == _TXT_1 && str_0.length == 0) {
            nextResponder = [textField.superview viewWithTag:0];
            textField.text = @"";
            [_TXT_0 becomeFirstResponder];
        }
        else if ((textField == _TXT_2 && str_0.length == 0) || (textField == _TXT_2 && str_1.length == 0))
        {
            nextResponder = [textField.superview viewWithTag:0];
            textField.text = @"";
            [_TXT_0 becomeFirstResponder];
        }
        else if ((textField == _TXT_3 && str_0.length == 0) || (textField == _TXT_3 && str_1.length == 0) || (textField == _TXT_3 && str_2.length == 0))
        {
            nextResponder = [textField.superview viewWithTag:0];
            textField.text = @"";
            [_TXT_0 becomeFirstResponder];
        }
        else if ((textField == _TXT_4 && str_0.length == 0) || (textField == _TXT_4 && str_1.length == 0) || (textField == _TXT_4 && str_2.length == 0) || (textField == _TXT_4 && str_3.length == 0))
        {
            nextResponder = [textField.superview viewWithTag:0];
            textField.text = @"";
            [_TXT_0 becomeFirstResponder];
        }
        else if ((textField == _TXT_5 && str_0.length == 0) || (textField == _TXT_5 && str_1.length == 0) || (textField == _TXT_5 && str_2.length == 0) || (textField == _TXT_5 && str_3.length == 0) || (textField == _TXT_5 && str_4.length == 0))
        {
            nextResponder = [textField.superview viewWithTag:0];
            textField.text = @"";
            [_TXT_0 becomeFirstResponder];
        }
        else
        {
            nextResponder= [textField.superview viewWithTag:nextTag];
            
            if (! nextResponder)
                nextResponder = [textField.superview viewWithTag:0];
            
            if (nextResponder)
            {
                textField.text = string;
                [nextResponder becomeFirstResponder];
//                if (textField == _TXT_1) {
//                    _TXT_0.secureTextEntry = YES;
//                }
//                else if(textField == _TXT_2)
//                {
//                    _TXT_1.secureTextEntry = YES;
//                }
//                else if(textField == _TXT_3)
//                {
//                    _TXT_2.secureTextEntry = YES;
//                }
//                else if(textField == _TXT_4)
//                {
//                    _TXT_3.secureTextEntry = YES;
//                }
//                else
                if(textField == _TXT_5)
                {
                    _BTN_enter_event_code.enabled = YES;
                    _BTN_enter_event_code.alpha = 1.0;
//                    _TXT_4.secureTextEntry = YES;
                }
            }
        }
        return NO;
    }
    else
    {
        _BTN_enter_event_code.enabled = NO;
        _BTN_enter_event_code.alpha = 0.5;
        NSInteger prevTag = textField.tag - 1;
        UIResponder* prev = [textField.superview viewWithTag:prevTag];
        if (! prev)
        {
            prev = [textField.superview viewWithTag:0];
        }
        else
        {
            textField.text = @"";
            if (textField == _TXT_1) {
                _TXT_0.secureTextEntry = NO;
            }
            else if(textField == _TXT_2)
            {
                _TXT_1.secureTextEntry = NO;
            }
            else if(textField == _TXT_3)
            {
                _TXT_2.secureTextEntry = NO;
            }
            else if(textField == _TXT_4)
            {
                _TXT_3.secureTextEntry = NO;
            }
            else if(textField == _TXT_5)
            {
                _TXT_4.secureTextEntry = NO;
            }
        }
        
        if (prevTag == 0)
        {
            _TXT_0.text = @"";
            _TXT_0.secureTextEntry = NO;
            [_TXT_0 becomeFirstResponder];
        }
        else
        {
            [prev becomeFirstResponder];
        }
        return NO;
    }
    return YES;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) get_Data
{
    NSError *error;
    NSData *aData = [[NSUserDefaults standardUserDefaults] valueForKey:@"JsonEventlist"];
    NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
    NSLog(@"The response dsfdf %@",json_DATA);
    
    ARR_allevent = [json_DATA valueForKey:@"all_events"];
    ARR_upcommingevent = [json_DATA valueForKey:@"upcoming_events"];
    
}

#pragma mark - Date Convert
-(NSString *)getLocalDateTimeFromUTC:(NSString *)strDate
{

    NSLog(@"Date Input tbl %@",strDate);
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    NSDate *currentDate = [dateFormatter dateFromString:strDate];
    NSLog(@"CurrentDate:%@", currentDate);
    NSDateFormatter *newFormat = [[NSDateFormatter alloc] init];
    [newFormat setDateFormat:@"MMM dd, yyyy h:mm a"];
    [newFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
    return [NSString stringWithFormat:@"%@ EST",[newFormat stringFromDate:currentDate]];
}

#pragma mark - Api Integration
-(void)geteventcode
{
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSString *event_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"event_id"]];
    NSString *urlGetuser =[NSString stringWithFormat:@"%@events/event_detail/?id=%@",SERVER_URL,event_id];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
            [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"upcoming_events"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self performSegueWithIdentifier:@"hometoeventdetail" sender:self];
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Interrupted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

- (BOOL) get_ALLevents
{
    NSError *error;
    NSHTTPURLResponse *response = nil;
    
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@events/all_events",SERVER_URL];
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
    
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"ALLEvents"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return NO;
    }
}

- (void) get_EVENTDETAIL
{
    NSError *error;
    NSError *err;
    NSHTTPURLResponse *response = nil;
    NSString *code = [NSString stringWithFormat:@"%@%@%@%@%@%@",_TXT_0.text,_TXT_1.text,_TXT_2.text,_TXT_3.text,_TXT_4.text,_TXT_5.text];
    NSDictionary *parameters = @{ @"code":  code};
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&err];
    NSString *urlGetuser = [NSString stringWithFormat:@"%@events/event_code",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPBody:postData];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
//        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
//        NSLog(@"The response CODE %@",json_DATA);
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"upcoming_events"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self performSegueWithIdentifier:@"hometoeventdetail" sender:self];
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

#pragma mark - Custom Segue
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"alleventsidentifier"])
    {
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(get_ALLevents) withObject:activityIndicatorView afterDelay:0.01];
//        [self get_ALLevents];
    }
    return YES;
}



@end

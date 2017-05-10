//
//  VC_all_events.m
//  WinningTicket
//
//  Created by Test User on 22/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_all_events.h"
#import "TBL_VW_Cell_EVENTS.h"
#import "DejalActivityView.h"
#import "DGActivityIndicatorView.h"

@interface VC_all_events ()
{
    CGRect old_FRAME;
    UIColor *old_color;
    UISearchBar *searchBar1;
    NSMutableArray *ARR_allevent;
    UIView *VW_overlay;
    DGActivityIndicatorView *activityIndicatorView;
    
}
@property(nonatomic,strong)NSArray *ARR_states;
@end

@implementation VC_all_events

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ARR_allevent = [[NSMutableArray alloc]init];
    
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
    
    NSError *error;
    NSData *aData = [[NSUserDefaults standardUserDefaults] valueForKey:@"ALLEvents"];
    NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
    NSLog(@"The response ALLEvents %@",json_DATA);
    
    NSArray *ARR_tmp = [json_DATA valueForKey:@"events"];
    
    [ARR_allevent addObjectsFromArray:ARR_tmp];
    
    [self State_api];
    
    _TXT_state.layer.borderWidth = 1.0f;
    _TXT_state.layer.borderColor = [UIColor blackColor].CGColor;
    
    _TXT_todate.layer.borderWidth = 1.0f;
    _TXT_todate.layer.borderColor = [UIColor blackColor].CGColor;
    
    _TXT_fromdate.layer.borderWidth = 1.0f;
    _TXT_fromdate.layer.borderColor = [UIColor blackColor].CGColor;
}
-(void) fromdateTextField:(id)sender
{
//    [_fromdate_picker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = _picker_fromdate.date;
    [dateFormat setDateFormat:@"MM/dd/YY"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _TXT_fromdate.text = [NSString stringWithFormat:@"%@",dateString];
    _TXT_todate.text = @"";
}

-(void) todateTextField:(id)sender
{
    if ([_TXT_fromdate.text isEqualToString:@""])
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSDate *eventDate = _picker_todate.date;
        [dateFormat setDateFormat:@"MM/dd/YY"];
        
        NSString *dateString = [dateFormat stringFromDate:eventDate];
        _TXT_fromdate.text = [NSString stringWithFormat:@"%@",dateString];
        _TXT_todate.text = @"";
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yy"];
        
        NSString *STR_tmp = [NSString stringWithFormat:@"%@",_TXT_fromdate.text];
        
        NSDate *min_date = [[NSDate alloc] init];
        min_date = [formatter dateFromString:STR_tmp];
        
        [_picker_todate setMinimumDate:min_date];
        
        NSDate *eventDate = _picker_todate.date;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/YY"];
        _TXT_todate.text = [dateFormat stringFromDate:eventDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    _tbl_eventlst.estimatedRowHeight = 10.0;
    _tbl_eventlst.rowHeight = UITableViewAutomaticDimension;
    
    [self setup_VIEW];
    
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
-(void) setup_VIEW
{
    [_tab_HOME setSelectedItem:[_tab_HOME.items objectAtIndex:0]];
    [_segment_bottom setSelectedSegmentIndex:0];
    
    _VW_line.hidden = YES;
    _lbl_Serch_char.hidden = YES;
    _VW_filter.hidden = YES;
    
//    _picker_STATE.hidden = YES;
//    _picker_DATE.hidden = YES;
//    [_picker_DATE setBackgroundColor:[UIColor whiteColor]];
    
    
//    _tool_DATE.hidden = YES;
//    _tool_STATE.hidden = YES;
    
//    [_BTN_choose addTarget:self action:@selector(choose_STATE) forControlEvents:UIControlEventTouchUpInside];
//    [_BTN_fromDATE addTarget:self action:@selector(choose_from_DATE) forControlEvents:UIControlEventTouchUpInside];
//    [_BTN_toDATE addTarget:self action:@selector(choose_to_DATE) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
//    [ARR_states addObject:@"Qassim"];
//    [ARR_states addObject:@"Riyadh"];
//    [ARR_states addObject:@"Tabuk"];
//    [ARR_states addObject:@"Madinah"];
//    [ARR_states addObject:@"Makkah"];
//    [ARR_states addObject:@"Northern Borders"];
//    [ARR_states addObject:@"Jawf"];
//    [ARR_states addObject:@"Ha'il"];
//    [ARR_states addObject:@"Bahah"];
//    [ARR_states addObject:@"Jizan"];
//    [ARR_states addObject:@"'Asir"];
//    [ARR_states addObject:@"Qassim"];
//    [ARR_states addObject:@"Riyadh"];
//    [ARR_states addObject:@"Tabuk"];
//    [ARR_states addObject:@"Madinah"];
//    [ARR_states addObject:@"Makkah"];
//    [ARR_states addObject:@"Northern Borders"];
//    [ARR_states addObject:@"Jawf"];
//    [ARR_states addObject:@"Ha'il"];
//    [ARR_states addObject:@"Bahah"];
//    [ARR_states addObject:@"Jizan"];
//    [ARR_states addObject:@"'Asir"];
//    [ARR_states addObject:@"Qassim"];
//    [ARR_states addObject:@"Riyadh"];
//    [ARR_states addObject:@"Tabuk"];
//    [ARR_states addObject:@"Madinah"];
//    [ARR_states addObject:@"Makkah"];
//    [ARR_states addObject:@"Northern Borders"];
//    [ARR_states addObject:@"Jawf"];
//    [ARR_states addObject:@"Ha'il"];
//    [ARR_states addObject:@"Bahah"];
//    [ARR_states addObject:@"Jizan"];
//    [ARR_states addObject:@"'Asir"];
    
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
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, anotherButton] animated:NO];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    self.navigationItem.title = @"All Events";
    
    CGRect frameimg = CGRectMake(15,5, 80,25);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setTitle:@"FILTER" forState:UIControlStateNormal];
    [someButton setBackgroundColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0]];
    [someButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0]];
//    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(BTN_filter)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem =mailbutton;
    
    UIToolbar* state_close = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    state_close.barStyle = UIBarStyleBlackTranslucent;
    [state_close sizeToFit];
    UILabel *statelbl=[[UILabel alloc]initWithFrame:CGRectMake(state_close.frame.size.width-250, 0, 100, state_close.frame.size.height)];
    [state_close addSubview:statelbl];
    statelbl.text=@"Select State";
    statelbl.textColor=[UIColor redColor];
    statelbl.backgroundColor=[UIColor clearColor];
    
    UIButton *close=[[UIButton alloc]init];
    close.frame=CGRectMake(state_close.frame.size.width - 100, 0, 100, state_close.frame.size.height);
    [close setTitle:@"close" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [numberToolbar setItems:[NSArray arrayWithObjects:close, nil]];
    [state_close addSubview:close];
    
    UIToolbar* date_close = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    date_close.barStyle = UIBarStyleBlackTranslucent;
    [date_close sizeToFit];
    UILabel *datelbl=[[UILabel alloc]initWithFrame:CGRectMake(date_close.frame.size.width-250, 0, 100, date_close.frame.size.height)];
    [date_close addSubview:datelbl];
    datelbl.text=@"Select Date";
    datelbl.textColor=[UIColor redColor];

    UIButton *closeDate =[[UIButton alloc]init];
    closeDate.frame=CGRectMake(date_close.frame.size.width - 90, 0, 100, date_close.frame.size.height);
    [closeDate setTitle:@"Close" forState:UIControlStateNormal];
    [closeDate addTarget:self action:@selector(closebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [numberToolbar setItems:[NSArray arrayWithObjects:close, nil]];
    [date_close addSubview:closeDate];
    
    _TXT_state.inputAccessoryView=state_close;
        _TXT_todate.inputAccessoryView=date_close;
       _TXT_fromdate.inputAccessoryView=date_close;
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDate *currentDate = [NSDate date];
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    [comps setYear:-25];
//    NSDate *minDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
//    [comps setYear:18];
//    NSDate *maxDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    
//    NSDate *maxDate = [formatter1 dateFromString:dateString];
//    NSDate *todaysDate = [NSDate date];
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//    [dateComponents setYear:15];
//    NSDate *targetDate = [gregorian dateByAddingComponents:dateComponents toDate:todaysDate  options:0];
//    [_fromdate_picker setMaximumDate:[NSDate date]];
//    [_fromdate_picker setMinimumDate:minDate];
//   [_todate_picker setMaximumDate:self.fromdate_picker.maximumDate];
//    [_todate_picker setMinimumDate:targetDate];

//[_todate_picker addTarget:self action:@selector(choose_to_DATE) forControlEvents:UIControlEventTouchUpInside];

}
-(void)closebuttonClick
{
    [_TXT_state resignFirstResponder];
    [_TXT_todate resignFirstResponder];
    [_TXT_fromdate resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITabbar deligate
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
        [self performSegueWithIdentifier:@"alleventtocourseidentifier" sender:self];
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
        [self performSegueWithIdentifier:@"alleventtoaccountidentifier" sender:self];
    }
}

#pragma mark - Back Action
-(void) backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) BTN_filter
{
    NSLog(@"Filter Tapped");
    
    _state_pickerView=[[UIPickerView alloc]init];
    
    _picker_fromdate = [[UIDatePicker alloc]init];
    _picker_fromdate.datePickerMode = UIDatePickerModeDate;
    
    _picker_todate=[[UIDatePicker alloc]init];
    _picker_todate.datePickerMode=UIDatePickerModeDate;
    
    _state_pickerView.dataSource = self;
    _state_pickerView.delegate = self;
    
    [_picker_fromdate addTarget:self action:@selector(fromdateTextField:) forControlEvents:UIControlEventValueChanged];
    
    
    [_picker_todate addTarget:self action:@selector(todateTextField:) forControlEvents:UIControlEventValueChanged];
    
    _TXT_state.text = @"";
    _TXT_fromdate.text = @"";
    _TXT_todate.text = @"";
    _TXT_state.inputView = _state_pickerView;
    _TXT_todate.inputView = _picker_todate;
    _TXT_fromdate.inputView = _picker_fromdate;
    
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.title = nil;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    _VW_line.hidden = YES;
    _lbl_Serch_char.hidden = YES;
    
//    _VW_filter.hidden = NO;
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.4];
    _VW_filter.hidden=NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_filter cache:YES];
    [UIView commitAnimations];
    
    old_FRAME = _tbl_eventlst.frame;
    
    [UIView animateWithDuration:0.5 animations:^{
        _VW_event_titl.frame = CGRectMake(_VW_event_titl.frame.origin.x, _VW_filter.frame.origin.y + _VW_filter.frame.size.height + 15, _VW_event_titl.frame.size.width, _VW_event_titl.frame.size.height);
        _tbl_eventlst.frame = CGRectMake(_tbl_eventlst.frame.origin.x, _VW_event_titl.frame.origin.y + _VW_event_titl.frame.size.height, _tbl_eventlst.frame.size.width, _tbl_eventlst.frame.size.height - _VW_event_titl.frame.size.height - 25);
    }];
    [UIView commitAnimations];
    
    old_color = _VW_nav_TOP.backgroundColor;
    
    _VW_nav_TOP.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
    _search_BAR.hidden = YES;
    
    CGRect frameimg = CGRectMake(15,5, 80,44);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setTitle:@"" forState:UIControlStateNormal];
//    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [someButton setBackgroundColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0]];
    [someButton.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:24.0f]];
    [someButton.titleLabel setTextColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0]];
    //    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton setBackgroundColor:[UIColor clearColor]];
    [someButton setTitleColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0] forState:UIControlStateNormal];
    [someButton setTitleColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0] forState:UIControlStateHighlighted];
    
    [someButton addTarget:self action:@selector(whenSearchClicked)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem =mailbutton;
    
    self.navigationItem.leftBarButtonItem = nil;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    self.navigationItem.title = @"Filter";
    
}
-(void) whenSearchClicked
{
    if (_VW_filter.hidden == NO) {
        
        [UIView transitionWithView:_VW_filter
                          duration:0.4
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:NULL
                        completion:NULL];
        [self.VW_filter  setHidden:YES];
        
        [UIView animateWithDuration:0.5 animations:^{
            _VW_event_titl.frame = CGRectMake(_VW_event_titl.frame.origin.x, _VW_filter.frame.origin.y + _search_BAR.frame.size.height + 5, _VW_event_titl.frame.size.width, _VW_event_titl.frame.size.height);
            _tbl_eventlst.frame = old_FRAME;
            //            _tbl_eventlst.frame = CGRectMake(_tbl_eventlst.frame.origin.x, _VW_event_titl.frame.origin.y + _VW_event_titl.frame.size.height, _tbl_eventlst.frame.size.width, _tbl_eventlst.frame.origin.y + _tab_HOME.frame.origin.y);
        }];
        [UIView commitAnimations];
    }
    
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.title = nil;
    
    _VW_line.hidden = YES;
    _lbl_Serch_char.hidden = YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    _search_BAR.hidden = NO;
    _search_BAR.text = @"";
    [_search_BAR endEditing:YES];
    
    _VW_nav_TOP.backgroundColor = old_color;
    
    NSLog(@"whenSearchClicked");
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
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    self.navigationItem.title = @"All Events";
    
    CGRect frameimg = CGRectMake(15,5, 80,25);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setTitle:@"FILTER" forState:UIControlStateNormal];
    [someButton setBackgroundColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0]];
    [someButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0]];
    [someButton addTarget:self action:@selector(BTN_filter)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem =mailbutton;
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.title = nil;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    _VW_line.hidden = NO;
    _lbl_Serch_char.hidden = NO;
    
    old_color = _VW_nav_TOP.backgroundColor;
    
    //_VW_nav_TOP.backgroundColor = [UIColor whiteColor];
    _VW_nav_TOP.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
    
    [_search_BAR resignFirstResponder];
    [_search_BAR endEditing:YES];
    _search_BAR.hidden = YES;
    
//    CGRect frame = CGRectMake(0,0, self.navigationController.navigationBar.frame.size.width - 140,44);
//    _search_BAR.frame = frame;
//    _search_BAR.hidden = NO;
    
    searchBar1 = [[UISearchBar alloc]initWithFrame:CGRectMake(0,0, self.navigationController.navigationBar.frame.size.width - 140,44)];
    [searchBar1 setSearchBarStyle:UISearchBarStyleMinimal];
    [searchBar1 setBarStyle:UIBarStyleBlack];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [searchBar1 setTintColor:[UIColor blackColor]];
    [_search_BAR resignFirstResponder];
    [searchBar1 becomeFirstResponder];
//    searchBar1
    
    searchBar1.placeholder = @"Search";
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc]initWithCustomView:searchBar1];
    searchBarItem.tag = 123;
//    searchBarItem.customView.hidden = YES;
//    searchBarItem.customView.alpha = 0.0f;
    self.navigationItem.leftBarButtonItem = searchBarItem;
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(whenSearchClicked)];
//    self.navigationItem.rightBarButtonItem = leftItem;
    
    CGRect frameimg = CGRectMake(15,5, 80,44);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setTitle:@"" forState:UIControlStateNormal];
    [someButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [someButton setBackgroundColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0]];
    [someButton.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:24.0f]];
//        [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    
    [someButton setBackgroundColor:[UIColor clearColor]];
    [someButton setTitleColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0] forState:UIControlStateNormal];
    [someButton setTitleColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0] forState:UIControlStateHighlighted];
    
    [someButton addTarget:self action:@selector(whenSearchClicked)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem =mailbutton;
    
    return YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar == _search_BAR) {
        [_search_BAR resignFirstResponder];
        [searchBar1 becomeFirstResponder];
    }
}

#pragma mark - UITableview Deligate
#pragma Mark - UITableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ARR_allevent count];
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
    
        NSDictionary *temp_DICN = [ARR_allevent objectAtIndex:indexPath.row];
        cell.lbl_event_name.text = [temp_DICN valueForKey:@"name"];
        cell.lbl_event_name.numberOfLines = 0;
        [cell.lbl_event_name sizeToFit];
    
        cell.lbl_event_time.text = [self getLocalDateTimeFromUTC:[temp_DICN valueForKey:@"start_date"]];
    
        [cell.BTN_View_detail setTag:indexPath.row];
        [cell.BTN_View_detail addTarget:self action:@selector(BTN_ALL_EVENT:) forControlEvents:UIControlEventTouchUpInside];

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

#pragma mark - Button Action
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
    
//    [self performSegueWithIdentifier:@"eventDetailidentifier" sender:self];
}

#pragma mark -
#pragma mark PickerView DataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
   if(pickerView==_state_pickerView)
    {
        return 1;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == _state_pickerView) {
        return [_ARR_states count];
    }
    
    
    return 0;
}

#pragma mark -
#pragma mark PickerView Delegate
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
//      inComponent:(NSInteger)component
//{
//    
//    NSString *resultString =[ARR_states objectAtIndex:row];
//    _TXT_state.text = resultString;
//}

//-(void) choose_STATE
//{
//    _picker_STATE.hidden = NO;
//    _tool_STATE.hidden = NO;
//    _tool_DATE.hidden = YES;
//    _picker_DATE.hidden = YES;
//}
-(void) choose_from_DATE
{
    NSLog(@"Tapped from date");
    
//    [_fromdate_picker setMinimumDate:nil];
    
    _TXT_todate.text = @"";
}
-(void) choose_to_DATE
{
    if ([_TXT_fromdate.text isEqualToString:@""])
    {
        [self choose_from_DATE];
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yy"];
        
        NSString *STR_tmp = [NSString stringWithFormat:@"%@",_TXT_fromdate.text];
        
        NSDate *min_date = [[NSDate alloc] init];
        min_date = [formatter dateFromString:STR_tmp];
        
//        [_fromdate_picker setMinimumDate:min_date];
        
        NSLog(@"Tapped to date");
        
    }
}
//
//-(IBAction) pickertapCANCEL
//{
//    NSLog(@"State pickercancelClicked");
//    _picker_STATE.hidden = YES;
//    _tool_STATE.hidden = YES;
//    _TXT_state.text = @"";
//}
//-(IBAction) pickertapDONE
//{
//    NSLog(@"Date pickerDoneClicked");
//    _picker_STATE.hidden = YES;
//    _tool_STATE.hidden = YES;
//}
//
//-(IBAction) datePICKER_CANCEL
//{
//    NSLog(@"datePICKER_CANCEL Tapped");
//    _picker_DATE.hidden = YES;
//    _tool_DATE.hidden = YES;
//}
//-(IBAction) datePICKER_DONE
//{
//    NSLog(@"datePICKER_DONE Tapped");
//    _picker_DATE.hidden = YES;
//    _tool_DATE.hidden = YES;
//    
//    if (_picker_DATE.tag == 1)
//    {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"MM/dd/YY";
//        NSString *string = [formatter stringFromDate:_picker_DATE.date];
//        NSLog(@"Selected Date :- %@",string);
//        _TXT_fromdate.text = string;
//    }
//    else
//    {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"MM/dd/YY";
//        NSString *string = [formatter stringFromDate:_picker_DATE.date];
//        NSLog(@"Selected Date :- %@",string);
//        _TXT_todate.text = string;
//    }
//}


#pragma mark - UIPickerViewDelegate


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView == _state_pickerView) {
        return _ARR_states[row];
    }
    
    return nil;
}

// #6

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
       if (pickerView == _state_pickerView) {
        
        self.TXT_state.text=[_ARR_states objectAtIndex:row];
    }
}


#pragma mark - API Integration
-(void)State_api
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@city_states/states",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
    NSLog(@"The response %@",json_DATA);
    //    NSString *status=[json_DATA objectForKey:@"United States"];
    _ARR_states = [json_DATA allKeys];
    
    
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
        
        [self performSegueWithIdentifier:@"eventDetailidentifier" sender:self];
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

@end

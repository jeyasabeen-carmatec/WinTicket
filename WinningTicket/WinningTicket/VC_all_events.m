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
#import "WinningTicket_Universal-Swift.h"
#import "UITableView+NewCategory.h"

@class FrameObservingView;

@protocol FrameObservingViewDelegate <NSObject>
- (void)frameObservingViewFrameChanged:(FrameObservingView *)view;
@end

@interface FrameObservingView : UIView
@property (nonatomic,assign) id<FrameObservingViewDelegate>delegate;
@end

@implementation FrameObservingView
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.delegate frameObservingViewFrameChanged:self];
}
@end

@interface VC_all_events () <FrameObservingViewDelegate, UITableViewDragLoadDelegate>
{
    CGRect old_FRAME;
    UIColor *old_color;
    UISearchBar *searchBar1;
    NSMutableArray *ARR_allevent;
    UIView *VW_overlay;
    DGActivityIndicatorView *activityIndicatorView;
    
    NSMutableArray *searchResults;
    int intvalue;
}
@property(nonatomic,strong)NSArray *ARR_states;

@end

@implementation VC_all_events

- (void)frameObservingViewFrameChanged:(FrameObservingView *)view
{
    _tbl_eventlst.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _lbl_Serch_char.text = @"";
    [self setup_VIEW];
    
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
//    NSLog(@"The response ALLEvents %@",json_DATA);
    
    NSArray *ARR_tmp = [json_DATA valueForKey:@"events"];
    [ARR_allevent addObjectsFromArray:ARR_tmp];
    
    [self State_api];
    
    _TXT_state.layer.borderWidth = 1.0f;
    _TXT_state.layer.borderColor = [UIColor blackColor].CGColor;
    
    _TXT_todate.layer.borderWidth = 1.0f;
    _TXT_todate.layer.borderColor = [UIColor blackColor].CGColor;
    
    _TXT_fromdate.layer.borderWidth = 1.0f;
    _TXT_fromdate.layer.borderColor = [UIColor blackColor].CGColor;
    
    [_tbl_eventlst setDragDelegate:self refreshDatePermanentKey:@"FriendList"];
    _tbl_eventlst.showLoadMoreView = YES;
}
-(void) fromdateTextField:(id)sender
{
    //    [_fromdate_picker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = _picker_fromdate.date;
    [dateFormat setDateFormat:@"dd-MM-YYYY"];
    
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
        [dateFormat setDateFormat:@"dd-MM-YYYY"];
        
        NSString *dateString = [dateFormat stringFromDate:eventDate];
        _TXT_fromdate.text = [NSString stringWithFormat:@"%@",dateString];
        _TXT_todate.text = @"";
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy"];
        
        NSString *STR_tmp = [NSString stringWithFormat:@"%@",_TXT_fromdate.text];
        
        NSDate *min_date = [[NSDate alloc] init];
        min_date = [formatter dateFromString:STR_tmp];
        
        [_picker_todate setMinimumDate:min_date];
        
        NSDate *eventDate = _picker_todate.date;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-YYYY "];
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
    
    _tbl_search.estimatedRowHeight = 10.0;
    _tbl_search.rowHeight = UITableViewAutomaticDimension;
    _tbl_search.tableFooterView.hidden = YES;
    
    _TXT_fromdate.adjustsFontSizeToFitWidth = YES;
    _TXT_fromdate.minimumFontSize = 5.0;
    _TXT_fromdate.layer.borderWidth = 1.0f;
    _TXT_fromdate.layer.borderColor = [UIColor grayColor].CGColor;
    
    _TXT_todate.adjustsFontSizeToFitWidth = YES;
    _TXT_todate.minimumFontSize = 5.0;
    _TXT_todate.layer.borderWidth = 1.0f;
    _TXT_todate.layer.borderColor = [UIColor grayColor].CGColor;
    
    _TXT_state.layer.borderWidth = 1.0f;
    _TXT_state.layer.borderColor = [UIColor grayColor].CGColor;
    
    if (_search_BAR.hidden == NO)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
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
    _tbl_search.hidden = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FontAwesome" size:32.0f]
       } forState:UIControlStateNormal];
    
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
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, anotherButton] animated:NO];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    self.navigationItem.title = @"All Events";
    
    CGRect frameimg = CGRectMake(15,5, 80,30);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setTitle:@"FILTER" forState:UIControlStateNormal];
    [someButton setBackgroundColor:_segment_bottom.tintColor];
    [someButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0]];
    [someButton addTarget:self action:@selector(BTN_filter)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem =mailbutton;
    
    UIToolbar* state_close = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    state_close.translucent =NO; //.barStyle = UIBarStyleDefault;
    state_close.barTintColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    [state_close sizeToFit];
    UILabel *statelbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, state_close.frame.size.height)];
//    statelbl.center = state_close.center;
//    [state_close addSubview:statelbl];
    statelbl.text = @"Select a State";
    statelbl.textColor = [UIColor blackColor];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        statelbl.font = [UIFont fontWithName:@"GothamMedium" size:18];
    }
    else
    {
        statelbl.font = [UIFont fontWithName:@"GothamMedium" size:16];
    }
    statelbl.backgroundColor = [UIColor clearColor];
    
    /* UIButton *close=[[UIButton alloc]init];
    close.frame=CGRectMake(0, 0, 100, state_close.frame.size.height);
    [close setTitle:@"Done" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [state_close addSubview:close]; */
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(closebuttonClick)];
    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(closebuttonClick)];
    
    UIBarButtonItem *title_lbl = [[UIBarButtonItem alloc] initWithCustomView:statelbl];
    
    [state_close setItems:[NSArray arrayWithObjects: leftButton, flex, title_lbl, flex, rightButton, nil]];
    
    UIToolbar* date_close = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    date_close.translucent =NO; //.barStyle = UIBarStyleDefault;
    date_close.barTintColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    [date_close sizeToFit];
    UILabel *datelbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, date_close.frame.size.height)];
//    [date_close addSubview:datelbl];
    datelbl.text = @"Select Date";
    datelbl.textColor = [UIColor blackColor];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        datelbl.font = [UIFont fontWithName:@"GothamMedium" size:18];
    }
    else
    {
        datelbl.font = [UIFont fontWithName:@"GothamMedium" size:16];
    }
    datelbl.backgroundColor = [UIColor clearColor];

//    UIButton *closeDate =[[UIButton alloc]init];
//    closeDate.frame=CGRectMake(date_close.frame.size.width - 90, 0, 100, date_close.frame.size.height);
//    [closeDate setTitle:@"Close" forState:UIControlStateNormal];
//    [closeDate addTarget:self action:@selector(closebuttonClick) forControlEvents:UIControlEventTouchUpInside];
//    [date_close addSubview:closeDate];
    
    UIBarButtonItem *leftButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(closebuttonClick)];
    
    UIBarButtonItem *flex1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(closebuttonClick)];
    
    UIBarButtonItem *title_lbl1 = [[UIBarButtonItem alloc] initWithCustomView:datelbl];
    
    [date_close setItems:[NSArray arrayWithObjects: leftButton1, flex1, title_lbl1, flex1, rightButton1, nil]];
    
    _TXT_state.inputAccessoryView = state_close;
    _TXT_todate.inputAccessoryView = date_close;
    _TXT_fromdate.inputAccessoryView = date_close;
    
    [_apply addTarget:self action:@selector(apply_Clicked) forControlEvents:UIControlEventTouchUpInside];
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
//        NSLog(@"Events selected");
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
//        NSLog(@"COURSES selected");
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
//        NSLog(@"ACCOUNT selected");
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
//    NSLog(@"Filter Tapped");
    
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
    
    CGRect frameimg = CGRectMake(15,5, 25,25);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
//    [someButton setTitle:@"" forState:UIControlStateNormal];
//    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [someButton setBackgroundColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0]];
//    [someButton.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:24.0f]];
    [someButton setBackgroundColor:[UIColor clearColor]];
//    [someButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *new_image = [UIImage imageNamed:@"cross"];
    UIImageView *temp_IMG = [[UIImageView alloc]initWithFrame:someButton.frame];
    temp_IMG.image = new_image;
    
    UIImage *newImage = [temp_IMG.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(temp_IMG.image.size, NO, newImage.scale);
    [[UIColor blackColor] set];
    [newImage drawInRect:CGRectMake(0, 0, temp_IMG.image.size.width, newImage.size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    temp_IMG.image = newImage;
    
    [someButton setBackgroundImage:temp_IMG.image forState:UIControlStateNormal];
    
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
    _tbl_search.hidden = YES;
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
    
//    NSLog(@"whenSearchClicked");
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FontAwesome" size:32.0f]
       } forState:UIControlStateNormal];
    
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
    self.navigationItem.title = @"All Events";
    
    CGRect frameimg = CGRectMake(15,5, 80,30);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setTitle:@"FILTER" forState:UIControlStateNormal];
    [someButton setBackgroundColor:_segment_bottom.tintColor];
    [someButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0]];
    [someButton addTarget:self action:@selector(BTN_filter)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem =mailbutton;
}

#pragma mark - UISearchBar Deligate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.title = nil;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    _VW_line.hidden = NO;
    _lbl_Serch_char.hidden = NO;
    
    old_color = _VW_nav_TOP.backgroundColor;
    
    _VW_nav_TOP.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
    
    [_search_BAR resignFirstResponder];
    _search_BAR.hidden = YES;
    
    
    searchBar1 = [[UISearchBar alloc]initWithFrame:CGRectMake(0,0, self.navigationController.navigationBar.frame.size.width - 75,44)];
    [searchBar1 setSearchBarStyle:UISearchBarStyleMinimal];
    [searchBar1 setBarStyle:UIBarStyleBlack];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [searchBar1 setTintColor:[UIColor blackColor]];
    [searchBar1 becomeFirstResponder];
    
    searchBar1.placeholder = @"Search";
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc]initWithCustomView:searchBar1];
    searchBarItem.tag = 123;
    self.navigationItem.leftBarButtonItem = searchBarItem;
    
    CGRect frameimg = CGRectMake(15,5, 25,25);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
//    [someButton setTitle:@"" forState:UIControlStateNormal];
//    [someButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [someButton.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:24.0f]];
    
    [someButton setBackgroundColor:[UIColor clearColor]];
//    [someButton setTitleColor:_segment_bottom.tintColor forState:UIControlStateNormal];
    
    UIImage *new_image = [UIImage imageNamed:@"cross"];
    UIImageView *temp_IMG = [[UIImageView alloc]initWithFrame:someButton.frame];
    temp_IMG.image = new_image;
    
    UIImage *newImage = [temp_IMG.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(temp_IMG.image.size, NO, newImage.scale);
    [[UIColor blackColor] set];
    [newImage drawInRect:CGRectMake(0, 0, temp_IMG.image.size.width, newImage.size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    temp_IMG.image = newImage;
    
    [someButton setBackgroundImage:temp_IMG.image forState:UIControlStateNormal];
    
    [someButton addTarget:self action:@selector(whenSearchClicked)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    [someButton addTarget:self action:@selector(whenSearchClicked)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem =mailbutton;
    
    return YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchBar1.text = searchText;
    _lbl_Serch_char.text = [NSString stringWithFormat:@"Searching ' %@ '",searchText];
    
    UITextField *searchBarTextField = [self findTextFieldFromControl:searchBar1];
    [searchBarTextField addTarget:self action:@selector(getSearch_TXT) forControlEvents:UIControlEventEditingChanged];
    
    [searchResults removeAllObjects];
    
    if([searchText length] != 0)
    {
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(searcH_API) withObject:activityIndicatorView afterDelay:0.01];
    }
}

-(void) getSearch_TXT
{
    NSString *str = searchBar1.text;
    _lbl_Serch_char.text = [NSString stringWithFormat:@"Searching ' %@ '",str];
    NSLog(@"Updated Text working %@",str);
    
    if([str length] != 0)
    {
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(searcH_API) withObject:activityIndicatorView afterDelay:0.01];
    }
}

- (UITextField *) findTextFieldFromControl:(UIView *) view
{
    for (UIView *subview in view.subviews)
    {
        if ([subview isKindOfClass:[UITextField class]])
        {
            return (UITextField *)subview;
        }
        else if ([subview.subviews count] > 0)
        {
            UIView *view = [self findTextFieldFromControl:subview];
            if (view) {
                return (UITextField *)view;
            }
        }
    }
    return nil;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    NSString* newText = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
//    NSLog(@"Search text = %@",newText);
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    NSLog(@"Search done tapped");
//    UITextField *searchBarTextField = [self findTextFieldFromControl:searchBar1];
//    [searchBarTextField addTarget:self action:@selector(getSearch_TXT) forControlEvents:UIControlEventEditingChanged];
//    [searchBarTextField resignFirstResponder];
}

#pragma mark - UITableview Deligate
#pragma Mark - UITableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tbl_search) {
        return [searchResults count];
    }
    return [ARR_allevent count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbl_search)
    {
        static NSString *CellIdentifier = @"Cell";
        Cell_search *cell = (Cell_search *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib;
            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
            {
                nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_search~iPad" owner:self options:nil];
            }
            else
            {
                nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_search" owner:self options:nil];
            }
            cell = [nib objectAtIndex:0];
        }
        
        cell.lbl_eventName.text = [searchResults objectAtIndex:indexPath.row];
        cell.lbl_eventName.numberOfLines = 0;
        [cell.lbl_eventName sizeToFit];
        
        return cell;
    }
    else
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
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbl_search)
    {
        NSString *STR_eventname = [searchResults objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setValue:STR_eventname forKey:@"EVENT_NAME_STORED"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        _lbl_Serch_char.text = STR_eventname;
        
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(get_event_ID) withObject:activityIndicatorView afterDelay:0.01];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != _tbl_search)
    {
        if (indexPath.row % 2)
        {
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.95 alpha:1.0];
        }
        else
        {
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        }
    }
}

#pragma mark - Button Action
-(void)apply_Clicked
{
    [activityIndicatorView startAnimating];
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-mm-yyyy"];
    NSDate *fromdate=[formatter dateFromString:_TXT_fromdate.text];
    NSDate *todate=[formatter dateFromString:_TXT_todate.text];
    NSString *str1=[formatter stringFromDate:fromdate];
    NSString *str2=[formatter stringFromDate:todate];
    
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@events/all_events?start_date=%@&end_date=%@",SERVER_URL,str1,str2];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setHTTPShouldHandleCookies:NO];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(aData)
    {
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:&error];
        //    NSLog(@"The response %@",json_DATA);
        NSLog(@"the filterdata is:%@",json_DATA);
        
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"ALLEvents"];
        [[NSUserDefaults standardUserDefaults] setObject:urlGetuser forKey:@"URL_SAVED"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [ARR_allevent removeAllObjects];
        NSMutableArray *temp_ARR=[json_DATA valueForKey:@"events"];
        [ARR_allevent addObjectsFromArray:temp_ARR];
        
        [_tbl_eventlst reloadData];
        [activityIndicatorView stopAnimating];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    
}

-(void) BTN_ALL_EVENT : (UIButton *) sender
{
    NSIndexPath *buttonIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
//    NSLog(@"From Delete Skill %ld",(long)buttonIndexPath.row);
    
    NSString *index_str = [NSString stringWithFormat:@"%ld",(long)buttonIndexPath.row];
    
//    NSLog(@"Index path of All Event %@",index_str);
    
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
//    NSLog(@"Tapped from date");
    
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
        
//        NSLog(@"Tapped to date");
        
    }
}


#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView == _state_pickerView) {
        return _ARR_states[row];
    }
    
    return nil;
}


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
    if(aData)
    {
    NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
//    NSLog(@"The response %@",json_DATA);
    _ARR_states = [json_DATA allKeys];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    

}

#pragma mark - Date Convert
-(NSString *)getLocalDateTimeFromUTC:(NSString *)strDate
{
//    NSLog(@"Date Input tbl %@",strDate);
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    NSDate *currentDate = [dateFormatter dateFromString:strDate];
//    NSLog(@"CurrentDate:%@", currentDate);
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
        
     //   [self performSegueWithIdentifier:@"eventDetailidentifier" sender:self];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self performSegueWithIdentifier:@"allevent_to_eventDetail" sender:self];
                
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

#pragma mark - Search API
-(void) searcH_API
{
    searchResults = [[NSMutableArray alloc] init];
    
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSString *search_char = searchBar1.text;
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@events/autocomplete?query=%@",SERVER_URL,search_char];
    urlGetuser = [urlGetuser stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSMutableDictionary *json_DATA;
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
//        NSLog(@"The response %@",json_DATA);
        
        NSArray *ARR_events = [json_DATA valueForKey:@"events"];
        for (int i = 0; i < [ARR_events count]; i ++)
        {
            NSDictionary *temp_DICTN = [ARR_events objectAtIndex:i];
            NSString *event_name = [temp_DICTN valueForKey:@"name"];
            [searchResults addObject:event_name];
        }
        
        if ([searchResults count] != 0)
        {
            _tbl_search.hidden = NO;
            _lbl_Serch_char.text = [NSString stringWithFormat:@"%lu ' %@ ' Found",(unsigned long)[searchResults count],searchBar1.text];
            [_tbl_search reloadData];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No results Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            _tbl_search.hidden = YES;
        }
        
        
       
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

//Auto sugession Tap Event name
-(void) get_event_ID
{
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSString *event_NME = [[NSUserDefaults standardUserDefaults] valueForKey:@"EVENT_NAME_STORED"];
    event_NME = [event_NME stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ([UIScreen mainScreen].bounds.size.height > 667)
        {
            urlGetuser = [NSString stringWithFormat:@"%@events/all_events?per_page=13&event_name=%@",SERVER_URL,event_NME];
        }
        else
        {
            urlGetuser = [NSString stringWithFormat:@"%@events/all_events?per_page=10&event_name=%@",SERVER_URL,event_NME];
        }
    }
    else
    {
        urlGetuser = [NSString stringWithFormat:@"%@events/all_events?per_page=20&event_name=%@",SERVER_URL,event_NME];
    }
    
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSMutableDictionary *json_DATA;
    if (aData)
    {
        json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
//        NSLog(@"Search Event tapped %@",json_DATA);
        
        NSArray *ARR_tmp = [json_DATA valueForKey:@"events"];
        
        ARR_allevent = [[NSMutableArray alloc]init];
        [ARR_allevent addObjectsFromArray:ARR_tmp];
        
        _tbl_search.hidden = YES;
        [_tbl_eventlst reloadData];
        
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

#pragma mark - Control datasource
- (void)finishRefresh
{
    [_tbl_eventlst finishRefresh];
}

- (void)finishLoadMore
{
    [_tbl_eventlst finishLoadMore];
}

#pragma mark - Drag delegate methods
- (void)dragTableDidTriggerRefresh:(UITableView *)tableView
{
    //Pull up go to First Page
    NSString *url_STR = [NSString stringWithFormat:@"%@&page=1",[[NSUserDefaults standardUserDefaults] valueForKey:@"URL_SAVED"]];
    [[NSUserDefaults standardUserDefaults] setObject:url_STR forKey:@"URL_SAVED"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self performSelector:@selector(Firstpage_API) withObject:nil afterDelay:0.01];
}

- (void)dragTableRefreshCanceled:(UITableView *)tableView
{
    //cancel refresh request(generally network request) here
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishRefresh) object:nil];
}

- (void)dragTableDidTriggerLoadMore:(UITableView *)tableView
{
    //Pull up go to NextPage
    NSError *error;
    NSData *aData = [[NSUserDefaults standardUserDefaults] valueForKey:@"ALLEvents"];
    NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
//    NSLog(@"The response ALLEvents Pagination Method %@",json_DATA);
    NSString *url_STR;
    
    NSDictionary *temp_Dictin = [json_DATA valueForKey:@"meta"];
    NSString *nextPAGE = [NSString stringWithFormat:@"%@",[temp_Dictin valueForKey:@"next_page"]];
    if ([nextPAGE isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Already in Last Page" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        [self performSelector:@selector(finishLoadMore) withObject:nil afterDelay:2];
    }
    else
    {
        url_STR = [NSString stringWithFormat:@"%@&page=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"URL_SAVED"],nextPAGE];
        [[NSUserDefaults standardUserDefaults] setObject:url_STR forKey:@"URL_SAVED"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSelector:@selector(NEXTpage_API) withObject:nil afterDelay:0.01];
    }
}

- (void)dragTableLoadMoreCanceled:(UITableView *)tableView
{
    //cancel load more request(generally network request) here
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishLoadMore) object:nil];
}

-(void) NEXTpage_API
{
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSError *error;
    NSHTTPURLResponse *response = nil;
    
    NSURL *urlProducts=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"URL_SAVED"]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"From VC_all_events Pagination testing :%@",dict);
        
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"ALLEvents"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSData *aData = [[NSUserDefaults standardUserDefaults] valueForKey:@"ALLEvents"];
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSArray *ARR_tmp = [json_DATA valueForKey:@"events"];
        [ARR_allevent addObjectsFromArray:ARR_tmp];
        
        [_tbl_eventlst reloadData];
        
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    [self performSelector:@selector(finishLoadMore) withObject:nil afterDelay:0.01];
}

-(void) Firstpage_API
{
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSError *error;
    NSHTTPURLResponse *response = nil;
    
    NSURL *urlProducts=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"URL_SAVED"]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"From VC_all_events Pagination testing :%@",dict);
        
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"ALLEvents"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [ARR_allevent removeAllObjects];
        NSData *aData = [[NSUserDefaults standardUserDefaults] valueForKey:@"ALLEvents"];
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSArray *ARR_tmp = [json_DATA valueForKey:@"events"];
        [ARR_allevent addObjectsFromArray:ARR_tmp];
        
        [_tbl_eventlst reloadData];
        
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    [self performSelector:@selector(finishRefresh) withObject:nil afterDelay:0.01];
}

@end

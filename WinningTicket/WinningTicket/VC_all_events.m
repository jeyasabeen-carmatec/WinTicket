//
//  VC_all_events.m
//  WinningTicket
//
//  Created by Test User on 22/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_all_events.h"
#import "TBL_VW_Cell_EVENTS.h"

@interface VC_all_events ()
{
    CGRect old_FRAME;
    UIColor *old_color;
    UISearchBar *searchBar1;
    NSMutableArray *ARR_allevent,*ARR_states;
}

@end

@implementation VC_all_events

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
    
    _picker_STATE.hidden = YES;
    _picker_DATE.hidden = YES;
    [_picker_DATE setBackgroundColor:[UIColor whiteColor]];
    
    _tool_DATE.hidden = YES;
    _tool_STATE.hidden = YES;
    
    [_BTN_choose addTarget:self action:@selector(choose_STATE) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_fromDATE addTarget:self action:@selector(choose_from_DATE) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_toDATE addTarget:self action:@selector(choose_to_DATE) forControlEvents:UIControlEventTouchUpInside];
    
    ARR_allevent = [[NSMutableArray alloc]init];
    ARR_states = [[NSMutableArray alloc]init];
    
    NSDictionary *temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event",@"Event_Name",@"Feb 25, 2017 11:30AM EST",@"Event_Time", nil];
    [ARR_allevent addObject:temp_Dictn];
    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Murray Bros. Caddyshack Charity Golf Tournament",@"Event_Name",@"Mar 22, 2017 03:00PM EST",@"Event_Time", nil];
    [ARR_allevent addObject:temp_Dictn];
    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Susan G Komen 2017 Golf Classic",@"Event_Name",@"Mar 31,2017 11:00AM EST",@"Event_Time", nil];
    [ARR_allevent addObject:temp_Dictn];
    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event",@"Event_Name",@"Feb 25, 2017 11:30AM EST",@"Event_Time", nil];
    [ARR_allevent addObject:temp_Dictn];
    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Murray Bros. Caddyshack Charity Golf Tournament",@"Event_Name",@"Mar 22, 2017 03:00PM EST",@"Event_Time", nil];
    [ARR_allevent addObject:temp_Dictn];
    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Susan G Komen 2017 Golf Classic",@"Event_Name",@"Mar 31,2017 11:00AM EST",@"Event_Time", nil];
    [ARR_allevent addObject:temp_Dictn];
    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event",@"Event_Name",@"Feb 25, 2017 11:30AM EST",@"Event_Time", nil];
    [ARR_allevent addObject:temp_Dictn];
    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Murray Bros. Caddyshack Charity Golf Tournament",@"Event_Name",@"Mar 22, 2017 03:00PM EST",@"Event_Time", nil];
    [ARR_allevent addObject:temp_Dictn];
    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Susan G Komen 2017 Golf Classic",@"Event_Name",@"Mar 31,2017 11:00AM EST",@"Event_Time", nil];
    [ARR_allevent addObject:temp_Dictn];
    temp_Dictn = [NSDictionary dictionaryWithObjectsAndKeys:@"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event",@"Event_Name",@"Feb 25, 2017 11:30AM EST",@"Event_Time", nil];
    [ARR_allevent addObject:temp_Dictn];
    
    [ARR_states addObject:@"Qassim"];
    [ARR_states addObject:@"Riyadh"];
    [ARR_states addObject:@"Tabuk"];
    [ARR_states addObject:@"Madinah"];
    [ARR_states addObject:@"Makkah"];
    [ARR_states addObject:@"Northern Borders"];
    [ARR_states addObject:@"Jawf"];
    [ARR_states addObject:@"Ha'il"];
    [ARR_states addObject:@"Bahah"];
    [ARR_states addObject:@"Jizan"];
    [ARR_states addObject:@"'Asir"];
    [ARR_states addObject:@"Qassim"];
    [ARR_states addObject:@"Riyadh"];
    [ARR_states addObject:@"Tabuk"];
    [ARR_states addObject:@"Madinah"];
    [ARR_states addObject:@"Makkah"];
    [ARR_states addObject:@"Northern Borders"];
    [ARR_states addObject:@"Jawf"];
    [ARR_states addObject:@"Ha'il"];
    [ARR_states addObject:@"Bahah"];
    [ARR_states addObject:@"Jizan"];
    [ARR_states addObject:@"'Asir"];
    [ARR_states addObject:@"Qassim"];
    [ARR_states addObject:@"Riyadh"];
    [ARR_states addObject:@"Tabuk"];
    [ARR_states addObject:@"Madinah"];
    [ARR_states addObject:@"Makkah"];
    [ARR_states addObject:@"Northern Borders"];
    [ARR_states addObject:@"Jawf"];
    [ARR_states addObject:@"Ha'il"];
    [ARR_states addObject:@"Bahah"];
    [ARR_states addObject:@"Jizan"];
    [ARR_states addObject:@"'Asir"];
    
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
    
    _TXT_state.text = @"";
    _TXT_fromdate.text = @"";
    _TXT_todate.text = @"";
    
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
    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [someButton setBackgroundColor:[UIColor colorWithRed:0.07 green:0.33 blue:0.42 alpha:1.0]];
    [someButton.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:24.0f]];
    //    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
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
        cell.lbl_event_name.text = [temp_DICN valueForKey:@"Event_Name"];
        cell.lbl_event_name.numberOfLines = 0;
        [cell.lbl_event_name sizeToFit];
        cell.lbl_event_time.text = [temp_DICN valueForKey:@"Event_Time"];
        
        [cell.BTN_View_detail setTag:indexPath.row];
        [cell.BTN_View_detail addTarget:self action:@selector(BTN_ALL_EVENT:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *temp_DICN = [ARR_allevent objectAtIndex:indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@",[temp_DICN valueForKey:@"Event_Name"]];

    CGSize labelWidth = CGSizeMake(_tbl_eventlst.frame.size.width - 16, CGFLOAT_MAX); // 300 is fixed width of label. You can change this value
    CGRect textRect;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        textRect = [str boundingRectWithSize:labelWidth options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0]} context:nil];
    }
    else
    {
        textRect = [str boundingRectWithSize:labelWidth options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0]} context:nil];
    }
    
    int calculatedHeight = textRect.size.height+10;
    return calculatedHeight+20;
    
}
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
    
    [self performSegueWithIdentifier:@"eventDetailidentifier" sender:self];
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return ARR_states.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [ARR_states objectAtIndex:row];
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    NSString *resultString =[ARR_states objectAtIndex:row];
    _TXT_state.text = resultString;
}

-(void) choose_STATE
{
    _picker_STATE.hidden = NO;
    _tool_STATE.hidden = NO;
    _tool_DATE.hidden = YES;
    _picker_DATE.hidden = YES;
}
-(void) choose_from_DATE
{
    NSLog(@"Tapped from date");
    _tool_DATE.hidden = NO;
    _picker_DATE.hidden = NO;
    _picker_STATE.hidden = YES;
    _tool_STATE.hidden = YES;
    
    [_picker_DATE setMinimumDate:nil];
    
    _picker_DATE.tag = 1;
    _tool_DATE.tag = 1;
    
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
        
        [_picker_DATE setMinimumDate:min_date];
        
        NSLog(@"Tapped to date");
        _tool_DATE.hidden = NO;
        _picker_DATE.hidden = NO;
        _picker_STATE.hidden = YES;
        _tool_STATE.hidden = YES;
        
        _picker_DATE.tag = 2;
        _tool_DATE.tag = 2;
    }
}

-(IBAction) pickertapCANCEL
{
    NSLog(@"State pickercancelClicked");
    _picker_STATE.hidden = YES;
    _tool_STATE.hidden = YES;
    _TXT_state.text = @"";
}
-(IBAction) pickertapDONE
{
    NSLog(@"Date pickerDoneClicked");
    _picker_STATE.hidden = YES;
    _tool_STATE.hidden = YES;
}

-(IBAction) datePICKER_CANCEL
{
    NSLog(@"datePICKER_CANCEL Tapped");
    _picker_DATE.hidden = YES;
    _tool_DATE.hidden = YES;
}
-(IBAction) datePICKER_DONE
{
    NSLog(@"datePICKER_DONE Tapped");
    _picker_DATE.hidden = YES;
    _tool_DATE.hidden = YES;
    
    if (_picker_DATE.tag == 1)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM/dd/YY";
        NSString *string = [formatter stringFromDate:_picker_DATE.date];
        NSLog(@"Selected Date :- %@",string);
        _TXT_fromdate.text = string;
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM/dd/YY";
        NSString *string = [formatter stringFromDate:_picker_DATE.date];
        NSLog(@"Selected Date :- %@",string);
        _TXT_todate.text = string;
    }
}

@end

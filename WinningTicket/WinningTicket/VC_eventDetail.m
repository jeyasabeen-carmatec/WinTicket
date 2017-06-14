//
//  VC_eventDetail.m
//  WinningTicket
//
//  Created by Test User on 27/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_eventDetail.h"

#pragma mark - Image Cache
#import "SDWebImage/UIImageView+WebCache.h"

@interface VC_eventDetail ()

@end

@implementation VC_eventDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self set_FRAME];
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
    
    [self setup_VIEW];
    
   /* for (int i=0; i<[self.segment_bottom.subviews count]; i++)
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
    }*/
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, _BTN_purchasetkt.frame.origin.y + _BTN_purchasetkt.frame.size.height + 20);
}

#pragma mark - View customisation
-(void) setup_VIEW
{
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test date format" message:[self change_date:@"sample"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//    [alert show];
    
//    [_tab_HOME setSelectedItem:[_tab_HOME.items objectAtIndex:0]];
//    [_segment_bottom setSelectedSegmentIndex:0];
    
//    self.navigationController.navigationBar.hidden = NO;
    
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
    self.navigationItem.title = @"Event Detail";
    
    UIImage *newImage = [_img_cstmlbl.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(_img_cstmlbl.image.size, NO, newImage.scale);
    [_VW_dateandtime.backgroundColor set];
    [newImage drawInRect:CGRectMake(0, 0, _img_cstmlbl.image.size.width, newImage.size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _img_cstmlbl.image = newImage;
}

-(void) set_FRAME
{
    NSError *error;
    NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"upcoming_events"] options:NSASCIIStringEncoding error:&error];
    NSLog(@"thedata VC Event Detail Upcoming:%@",dict);
    
    NSDictionary *temp_dict = [dict valueForKey:@"event"];
    
    CGRect old_frame = _lbl_eventname.frame;
    
    _lbl_eventname.text = [temp_dict valueForKey:@"name"];
    _lbl_eventname.numberOfLines = 0;
    [_lbl_eventname sizeToFit];
    
    NSLog(@"Image Url is %@",[NSString stringWithFormat:@"%@%@",IMAGE_URL,[temp_dict valueForKey:@"avatar_url"]]);
    
    [_img_event sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[temp_dict valueForKey:@"avatar_url"]]]
                      placeholderImage:[UIImage imageNamed:@"Logo_WT.png"]];
    _img_event.contentMode = UIViewContentModeScaleAspectFit;
    
    float image_height = _img_event.frame.size.height;
    float lbl_event_name_ht = _lbl_eventname.frame.size.height;
    
    _lbl_code.text=[temp_dict valueForKey:@"code"];
    NSString *location = @"Grand Cypress Country Club";//[NSString stringWithFormat:@"%@",[temp_dict valueForKey:@"location"]];
    NSString *address = @"1 N Jacaranda ST, Orlando, FL 32836";
    NSString *date = [self getLocalDateFromUTC:[temp_dict valueForKey:@"start_date"]];
    NSString *time = [self getLocalTimeFromUTC:[temp_dict valueForKey:@"start_date"]];
    
    NSLog(@"Date format %@",date);
    NSLog(@"Time format %@",time);
    
    _lbl_date.text=date;
    _lbl_time.text=time;

   /* if ([location isEqualToString:@"<null>"])
    {
       location = @"Not Mentioned";
    }else
    {
        location=@"US";
    }*/
    

    NSString *text = [NSString stringWithFormat:@"%@\n%@",location,address];
    
    // If attributed text is supported (iOS6+)
    if ([self.lbl_eventdetail respondsToSelector:@selector(setAttributedText:)]) {
        
        // Define general attributes for the entire text
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.lbl_eventdetail.textColor,
                                  NSFontAttributeName: self.lbl_eventdetail.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:text
                                               attributes:attribs];
        
        // Red text attributes
        //            UIColor *redColor = [UIColor redColor];
        NSRange cmp = [text rangeOfString:location];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamMedium" size:18.0]}
                                    range:cmp];
        }
        else
        {
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamMedium" size:17.0]}
                                    range:cmp];
        }
        
        
        self.lbl_eventdetail.attributedText = attributedText;
    }
    else
    {
        self.lbl_eventdetail.text = text;
    }
    
    self.lbl_eventdetail.numberOfLines = 0;
    [self.lbl_eventdetail sizeToFit];
    
    [_scroll_contents addSubview:_VW_dateandtime];
    
    float difference;
    
    if (image_height < lbl_event_name_ht)
    {
        difference = lbl_event_name_ht - image_height;
        
        CGRect frame_NN = _VW_dateandtime.frame;
        frame_NN.origin.y = frame_NN.origin.y + difference;
        _VW_dateandtime.frame = frame_NN;
        
        frame_NN = _img_cstmlbl.frame;
        frame_NN.origin.y = _img_cstmlbl.frame.origin.y + difference;
        _img_cstmlbl.frame = frame_NN;
        
        frame_NN = _lbl_code.frame;
        frame_NN.origin.y = _lbl_code.frame.origin.y + difference;
        _lbl_code.frame = frame_NN;
        
        frame_NN = _lbl_location.frame;
        frame_NN.origin.y = _lbl_location.frame.origin.y + difference;
        _lbl_location.frame = frame_NN;
        
        frame_NN = _lbl_eventdetail.frame;
        frame_NN.origin.y = _lbl_eventdetail.frame.origin.y + difference;
        _lbl_eventdetail.frame = frame_NN;
        
        CGRect frame_IMGE = _img_event.frame;
        frame_IMGE.size.height = _lbl_eventname.frame.size.height;
        _img_event.frame = frame_IMGE;
    }
    else
    {
        _lbl_eventname.frame = old_frame;
    }
    
    CGRect frame_HT = _VW_eventcontent.frame;
    frame_HT.size.height = _lbl_eventdetail.frame.origin.y + _lbl_eventdetail.frame.size.height + 20;
    _VW_eventcontent.frame = frame_HT;
    
    _lbl_ticketdescription.text = @"To gain access to this event’s features, purchasing a Winning Ticket is required";
    _lbl_ticketdescription.numberOfLines = 0;
    [_lbl_ticketdescription sizeToFit];
    
    frame_HT = _lbl_ticketdescription.frame;
    frame_HT.origin.y = _VW_eventcontent.frame.origin.y + _VW_eventcontent.frame.size.height + 10;
    frame_HT.size.width = _scroll_contents.frame.size.width - _lbl_ticketdescription.frame.origin.x * 2;
    _lbl_ticketdescription.frame = frame_HT;
    
    frame_HT = _BTN_purchasetkt.frame;
    frame_HT.origin.y = _lbl_ticketdescription.frame.origin.y + _lbl_ticketdescription.frame.size.height + 10;
    _BTN_purchasetkt.frame = frame_HT;
    
    [_BTN_purchasetkt addTarget:self action:@selector(tap_purchaseTKT) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"VCSTAT"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"VCSTAT"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        _BTN_purchasetkt.hidden = YES;
        _lbl_ticketdescription.hidden = YES;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*#pragma mark - Tabbar deligate
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
        [self performSegueWithIdentifier:@"eventdetailtocourseidentifier" sender:self];
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
        [self performSegueWithIdentifier:@"eventdetailtoaccount" sender:self];
    }
}
*/
#pragma mark - Button Actions
-(void) tap_purchaseTKT
{
    NSLog(@"tap_purchaseTKT tapped");
}

#pragma mark - Back Action
-(void) backAction
{
    NSLog(@"Back tapped");
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Event Detail
-(NSString *) change_date : (NSString *) date_STR
{
    //Getting date from string
    NSString *dateString = @"09-03-2015";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:dateString];
    // converting into our required date format
    [dateFormatter setDateFormat:@"EEEE, MMMM dd, yyyy"];
    NSString *reqDateString = [dateFormatter stringFromDate:date];
    NSLog(@"date is %@", reqDateString);
    return reqDateString;
}

#pragma mark - Date Convert
-(NSString *)getLocalDateFromUTC:(NSString *)strDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    NSDate *currentDate = [dateFormatter dateFromString:strDate];
    NSLog(@"CurrentDate:%@", currentDate);
    NSDateFormatter *newFormat = [[NSDateFormatter alloc] init];
    [newFormat setDateFormat:@"EEEE, MMMM dd, yyyy"];
    return [newFormat stringFromDate:currentDate];
}
-(NSString *)getLocalTimeFromUTC:(NSString *)strDate
{
    NSLog(@"Input Date %@",strDate);
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    NSDate *currentDate = [dateFormatter dateFromString:strDate];
    NSLog(@"CurrentDate:%@", currentDate);
    
    NSDateFormatter *userFormatter = [[NSDateFormatter alloc] init];
    [userFormatter setDateFormat:@"h:mm a"];
    [userFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
    
    return [userFormatter stringFromDate:currentDate];
}

@end

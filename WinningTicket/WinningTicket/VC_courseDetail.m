//
//  VC_courseDetail.m
//  WinningTicket
//
//  Created by Test User on 19/07/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_courseDetail.h"
#import "UIImageView+WebCache.h"

@interface VC_courseDetail ()
{
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
    
    float initial_ht,original_ht,button_ht,lbl_descrip_ht;
    CGRect initial_frame,original_frame,button_frame;
    float layout_height;
}

@end

@implementation VC_courseDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    [self serialize_jsonData];
    
    [_BTN_more addTarget:self action:@selector(button_More_TApped) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - Uiview Customisation
-(void) setup_View
{
    VW_overlay.hidden = YES;
    
    _mapView.settings.compassButton = YES;
    _search_BAR.hidden = YES;
    _BTN_close.hidden = YES;
    [_BTN_back addTarget:self action:@selector(METH_back) forControlEvents:UIControlEventTouchUpInside];
    
   // _Scroll_contents.hidden = YES;
    
   /* CGRect BTN_frame = _BTN_swipeUP_DN.frame;
    BTN_frame.origin.x = _VW_course.frame.size.width/2 - _BTN_swipeUP_DN.frame.size.width/2;
    BTN_frame.origin.y = _VW_course.frame.origin.y - _BTN_swipeUP_DN.frame.size.height/2;
    _BTN_swipeUP_DN.frame = BTN_frame;*/
    
    _BTN_swipeUP_DN.layer.borderWidth = 1.0;
    _BTN_swipeUP_DN.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _BTN_swipeUP_DN.layer.cornerRadius = _BTN_swipeUP_DN.frame.size.width/2;
    _BTN_swipeUP_DN.layer.masksToBounds = YES;
    
    _IMG_course_image.layer.cornerRadius = _IMG_course_image.frame.size.width/2;
    _IMG_course_image.layer.masksToBounds = YES;
    
    [_BTN_swipeUP_DN addTarget:self action:@selector(METH_swipeUP_BTN) forControlEvents:UIControlEventAllEvents];
    lbl_descrip_ht = _Lbl_course_Description.frame.size.height;
}


#pragma mark - Uibutton Methords
-(void) METH_back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) METH_swipeUP_BTN
{
    NSLog(@"Tap detected ");
    
    if ([_BTN_swipeUP_DN.titleLabel.text isEqualToString:@""])
    {
        CGRect frame_map = _mapView.frame;
        frame_map.size.height = _mapView.frame.size.height/4 + _VW_navBAR.frame.size.height + _BTN_swipeUP_DN.frame.size.height;
        [UIView animateWithDuration:0.4f
                         animations:^{
                             _mapView.frame = frame_map;
                         }];
        
        CGRect frame_scroll = _Scroll_contents.frame;
        frame_scroll.origin.y = _VW_navBAR.frame.size.height + frame_map.size.height - _BTN_swipeUP_DN.frame.size.height;
        frame_scroll.size.height = [UIScreen mainScreen].bounds.size.height - frame_map.size.height;
        
        [UIView beginAnimations:@"bucketsOff" context:NULL];
        [UIView setAnimationDuration:0.4f];
        _Scroll_contents.frame = frame_scroll;
        [UIView commitAnimations];
        
        layout_height = _VW_couseDesc.frame.origin.y + _VW_couseDesc.frame.size.height;
        
        [_BTN_swipeUP_DN setTitle:@"" forState:UIControlStateNormal];
    }
    else
    {
        CGRect frame_map = _mapView.frame;
        frame_map.size.height = initial_ht;
        [UIView animateWithDuration:0.4f
                         animations:^{
                             _mapView.frame = frame_map;
                         }];
        
        [UIView beginAnimations:@"bucketsOff" context:NULL];
        [UIView setAnimationDuration:0.4f];
        _Scroll_contents.frame = initial_frame;
        [UIView commitAnimations];
        
        layout_height = initial_frame.size.height;
        
        [_BTN_swipeUP_DN setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void) button_More_TApped
{
    
}

#pragma mark - API Integration
-(void) get_selectedCourse:(NSString *)course_ID
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@golfcourse/course_detail?id=%@",SERVER_URL,course_ID];
    
    NSLog(@"Course url = \n%@",urlGetuser);
    
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
        
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"CourseDetailcontent"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self serialize_jsonData];
    }
    
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
}

#pragma mark - JsonSerialisation
-(void) serialize_jsonData
{
    NSError *error;
    NSMutableDictionary *temp_dictin = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetailcontent"] options:kNilOptions error:&error];
    
    [self setup_View];
    NSDictionary *selected_course = [temp_dictin valueForKey:@"course_detail"];
    
    NSLog(@"Value from VC couse detail selected_course = \n%@",selected_course);
    
    NSString *selected_coursename = [selected_course valueForKey:@"name"];
    
    
    double latitude_val = [[NSString stringWithFormat:@"%@",[selected_course valueForKey:@"lat"]] doubleValue];
    double longitude_val = [[NSString stringWithFormat:@"%@",[selected_course valueForKey:@"lng"]] doubleValue];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude_val
                                                            longitude:longitude_val
                                                                 zoom:16];
    
    [self.mapView animateToCameraPosition:camera];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude_val, longitude_val);
    marker.title = selected_coursename;
    marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:0.41 green:0.07 blue:0.07 alpha:1.0]];
    marker.map = _mapView;

    NSString *image_url = [NSString stringWithFormat:@"%@",[selected_course valueForKey:@"course_image"]];
    if (image_url)
    {
        image_url = [image_url stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        image_url = [image_url stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        image_url = [image_url stringByReplacingOccurrencesOfString:@":" withString:@""];
        image_url = [NSString stringWithFormat:@"%@%@",IMAGE_URL,image_url];
        [_IMG_course_image sd_setImageWithURL:[NSURL URLWithString:image_url]
                       placeholderImage:[UIImage imageNamed:@"profile_pic.png"]];
//        _IMG_course_image.image = [UIImage imageNamed:@"GOlf-Icon"];
    }
    
    CGRect old_frame_lbl = _Lbl_course_name.frame;
    
    NSString *course_name = [selected_course valueForKey:@"name"];
    course_name = [course_name stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    course_name = [course_name stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    NSString *address = [NSString stringWithFormat:@"%@, %@",[selected_course valueForKey:@"city"],[selected_course valueForKey:@"state_or_province"]];
    address = [address stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    address = [address stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
    NSString *couse_type = [NSString stringWithFormat:@"%@",[[selected_course valueForKey:@"course_type"] uppercaseString]];
    NSString *one_char1 = @"0";
    NSString *one_char2 = @"8";
    
    
    NSString *empty_txt = @"sampleText";
    
    NSString *text = [NSString stringWithFormat:@"%@  %@%@%@\n%@\n%@",address,one_char1,couse_type,one_char2,empty_txt,course_name];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1.5];
   
    
    // If attributed text is supported (iOS6+)
    if ([_Lbl_course_name respondsToSelector:@selector(setAttributedText:)]) {
        // Define general attributes for the entire text
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: _Lbl_course_name.textColor,
                                  NSFontAttributeName: _Lbl_course_name.font,
                                  NSBaselineOffsetAttributeName : @3.0f
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:text
                                               attributes:attribs];
        
        NSRange cmp = [text rangeOfString:address];
        NSRange rnge_coursename = [text rangeOfString:couse_type];
        NSRange range_one_char1 = [text rangeOfString:one_char1];
        NSRange range_one_char2 = [text rangeOfString:one_char2];
        NSRange range_one_empty = [text rangeOfString:empty_txt];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            UIFont *small_text_font = [UIFont fontWithName:@"GothamBold" size:13.0];
//            paragraphStyle.lineHeightMultiple = 1.0f;
            
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-MediumItalic" size:15.0]}
                                    range:cmp];
            
            if ([couse_type isEqualToString:@"PRIVATE"])
            {
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:13.0],NSBackgroundColorAttributeName: [UIColor colorWithRed:0.00 green:0.00 blue:1.00 alpha:1.0],NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:rnge_coursename];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor colorWithRed:0.00 green:0.00 blue:1.00 alpha:1.0],NSForegroundColorAttributeName : [UIColor colorWithRed:0.00 green:0.00 blue:1.00 alpha:1.0],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:range_one_char1];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor colorWithRed:0.00 green:0.00 blue:1.00 alpha:1.0],NSForegroundColorAttributeName : [UIColor colorWithRed:0.00 green:0.00 blue:1.00 alpha:1.0],NSBaselineOffsetAttributeName : @3.0f} range:range_one_char2];
            }
            else if ([couse_type isEqualToString:@"PUBLIC"])
            {
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:13.0],NSBackgroundColorAttributeName: [UIColor colorWithRed:0.09 green:0.40 blue:0.14 alpha:1.0],NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:rnge_coursename];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor colorWithRed:0.09 green:0.40 blue:0.14 alpha:1.0],NSForegroundColorAttributeName : [UIColor colorWithRed:0.09 green:0.40 blue:0.14 alpha:1.0],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:range_one_char1];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor greenColor],NSForegroundColorAttributeName : [UIColor greenColor],NSBaselineOffsetAttributeName : @3.0f} range:range_one_char2];
            }
            else
            {
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:13.0],NSBackgroundColorAttributeName: [UIColor whiteColor],NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:rnge_coursename];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor whiteColor],NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:range_one_char1];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor whiteColor],NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @3.0f} range:range_one_char2];
            }
            
            [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor whiteColor],NSForegroundColorAttributeName : [UIColor whiteColor]} range:range_one_empty];
        }
        else
        {
            UIFont *small_text_font = [UIFont fontWithName:@"GothamBold" size:9.0];
//            paragraphStyle.lineHeightMultiple = 1.0f;
            
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-MediumItalic" size:12.0]}
                                    range:cmp];
            
            
            if ([couse_type isEqualToString:@"PRIVATE"])
            {
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor colorWithRed:0.00 green:0.00 blue:1.00 alpha:1.0],NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:rnge_coursename];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor colorWithRed:0.00 green:0.00 blue:1.00 alpha:1.0],NSForegroundColorAttributeName : [UIColor colorWithRed:0.00 green:0.00 blue:1.00 alpha:1.0],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:range_one_char1];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor colorWithRed:0.00 green:0.00 blue:1.00 alpha:1.0],NSForegroundColorAttributeName : [UIColor colorWithRed:0.00 green:0.00 blue:1.00 alpha:1.0],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:range_one_char2];
            }
            else if ([couse_type isEqualToString:@"PUBLIC"])
            {
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor colorWithRed:0.09 green:0.40 blue:0.14 alpha:1.0],NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:rnge_coursename];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor colorWithRed:0.09 green:0.40 blue:0.14 alpha:1.0],NSForegroundColorAttributeName : [UIColor colorWithRed:0.09 green:0.40 blue:0.14 alpha:1.0],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:range_one_char1];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor colorWithRed:0.09 green:0.40 blue:0.14 alpha:1.0],NSForegroundColorAttributeName : [UIColor colorWithRed:0.09 green:0.40 blue:0.14 alpha:1.0],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:range_one_char2];
            }
            else
            {
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor whiteColor],NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:rnge_coursename];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor whiteColor],NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:range_one_char1];
                [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor whiteColor],NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @3.0f,NSParagraphStyleAttributeName : paragraphStyle} range:range_one_char2];
            }
            
            [attributedText setAttributes:@{NSFontAttributeName:small_text_font,NSBackgroundColorAttributeName: [UIColor whiteColor],NSForegroundColorAttributeName : [UIColor whiteColor]} range:range_one_empty];
        }
        
        
        _Lbl_course_name.attributedText = attributedText;
    }
    else
    {
        _Lbl_course_name.text = text;
    }
    
    _IMG_course_image.layer.cornerRadius = _IMG_course_image.frame.size.width/2;
    
    _Lbl_course_name.numberOfLines = 0;
    [_Lbl_course_name sizeToFit];
    
    CGRect frame_setup = _VW_course.frame;
    frame_setup.size.width = _Scroll_contents.frame.size.width;
    
   
    
//    CGRect frame_subview = _Lbl_course_name.frame;
    if (_Lbl_course_name.frame.size.height > _IMG_course_image.frame.size.height) {
        old_frame_lbl.origin.y = (_IMG_course_image.frame.origin.y + _IMG_course_image.frame.size.height)/2;
        _Lbl_course_name.frame = old_frame_lbl;
        frame_setup.size.height = _Lbl_course_name.frame.origin.y + _Lbl_course_name.frame.size.height + 10 + _BTN_swipeUP_DN.frame.size.height/2;
    }
    else
    {
        old_frame_lbl.origin.y = (_IMG_course_image.frame.origin.y + _IMG_course_image.frame.size.height)/2;
        _Lbl_course_name.frame = old_frame_lbl;
        if (_Lbl_course_name.frame.origin.y + _Lbl_course_name.frame.size.height + 10 > _IMG_course_image.frame.origin.y + _IMG_course_image.frame.size.height + 10) {
            frame_setup.size.height = _Lbl_course_name.frame.origin.y + _Lbl_course_name.frame.size.height + 10 + _BTN_swipeUP_DN.frame.size.height/2;
        }
        else
        {
            frame_setup.size.height = _IMG_course_image.frame.origin.y + _IMG_course_image.frame.size.height + 10 + _BTN_swipeUP_DN.frame.size.height/2;
        }
    }
    
    _VW_course.frame = frame_setup;
    
    
    frame_setup = _BTN_swipeUP_DN.frame;
    frame_setup.origin.y = 0;
    frame_setup.origin.x = _Scroll_contents.frame.size.width/2 - _BTN_swipeUP_DN.frame.size.width/2;
    _BTN_swipeUP_DN.frame = frame_setup;
    
    frame_setup = _VW_course_Info.frame;
    frame_setup.origin.y = _VW_course.frame.origin.y + _VW_course.frame.size.height;
    frame_setup.size.width = _Scroll_contents.frame.size.width;
    _VW_course_Info.frame = frame_setup;
    
    NSString *STR_address = [NSString stringWithFormat:@"%@, %@, %@",[selected_course valueForKey:@"address"],[selected_course valueForKey:@"city"],[selected_course valueForKey:@"state_or_province"]];
    _Lbl_address.text = STR_address;
    
    NSString *STR_phone_number = [selected_course valueForKey:@"phone_number"];
    if (STR_phone_number != (id)[NSNull null]) {
        _Lbl_phone_num.text = STR_phone_number;
    }
    else
    {
        _Lbl_phone_num.text = @"Not Mentioned";
    }
    
    NSString *STR_website_url = [selected_course valueForKey:@"website_url"];
    if (STR_website_url != (id)[NSNull null]) {
        _Lbl_url.text = STR_website_url;
    }
    else
    {
        _Lbl_url.text = @"Not Mentioned";
    }
    
    NSString *STR_description = [selected_course valueForKey:@"description"];
    if (STR_description != (id)[NSNull null]) {
        _Lbl_course_Description.text = STR_description;
    }
    else
    {
        _Lbl_course_Description.text = @"Not Mentioned";
    }
    
    CGRect BTN_more_frame = _BTN_more.frame;
    BTN_more_frame.origin.y = _Lbl_course_Description.frame.origin.y + _Lbl_course_Description.frame.size.height;
    _BTN_more.frame = BTN_more_frame;
    
    CGRect VW_subcouseDesc_frame = _VW_subcouseDesc.frame;
    VW_subcouseDesc_frame.size.height = _BTN_more.frame.origin.y + _BTN_more.frame.size.height;
//    VW_subcouseDesc_frame.size.width = _Scroll_contents.frame.size.width;
    _VW_subcouseDesc.frame = VW_subcouseDesc_frame;

    frame_setup = _VW_couseDesc.frame;
    frame_setup.origin.y = _VW_course_Info.frame.origin.y + _VW_course_Info.frame.size.height;
    frame_setup.size.height = _VW_subcouseDesc.frame.size.height + 13;
    frame_setup.size.width = _Scroll_contents.frame.size.width;
    _VW_couseDesc.frame = frame_setup;
    
    CGRect frame_scroll = _Scroll_contents.frame;
    frame_scroll.origin.y = _VW_navBAR.frame.size.height + _mapView.frame.size.height - _VW_course.frame.size.height;
    frame_scroll.size.height = _VW_course.frame.size.height;
    frame_scroll.size.width = _Scroll_contents.frame.size.width;
    _Scroll_contents.frame = frame_scroll;
    
    [_Scroll_contents addSubview:_VW_course];
    [_Scroll_contents addSubview:_VW_course_Info];
    [_Scroll_contents addSubview:_VW_couseDesc];
    
    initial_frame = _Scroll_contents.frame;
    initial_ht = _mapView.frame.size.height;
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _Scroll_contents.contentSize = CGSizeMake(_Scroll_contents.frame.size.width, layout_height);
}

@end

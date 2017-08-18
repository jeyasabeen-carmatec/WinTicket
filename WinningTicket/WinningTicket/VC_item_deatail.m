//
//  VC_item_deatail.m
//  WinningTicket
//
//  Created by Test User on 06/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_item_deatail.h"
#import "similar_collectioncell.h"
#import "TAExampleDotView.h"
#import "TAPageControl.h"

#pragma mark - Image Cache
#import "SDWebImage/UIImageView+WebCache.h"

@interface VC_item_deatail () <UIScrollViewDelegate, TAPageControlDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView1;
@property (strong, nonatomic) IBOutletCollection(UIScrollView) NSArray *scrollViews;

@property (weak, nonatomic) IBOutlet TAPageControl *customStoryboardPageControl;

@property (strong, nonatomic) NSArray *imagesData;


@end

@implementation VC_item_deatail
{
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
    NSMutableDictionary *jsonReponse;
}

//@synthesize scrollView,pageControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self add_overlay];
    VW_overlay.hidden = NO;
    [activityIndicatorView startAnimating];
    [self performSelector:@selector(GETAuction_Item_details) withObject:activityIndicatorView afterDelay:0.01];
    
}

-(void) add_overlay
{
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, _VW_contents.frame.size.height);
    for (UIScrollView *scrollView in self.scrollViews) {
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame) * self.imagesData.count, CGRectGetHeight(scrollView.frame));
    }

}
#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
    if (scrollView == self.scrollView1) {
        self.customStoryboardPageControl.currentPage = pageIndex;
        _lbl_count.text = [NSString stringWithFormat:@"%lu of %lu",(long)self.customStoryboardPageControl.currentPage + 1,(unsigned long)_imagesData.count];

    }
    NSLog(@"scrollview frame:%@",NSStringFromCGRect(_scrollView1.frame));
}

#pragma mark - Utils
- (void)setupScrollViewImages
{
    for (UIScrollView *scrollView in self.scrollViews) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self.imagesData enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(scrollView.frame) * idx, 0, CGRectGetWidth(scrollView.frame)+80, CGRectGetHeight(scrollView.frame))];
//                imageView.contentMode = UIViewContentModeScaleAspectFill;
//                imageView.image = [UIImage imageNamed:imageName];
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]
                                          placeholderImage:[UIImage imageNamed:@"Logo_WT.png"]];
                [scrollView addSubview:imageView];
            }];
           
                }
                else
                {
                    [self.imagesData enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(scrollView.frame) * idx, 0, CGRectGetWidth(scrollView.frame)+30, CGRectGetHeight(scrollView.frame))];
//                        imageView.contentMode = UIViewContentModeScaleAspectFill;
//                        imageView.image = [UIImage imageNamed:imageName];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]
                                     placeholderImage:[UIImage imageNamed:@"Logo_WT.png"]];
                        [scrollView addSubview:imageView];
                    }];
                }
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

//- (void)scrollViewDidScroll:(UIScrollView *)sender {
//    if (!pageControlBeingUsed) {
//        // Switch the indicator when more than 50% of the previous/next page is visible
//        CGFloat pageWidth = self.scrollView.frame.size.width;
//        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//        self.pageControl.currentPage = page;
//        
//        _lbl_count.text = [NSString stringWithFormat:@"%lu of %lu",(long)self.pageControl.currentPage + 1,(unsigned long)self.pageControl.numberOfPages];
//        
////        [self changePage];
//        
////        CGRect frame;
////        frame.origin.x = self.scrollView.frame.size.width * page;
////        frame.origin.y = 0;
////        frame.size = self.scrollView.frame.size;
////        [self.scrollView scrollRectToVisible:frame animated:YES];
//        
//    }
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    pageControlBeingUsed = NO;
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    pageControlBeingUsed = NO;
//}
//
#pragma mark - UIView Customisation
-(void) setup_VIEW
{
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
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    self.navigationItem.title = @"Live Auction";
    
    //    UIBarButtonItem *anotherButton1 = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
    //                                                                     target:self action:@selector(more_ACTION)];
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, anotherButton ] animated:NO];
    //    [self.navigationItem setRightBarButtonItems:@[anotherButton1, negativeSpacer]animated:NO];
    
    
    
        [self setup_Values];
}
//- (void)viewDidUnload {
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//    self.scrollView = nil;
//    self.pageControl = nil;
//}

-(void) setup_Values
{
    
    _lbl_count.layer.cornerRadius = 5.0f;
    _lbl_count.layer.masksToBounds = YES;
    
    
    
    // TAPageControl from storyboard
    

    _lbl_count.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
//    NSArray *images = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"IMG_0002.PNG"],[UIImage imageNamed:@"IMG_0003.PNG"],[UIImage imageNamed:@"IMG_0004.PNG" ],[UIImage imageNamed:@"IMG_0009.PNG"],[UIImage imageNamed:@"IMG_0010.PNG"],[UIImage imageNamed:@"IMG_0011.PNG" ],[UIImage imageNamed:@"IMG_0002.PNG"], nil];
    
//    self.scrollView.contentSize = CGSizeMake(_scroll_contents.frame.size.width * images.count, self.scrollView.frame.size.height);
//    
//    
//    
//    for (int i = 0; i < images.count; i++) {
//        CGRect frame;
//        frame.origin.x = _scroll_contents.frame.size.width * i;
//        frame.origin.y = 0;
//        frame.size.width = _scroll_contents.frame.size.width;
//        frame.size.height = scrollView.frame.size.height;
//        UIImageView* imgView = [[UIImageView alloc] init];
//        imgView.image = [images objectAtIndex:i];
//        imgView.frame = frame;
//        [scrollView addSubview:imgView];
//    }
//    
//    self.pageControl.currentPage = 0;
//    self.pageControl.numberOfPages = images.count;
//    
//    
    
    NSDictionary *auction_item = [jsonReponse valueForKey:@"auction_item"];
    
    NSString *STR_event_name = [auction_item valueForKey:@"name"];//@"Jordan Spieth Autographed Golf Ball with Certificate of Authenticity";
    NSString *STR_price = [NSString stringWithFormat:@"%.2f",[[auction_item valueForKey:@"starting_bid"] floatValue]];//@"US $59.99";
//    NSString *STR_bid = @"Starting bid";
//    NSString *STR_sporater = @"|";
//    NSString *STR_time = @"10h 39m remaining";
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@",STR_event_name,STR_price];//,STR_bid,STR_sporater,STR_time];\n%@ %@ %@
    
    if ([self.lbl_itemNAME respondsToSelector:@selector(setAttributedText:)]) {
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.lbl_itemNAME.textColor,
                                  NSFontAttributeName: self.lbl_itemNAME.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:text
                                               attributes:attribs];
        NSRange cmp = [text rangeOfString:STR_price];
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:21.0]}
                                    range:cmp];
        }
        else
        {
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0]}
                                    range:cmp];
        }
        self.lbl_itemNAME.attributedText = attributedText;
    }
    else
    {
        self.lbl_itemNAME.text = text;
    }
    
    self.lbl_itemNAME.numberOfLines = 0;
    [self.lbl_itemNAME sizeToFit];
    NSLog(@"Label  frame:%@",NSStringFromCGRect(_lbl_itemNAME.frame));
    
    
    NSLog(@"The origin y = %f height = %f",self.scrollView1.frame.origin.y,self.scrollView1.frame.size.height);
    
    CGRect new_frame;
    new_frame=self.lbl_itemNAME.frame;
    new_frame.origin.y = self.scrollView1.frame.origin.y + self.scrollView1.frame.size.height + 10 + self.navigationController.navigationBar.frame.size.height + 15;
    _lbl_itemNAME.frame=new_frame;
    
//    new_frame = self.customStoryboardPageControl.frame;
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//         new_frame.origin.y = _lbl_itemNAME.frame.origin.y - self.customStoryboardPageControl.frame.size.height-260;
//    }
//    else
//    {
//        new_frame.origin.y = _lbl_itemNAME.frame.origin.y - self.customStoryboardPageControl.frame.size.height;
//    }
//    
//    self.customStoryboardPageControl.frame = new_frame;
//
    
    new_frame = _lbl_CountDown.frame;
    new_frame.origin.y = _lbl_itemNAME.frame.origin.y + _lbl_itemNAME.frame.size.height;
    _lbl_CountDown.frame = new_frame;
    
    new_frame = _BTN_place_BID.frame;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        new_frame.origin.y = _lbl_CountDown.frame.origin.y + _lbl_CountDown.frame.size.height + 15;
    }
    else
    {
        new_frame.origin.y = _lbl_CountDown.frame.origin.y + _lbl_CountDown.frame.size.height + 5;
    }
    _BTN_place_BID.frame = new_frame;
    
    new_frame = _BTN_watech.frame;
    new_frame.origin.y = _BTN_place_BID.frame.origin.y + _BTN_place_BID.frame.size.height + 12;
    _BTN_watech.frame = new_frame;
    _BTN_watech.layer.borderWidth = 2.0f;
    _BTN_watech.layer.borderColor = [UIColor blackColor].CGColor;
    [_BTN_watech addTarget:self action:@selector(showActionSHEET) forControlEvents:UIControlEventTouchUpInside];
    
    new_frame = _VW_line1.frame;
    new_frame.origin.y = _BTN_watech.frame.origin.y + _BTN_watech.frame.size.height + 10;
    _VW_line1.frame = new_frame;
    
    NSString *STR_titl_iten_des = @"Item Description";
    NSString *STR_descrip_detail = [auction_item valueForKey:@"description"];//@"Golf ball signed by Masters and U.S. Open champion, Jordan Spieth. This ball comes with a certificate of authenticity from Global Authentics.";
    
//    golfTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(count_downTimer) userInfo:nil repeats: YES];
    
    [[NSUserDefaults standardUserDefaults] setValue:[auction_item valueForKey:@"event_end_date"] forKey:@"bid_date"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    golfTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector: @selector(count_downTimer) userInfo: nil repeats: YES];

    
    
    NSString *text2 = [NSString stringWithFormat:@"%@\n%@",STR_titl_iten_des,STR_descrip_detail];
    
    if ([self.lbl_item_descrip respondsToSelector:@selector(setAttributedText:)]) {
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.lbl_item_descrip.textColor,
                                  NSFontAttributeName: self.lbl_item_descrip.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:text2
                                               attributes:attribs];
        NSRange cmp = [text2 rangeOfString:STR_titl_iten_des];
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:21.0]}
                                    range:cmp];
        }
        else
        {
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0]}
                                    range:cmp];
        }
        self.lbl_item_descrip.attributedText = attributedText;
    }
    else
    {
        self.lbl_item_descrip.text = text;
    }
    
    new_frame = _lbl_item_descrip.frame;
    new_frame.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
    _lbl_item_descrip.frame = new_frame;
    
    self.lbl_item_descrip.numberOfLines = 0;
    [self.lbl_item_descrip sizeToFit];
    
    new_frame = _VW_line2.frame;
    new_frame.origin.y = _lbl_item_descrip.frame.origin.y + _lbl_item_descrip.frame.size.height + 10;
    _VW_line2.frame = new_frame;
    
    _lbl_title_silar_item.text = @"Similar Items";
    new_frame = _lbl_title_silar_item.frame;
    new_frame.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
    _lbl_title_silar_item.frame = new_frame;
    
    new_frame = _collection_similar_item.frame;
    new_frame.origin.y = _lbl_title_silar_item.frame.origin.y + _lbl_title_silar_item.frame.size.height + 10;
    _collection_similar_item.frame = new_frame;
    
    CGRect frame_content;
    frame_content = _VW_contents.frame;
    frame_content.size.width = _scroll_contents.frame.size.width;
    
    frame_content.size.height = _collection_similar_item.frame.origin.y + _collection_similar_item.frame.size.height + 20;
    
    _VW_contents.frame = frame_content;
    
    [_scroll_contents addSubview:_VW_contents];
    
//    self.imagesData = @[@"image1.jpg", @"image2.jpg", @"image3.jpg", @"image4.jpg", @"image5.jpg", @"image6.jpg"];
    NSArray *auction_images = [auction_item valueForKey:@"auction_item_images"];
    NSMutableArray *temp_arr = [[NSMutableArray alloc]init];
    NSString *STR_image_url;
    
    for (int i = 0; i < [auction_images count]; i++) {
        NSDictionary *temp_dictin = [auction_images objectAtIndex:i];
        NSString *STR_img = [temp_dictin valueForKey:@"image_url"];
        STR_image_url = [NSString stringWithFormat:@"%@%@",IMAGE_URL,STR_img];
        [temp_arr addObject:STR_image_url];
    }
    
    self.imagesData = [temp_arr copy];
    [self setupScrollViewImages];
    _lbl_count.text = [NSString stringWithFormat:@"%lu of %lu",(unsigned long)_imagesData.count,(unsigned long)_imagesData.count];
    
    for (UIScrollView *scrollView in self.scrollViews) {
        scrollView.delegate = self;
    }
    
    self.customStoryboardPageControl.numberOfPages = self.imagesData.count;
    [self viewDidLayoutSubviews];
}


//- (IBAction)changePage{
//    // update the scroll view to the appropriate page
//    CGRect frame;
//    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
//    frame.origin.y = 0;
//    frame.size = self.scrollView.frame.size;
//    [self.scrollView scrollRectToVisible:frame animated:YES];
//    pageControlBeingUsed = YES;
//    
//    _lbl_count.text = [NSString stringWithFormat:@"%lu of %lu",(long)self.pageControl.currentPage + 1,(unsigned long)self.pageControl.numberOfPages];
//}
#pragma mark - Back Action
-(void) backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void) more_ACTION
{
    NSLog(@"More actions tapped");
}


#pragma mark - CollectionView Deligate
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cellForItemAtIndexPath %ld", (long)indexPath.row); // returns as expected
    static NSString *identifier = @"cellIdentifier";
    
    similar_collectioncell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
/*
    
    //    cell.contentView.backgroundColor = [UIColor colorWithRed:0.953 green:0.976 blue:0.98 alpha:1];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell.cnt_VW.bounds];
    cell.cnt_VW.backgroundColor = [UIColor colorWithRed:0.953 green:0.976 blue:0.98 alpha:1];
    cell.cnt_VW.layer.masksToBounds = NO;
    cell.cnt_VW.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.cnt_VW.layer.shadowOffset = CGSizeMake(0.5f, 0.0f);
    cell.cnt_VW.layer.shadowOpacity = 0.5f;
    //    cell.cnt_VW.layer.cornerRadius = 7.0f;
    cell.cnt_VW.layer.shadowPath = shadowPath.CGPath;
    
    NSLog(@"Contents in cell %@",[L_category objectAtIndex:indexPath.row]);
    
    cell.lbl_CAT_name.text = [NSString stringWithFormat:@"%@",[[L_category objectAtIndex:indexPath.row] valueForKey:@"NAME"]];
    
    CGRect frame = cell.lbl_CAT_name.frame;
    frame.size.width = self.navigationController.navigationBar.frame.size.width/2 - 30;
    frame.size.height = cell.contentView.frame.size.height - 8;
    
    frame.origin.x = 8;
    frame.origin.y = 8;
    
    [cell.lbl_CAT_name setFrame:frame];
    
    cell.lbl_CAT_name.numberOfLines = 0;
    cell.lbl_CAT_name.textAlignment = NSTextAlignmentCenter; */
    //    cell.lbl_CAT_name.adjustsFontSizeToFitWidth = YES;
    //    [cell.lbl_CAT_name sizeToFit];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -
#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UIDeviceOrientation devOrientation = [UIDevice currentDevice].orientation;
    //    if (UIDeviceOrientationIsLandscape(devOrientation))
    //    {
    //        return CGSizeMake(130, 90);
    //    }
    //    else if (UIDeviceOrientationIsPortrait(devOrientation))
    //    {
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return CGSizeMake(self.view.frame.size.width/2.2f, 491);
    }
    else
    {
        return CGSizeMake(self.view.frame.size.width/2.2f, 258);
    }
    
    //    }
    //    return CGSizeMake(self.view.frame.size.width/2, 95);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 9);
}

#pragma mark - Show action sheet
-(void) showActionSHEET
{
    NSLog(@"Show action sheet tapped");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Watch",@"View Bidding History", @"Share This Item", nil];
    
//    [actionSheet showInView:self.view];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // In this case the device is an iPad.
        [actionSheet showFromRect:[(UIButton *)_BTN_watech frame] inView:self.view animated:YES];
    }
    else{
        // In this case the device is an iPhone/iPod Touch.
        [actionSheet showInView:self.view];
    }
}

#pragma mark - Actionsheet deligate
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Index = %ld - Title = %@", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    
    switch (buttonIndex) {
        case 1:
        {
            [self performSegueWithIdentifier:@"itmdtailtobidhstryidentifier" sender:self];
        }
            break;
            
        case 2:
        {
            UIImage *image=[UIImage imageNamed:@"IMG_0011.PNG"];
            NSArray *postItems=@[image];
            
            UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
            
            //if iPhone
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                [self presentViewController:controller animated:YES completion:nil];
            }
            //if iPad
            else {
                // Change Rect to position Popover
                //            UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
                //            [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                
                controller.popoverPresentationController.sourceView = self.BTN_watech;
                controller.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
                //        activityViewController.popoverPresentationController.sourceRect = self.frame;
                [self presentViewController:controller
                                   animated:YES
                                 completion:nil];
            }
        }
            
        default:
            break;
    }
    
//    if (buttonIndex == 1)
//    {
//        
//    }
}


#pragma mark - Date Detail
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
-(NSDate *)getLocalDateFromUTC:(NSString *)strDate
{
    strDate = @"2017-09-02T10:32:00.000-04:00";
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    NSDate *currentDate = [dateFormatter dateFromString:strDate];
    NSLog(@"CurrentDate:%@", currentDate);
//    NSDateFormatter *newFormat = [[NSDateFormatter alloc] init];
//    [newFormat setDateFormat:@"EEEE, MMMM dd, yyyy"];
    return currentDate;
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

/*#pragma mark - Timer methods
-(void) updateCountdown
{
    int hours, minutes, seconds;
    
    secondsLeft--;
    hours = secondsLeft / 3600;
    minutes = (secondsLeft % 3600) / 60;
    seconds = (secondsLeft %3600) % 60;
    NSString *STR_temp = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    NSLog(@"time updated %@",STR_temp);
}*/

/*
 
 - (void)startTimer {
 ...
 // Set the date you want to count from
 self.countdownDate = [NSDate date...]; ///< Get this however you need
 
 // Create a timer that fires every second repeatedly and save it in an ivar
 self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
 ...
 }
 
 - (void)updateLabel {
 NSTimeInterval timeInterval = [self.countdownDate timeIntervalSinceNow]; ///< Assuming this is in the future for now.
 
 
 // Work out the number of days, months, years, hours, minutes, seconds from timeInterval.


self.countdownLabel.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@:%@", days, months, years, hours, minutes, seconds];
}

 */

#pragma mark - Countdown timer

-(void)count_downTimer
{
    /*int hours, minutes, seconds;
    
    secondsLeft--;
    hours = secondsLeft / 3600;
    minutes = (secondsLeft % 3600) / 60;
    seconds = (secondsLeft %3600) % 60;
    NSString *STR_time = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    _lbl_CountDown.text = [NSString stringWithFormat:@"Starting bid | %@",STR_time];*/
    
    NSDateFormatter *dateStringParser = [[NSDateFormatter alloc] init];
    [dateStringParser setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateStringParser setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    
    NSString *STR_bidDate = [[NSUserDefaults standardUserDefaults] valueForKey:@"bid_date"];
    NSDate *date = [dateStringParser dateFromString:STR_bidDate];//@"2017-09-02T10:32:00.000-04:00"
    
    NSDateFormatter *labelFormatter = [[NSDateFormatter alloc] init];
    [labelFormatter setDateFormat:@"HH-dd-MM"];
    
    
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:timeInterval sinceDate:date];
    NSCalendarUnit unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitSecond;
    
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:date  toDate:date2  options:0];
    NSString *STR_time = [NSString stringWithFormat:@"Starting bid | %li D : %li H : %li M : %li S", (long)[breakdownInfo day], (long)[breakdownInfo hour], (long)[breakdownInfo minute], (long)[breakdownInfo second]];
    
    _lbl_CountDown.text = [NSString stringWithFormat:@"%@", STR_time];
}

- (void) countdown: (NSTimer*) timer
{
    if( [[self getLocalDateFromUTC:@""] timeIntervalSinceNow] <= 0)
    {
        [timer invalidate];
        return;
    }
//    NSDateComponents* comp= [[NSCalendar currentCalendar] components: NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond startingDate: [NSDate date] toDate: [self getLocalDateFromUTC:@""] options: 0];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[self getLocalDateFromUTC:@""]];
//    NSLog(@"%lu:%lu:%lu", comp.hour,comp.minute.comp.second);
    NSString *STR_time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)comp.hour, (long)comp.minute, (long)comp.second];
    _lbl_CountDown.text = [NSString stringWithFormat:@"Starting bid | %@",STR_time];
}

#pragma mark - API Calling
-(void) GETAuction_Item_details
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    //    NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"upcoming_events"] options:NSASCIIStringEncoding error:&error];
    //    NSDictionary *Dictin_event = [dict valueForKey:@"event"];
    
    NSString *prev_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"prev_ID"];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSString *urlGetuser =[NSString stringWithFormat:@"%@auction/item_detail/%@",SERVER_URL,prev_id];//[Dictin_event valueForKey:@"id"]
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData) {
        jsonReponse = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response VC auction detail page %@",jsonReponse);
    }
    
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
    
    [self setup_VIEW];
}

@end

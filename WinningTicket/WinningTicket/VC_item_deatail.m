//
//  VC_item_deatail.m
//  WinningTicket
//
//  Created by Test User on 06/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_item_deatail.h"
#import "similar_collectioncell.h"


@interface VC_item_deatail ()

@end

@implementation VC_item_deatail

@synthesize scrollView,pageControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup_VIEW];
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
        
        _lbl_count.text = [NSString stringWithFormat:@"%lu of %lu",(long)self.pageControl.currentPage + 1,(unsigned long)self.pageControl.numberOfPages];
        
//        [self changePage];
        
//        CGRect frame;
//        frame.origin.x = self.scrollView.frame.size.width * page;
//        frame.origin.y = 0;
//        frame.size = self.scrollView.frame.size;
//        [self.scrollView scrollRectToVisible:frame animated:YES];
        
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

#pragma mark - UIView Customisation
-(void) setup_VIEW
{
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
- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.pageControl = nil;
}

-(void) setup_Values
{
    
    _lbl_count.layer.cornerRadius = 5.0f;
    _lbl_count.layer.masksToBounds = YES;
//    _lbl_count.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    NSArray *images = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"IMG_0002.PNG"],[UIImage imageNamed:@"IMG_0003.PNG"],[UIImage imageNamed:@"IMG_0004.PNG" ],[UIImage imageNamed:@"IMG_0009.PNG"],[UIImage imageNamed:@"IMG_0010.PNG"],[UIImage imageNamed:@"IMG_0011.PNG" ],[UIImage imageNamed:@"IMG_0002.PNG"], nil];
    
    self.scrollView.contentSize = CGSizeMake(_scroll_contents.frame.size.width * images.count, self.scrollView.frame.size.height);
    
    
    
    for (int i = 0; i < images.count; i++) {
        CGRect frame;
        frame.origin.x = _scroll_contents.frame.size.width * i;
        frame.origin.y = 0;
        frame.size.width = _scroll_contents.frame.size.width;
        frame.size.height = scrollView.frame.size.height;
        UIImageView* imgView = [[UIImageView alloc] init];
        imgView.image = [images objectAtIndex:i];
        imgView.frame = frame;
        [scrollView addSubview:imgView];
    }
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = images.count;
    
    
    _lbl_count.text = [NSString stringWithFormat:@"%lu of %lu",(long)self.pageControl.currentPage + 1,(unsigned long)images.count];
    
    CGRect new_frame;
    
    NSString *STR_event_name = @"Jordan Spieth Autographed Golf Ball with Certificate of Authenticity";
    NSString *STR_price = @"US $59.99";
    NSString *STR_bid = @"Starting bid";
    NSString *STR_sporater = @"|";
    NSString *STR_time = @"10h 39m remaining";
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@\n%@ %@ %@",STR_event_name,STR_price,STR_bid,STR_sporater,STR_time];
    
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
    
    new_frame = self.pageControl.frame;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        new_frame.origin.y = _lbl_itemNAME.frame.origin.y - self.pageControl.frame.size.height - 160;;
    }
    else
    {
        new_frame.origin.y = _lbl_itemNAME.frame.origin.y - self.pageControl.frame.size.height - 20;
    }
    
    
    self.pageControl.frame = new_frame;
    
    new_frame = _BTN_place_BID.frame;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        new_frame.origin.y = _lbl_itemNAME.frame.origin.y + _lbl_itemNAME.frame.size.height + 10;
    }
    else
    {
        new_frame.origin.y = _lbl_itemNAME.frame.origin.y + _lbl_itemNAME.frame.size.height;
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
    NSString *STR_descrip_detail = @"Golf ball signed by Masters and U.S. Open champion, Jordan Spieth. This ball comes with a certificate of authenticity from Global Authentics.";
    
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
}


- (IBAction)changePage{
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    pageControlBeingUsed = YES;
    
    _lbl_count.text = [NSString stringWithFormat:@"%lu of %lu",(long)self.pageControl.currentPage + 1,(unsigned long)self.pageControl.numberOfPages];
}
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
            NSString *str=@"Image form My app";
            NSArray *postItems=@[str,image];
            
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
@end

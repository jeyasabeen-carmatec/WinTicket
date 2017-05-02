//
//  VC_item_deatail.h
//  WinningTicket
//
//  Created by Test User on 06/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_item_deatail : UIViewController <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIActionSheetDelegate>
{
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    
    BOOL pageControlBeingUsed;
}

@property (weak, nonatomic) IBOutlet UIView *VW_contents;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_contents;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage;

@property (weak, nonatomic) IBOutlet UILabel *lbl_itemNAME;

@property (weak, nonatomic) IBOutlet UIButton *BTN_place_BID;
@property (weak, nonatomic) IBOutlet UIButton *BTN_watech;

@property (weak, nonatomic) IBOutlet UIView *VW_line1;

@property (weak, nonatomic) IBOutlet UILabel *lbl_item_descrip;

@property (weak, nonatomic) IBOutlet UIView *VW_line2;

@property (weak, nonatomic) IBOutlet UILabel *lbl_title_silar_item;

@property (weak, nonatomic) IBOutlet UICollectionView *collection_similar_item;

@property (weak, nonatomic) IBOutlet UILabel *lbl_count;

@end

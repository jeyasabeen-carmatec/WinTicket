//
//  InfoWindow.h
//  UnoHire
//
//  Created by carmatec on 26/04/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoWindow : UIView

//@property (nonatomic, retain) IBOutlet UILabel *job_ID;
@property (nonatomic, retain) IBOutlet UILabel *job_disc;
@property (nonatomic, retain) IBOutlet UILabel *company_nme;
@property (nonatomic, retain) IBOutlet UILabel *salary;
@property (nonatomic, retain) IBOutlet UILabel *jb_Type;
@property (nonatomic, retain) IBOutlet UILabel *loc;
@property (nonatomic, retain) IBOutlet UILabel *posted_DT;

@property (nonatomic, weak) IBOutlet UIView *bg_View;
@property (nonatomic, weak) IBOutlet UIImageView *img_VW;

@property (nonatomic, weak) IBOutlet UILabel *icon_curency_TYP;
@property (nonatomic, weak) IBOutlet UILabel *icon_jb_typ;


@end

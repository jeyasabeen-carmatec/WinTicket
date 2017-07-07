//
//  VC_courses.h
//  WinningTicket
//
//  Created by Test User on 02/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface VC_courses : UIViewController <UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UITabBar *tab_HOME;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment_bottom;

#pragma mark - Google MAP
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@end

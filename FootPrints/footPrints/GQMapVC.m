//
//  GQMapVC.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/16.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQMapVC.h"
#import "MAMapKit/MAMapkit.h"
#import "GQShareDetailVC.h"

@interface GQMapVC ()<MAMapViewDelegate>
{

    MAMapView *_mapView;
    UIImage *_screenShotImage;
}

@end

@implementation GQMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"👣";
    // Do any additional setup after loading the view.
    
    [self loadGQMapVCData];
    [self loadGQMapVCUI];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Operations

- (void) loadGQMapVCData{

    [MAMapServices sharedServices].apiKey = @"2d2710efe4a8593c95b26987963d3b99";
    
}

- (void) loadGQMapVCUI{

    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow];
    [_mapView setZoomLevel:16.1 animated:YES];
    
    [self.view addSubview:_mapView];
    [self.view bringSubviewToFront:self._saveBtn];
//    [self.view bringSubviewToFront:self._greenPinLocation];
}

#pragma mark - Map Events

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
    }
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
        
        pre.showsAccuracyRing = NO;
        
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    } 
}

#pragma mark - Button Events

- (IBAction)saveBtn_Pressed:(id)sender {
    
    CGRect inRect = CGRectMake(0,0,320,504);
    _screenShotImage = [_mapView takeSnapshotInRect:inRect];
    
    [self performSegueWithIdentifier:@"SegueToShareDetailVC" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"SegueToShareDetailVC"]) {
     
        GQShareDetailVC *vc = segue.destinationViewController;
        vc.image = _screenShotImage;
    }
}


@end

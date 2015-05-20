//
//  GQMainVC.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/10.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQMainVC.h"
#import "MAMapKit/MAMapkit.h"
#import "GQUtils.h"
#import "CoreData+MagicalRecord.h"
#import "Infomation.h"

@interface GQMainVC ()<MAMapViewDelegate>
{
    
    NSMutableArray *_headerImageArray;
    NSTimer *_timer;
    NSTimer *_delayTimer;
    UIImage *_fastImage;
    MAMapView *_mapView;
}

@end

@implementation GQMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fastImage = [[UIImage alloc]init];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBarHidden = NO;
//    self.navigationItem.title = @"👣";
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadGQMainVCData];
    [self loadGQMainVCUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadGQMainVCData{
    
    [MAMapServices sharedServices].apiKey = @"2d2710efe4a8593c95b26987963d3b99";
    
    _headerImageArray = [[NSMutableArray alloc] init];
    
    [self loadRandomInfomation];
}

- (void) loadGQMainVCUI{
    
    _fastShareImage.hidden = YES;
    
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(320 * _headerImageArray.count,0);
    
    //分页视图
    
    _pageController.numberOfPages = _headerImageArray.count;
    if (_headerImageArray.count == 0) {
        _pageController.numberOfPages = 2;
    }
    _pageController.currentPage = 0;
    
    //显示滚动视图
    [self showImageInscrollerView];
    //加定时器
    if(_timer)
    {
        [_timer invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changePage:) userInfo:nil repeats:YES];
    
    //  load map Image
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_fastShareView.bounds), CGRectGetHeight(_fastShareView.bounds))];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow];
    [_mapView setZoomLevel:16.1 animated:YES];
    
    [_fastShareView addSubview:_mapView];
    _delayTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(replaceMapWithImage) userInfo:nil repeats:NO];
}
- (void)changePage:sender
{
    //取到下一次的序号
    NSInteger nextIndex = _pageController.currentPage+1;
    
    //最后一个的next是第一张图片
    if (nextIndex == _headerImageArray.count) {
        nextIndex = 0;
    }
    _scrollView.contentOffset = CGPointMake(320 * nextIndex, 0);
    _pageController.currentPage = nextIndex;
}

- (void)showImageInscrollerView
{
    for(int i = 0;i<_headerImageArray.count;i++)
    {
        UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 * i, 0, 320, 120)];
        Infomation *info = (Infomation *)_headerImageArray[i];
        int imageCount = [info.photoArray count];
        int randomIndexImage = arc4random() % imageCount;
        topImageView.image = [info.photoArray objectAtIndex:randomIndexImage];
        topImageView.userInteractionEnabled = YES;
        //[topImageView sd_setImageWithURL:[NSURL URLWithString:self.picArray[i]]];
        UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [topImageView addGestureRecognizer:g];
        [_scrollView addSubview:topImageView];
    }
    
    if (_headerImageArray.count == 0) {
        [_headerImageArray addObject:@"头条"];
        [_headerImageArray addObject:@"壁纸"];
        
        for(int i = 0;i<_headerImageArray.count;i++)
        {
            UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 * i, 0, 320, 120)];
          
            topImageView.image = [UIImage imageNamed:_headerImageArray[i]];
            topImageView.userInteractionEnabled = YES;
            //[topImageView sd_setImageWithURL:[NSURL URLWithString:self.picArray[i]]];
            UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
            [topImageView addGestureRecognizer:g];
            [_scrollView addSubview:topImageView];
        }
    }
    
}

- (void)tapImageView:(UITapGestureRecognizer *)g
{
    NSLog(@"222");
    //点击照片的事件
}

#pragma mark - Map Operation

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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}

#pragma mark - Private Methods

- (void) replaceMapWithImage{

    // replace mapView with ImageView
    CGRect inRect = CGRectMake(0,0,320,119);
    _fastImage = [_mapView takeSnapshotInRect:inRect];
    [_mapView removeFromSuperview];
    _mapView = nil;
    _fastShareImage.image = _fastImage;
    _fastShareImage.hidden = NO;
    [_contentView bringSubviewToFront:_fastShareImage];
}

- (void) loadRandomInfomation{
    
    NSArray *infoArray = [[NSArray alloc]init];
    infoArray = [Infomation MR_findAll];
    
    [_headerImageArray removeAllObjects];
    
    int photoPage = 0;
    if (infoArray.count > 5) {
    
        photoPage = 5;
    }else{
    
        photoPage = infoArray.count;
    }
    
    BOOL isRepeat = NO;
    for (int i=0; i<photoPage; i++) {
        int randomInfoIndex = arc4random() % infoArray.count;
        
        for (Infomation* info in _headerImageArray) {
            if ([info isEqual:infoArray[randomInfoIndex]]) {
                isRepeat = YES;
                break;
            }
        }
        
        if (isRepeat == YES) {
            isRepeat = NO;
            i--;
            continue;
        }else{
        
            [_headerImageArray addObject:infoArray[randomInfoIndex]];
        }
    }
}

#pragma mark - Button Events

- (IBAction)fastShareBtn_Pressed:(id)sender {
    
    Infomation *info = [Infomation MR_createEntity];
    
    info.remark = DEFAULT_MESSAGE;
    info.date   = [GQUtils getCurrentTime];
    info.photoArray = [[NSArray arrayWithObject:_fastShareImage.image] mutableCopy];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [GQUtils shareToSinaWithMessage:DEFAULT_MESSAGE Image:_fastShareImage.image];
}


- (IBAction)rightFootBtn_Pressed:(id)sender {
    
    [self performSegueWithIdentifier:@"SegueToInfoListVC" sender:self];
}

- (IBAction)logoutBtn_Pressed:(id)sender {
    
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //    GQMapVC *vc = segue.destinationViewController;
    //    vc.isFastMood = _isFastMood;
}


@end

//
//  GQMainVC.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/10.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQMainVC.h"

@interface GQMainVC ()
{

    NSMutableArray *_headerImageArray;
    NSTimer *_timer;
}

@end

@implementation GQMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadGQMainVCData];
    [self loadGQMainVCUI];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadGQMainVCData{

    _headerImageArray = [[NSMutableArray alloc] initWithObjects:@"头条",@"壁纸", nil];
}

- (void) loadGQMainVCUI{

    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(320 * _headerImageArray.count,0);

    //分页视图

    _pageController.numberOfPages = _headerImageArray.count;
    _pageController.currentPage = 0;

    //显示滚动视图
    [self showImageInscrollerView];
    //加定时器
    if(_timer)
    {
        [_timer invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changePage:) userInfo:nil repeats:YES];
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
#warning 有图片接口时从网络获取图片，先用假数据
        UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
        topImageView.image = _headerImageArray[i];
        topImageView.userInteractionEnabled = YES;
        //[topImageView sd_setImageWithURL:[NSURL URLWithString:self.picArray[i]]];
        UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [topImageView addGestureRecognizer:g];
        [_scrollView addSubview:topImageView];
    }
    
    
}

- (void)tapImageView:(UITapGestureRecognizer *)g
{
#warning 继续  //点击照片的事件
    NSLog(@"222");
    //点击照片的事件
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

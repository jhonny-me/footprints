//
//  GQInfoListVC.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/20.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQInfoListVC.h"
#import "GQInfoListCell.h"
#import "Infomation.h"
#import "MagicalRecord.h"
#import "GQUtils.h"
#import "GQDetailsVC.h"

@interface GQInfoListVC ()<UITableViewDelegate>
{

    NSMutableArray *_infoArray;
    GQDetailsVC *_detailsVC;
}

@end

@implementation GQInfoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _infoArray = [[NSMutableArray alloc]init];
    self.navigationItem.title = @"我的👣";
    
    self.tableView.delegate = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadGQInfoListVCData];
    [self loadGQInfoListVCUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Operation

- (void) loadGQInfoListVCData{

    [self loadDataBase];
    [self.tableView reloadData];
}

- (void) loadGQInfoListVCUI{}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _infoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GQInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GQInfoListCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GQInfoListCell" owner:nil options:nil] lastObject];
    }
    [cell setContentWithInfomation:_infoArray[indexPath.row]];
    // Configure the cell...
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    Infomation *info = _infoArray[indexPath.row];
    if ([info.photoArray count] > 2) {
        return 280;
    }
    return 175;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self deleteFromDatabaseWithInfomation:_infoArray[indexPath.row]];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Infomation *info = _infoArray[indexPath.row];
    [self showDetailViewWithInfo:info];
}

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

#pragma mark - Private Methods

- (void) loadDataBase{
    
    [_infoArray removeAllObjects];

    _infoArray = [NSMutableArray arrayWithArray:[Infomation MR_findAll]];
    
}

- (void) deleteFromDatabaseWithInfomation:(Infomation*)info{

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self == %@",info];
    NSArray *foundArray = [Infomation MR_findAllWithPredicate:predicate];
    Infomation *needDeleteInfo = [foundArray firstObject];
    [needDeleteInfo MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (error) {
            [GQUtils showAlert:[error localizedDescription]];
        }else{
        
            if (success == YES) {
                
                [GQUtils showAlert:@"删除成功"];
                [self viewWillAppear:NO];
            }else{
                
                [GQUtils showAlert:@"删除失败，请重试"];
            }
        }
    }];
}

#pragma mark - Public Methods

- (void)showDetailViewWithInfo:(Infomation *)info
{
    if (_detailsVC != nil) {
        return;
    }
    
    [self.navigationController.navigationBar setUserInteractionEnabled: NO];
    [[self.navigationController navigationBar] setBarTintColor: RGBA(76, 76, 76, 1)];
    
    _detailsVC = [self.storyboard instantiateViewControllerWithIdentifier: @"GQDetailsVC"];
    _detailsVC.info = info;
    
    
    // 设置显示内容
    
    [_detailsVC willMoveToParentViewController: self];
    [self addChildViewController: _detailsVC];
    // 设置覆盖的view的frame与底层的大小一致
    
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    [_detailsVC.view setFrame: frame];
    
    [self.view addSubview: _detailsVC.view];
    
    [_detailsVC didMoveToParentViewController: self];
    
    [_detailsVC dismissWelcomeAlertViewBlock:^{
        [self hideUnloginAlertView];
    }];
}

- (void)hideUnloginAlertView
{
    [UIView animateWithDuration: 0.3f animations:^{
        
        UIView *detailsView = _detailsVC.detailsView;
        [GQUtils moveViewToY: detailsView y: _detailsVC.view.frame.size.height];
        
    } completion:^(BOOL finished) {
        
        [self.navigationController.navigationBar setUserInteractionEnabled: YES];
        [[self.navigationController navigationBar] setBarTintColor: [UIColor whiteColor]];
        
        [_detailsVC willMoveToParentViewController: nil];
        [_detailsVC.view removeFromSuperview];
        [_detailsVC removeFromParentViewController];
        [_detailsVC didMoveToParentViewController: nil];
        [_detailsVC.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:NO];
        
        _detailsVC = nil;
    }];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

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

@interface GQInfoListVC ()
{

    NSMutableArray *_infoArray;
}

@end

@implementation GQInfoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _infoArray = [[NSMutableArray alloc]init];
    self.navigationItem.title = @"我的👣";

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

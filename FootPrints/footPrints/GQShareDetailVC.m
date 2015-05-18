//
//  GQShareDetailVC.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/17.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQShareDetailVC.h"
#import "GQUtils.h"

@interface GQShareDetailVC ()<UITextViewDelegate>

@end

@implementation GQShareDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadGQShareDetailVCUI];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(returnKey_Pressed:)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Operations

- (void) loadGQShareDetailVCData{}

- (void) loadGQShareDetailVCUI{

    _scrollView.contentSize = CGSizeMake(320, 660);
    
    _locationImageView.image = self.image;
    
    _remarkTextView.delegate = self;
}


#pragma mark - TextView Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    _hintLb.hidden = YES;

    _scrollView.contentOffset = CGPointMake(0, KEYBOARD_HEIGHT);
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{

    if ([_remarkTextView.text isEqualToString:@""]) {
        _hintLb.hidden = NO;
    }
    [_remarkTextView resignFirstResponder];
    _scrollView.contentOffset = CGPointMake(0, 90);
}

#pragma mark - Button Events

- (IBAction)changeLocationBtn_Pressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)returnKey_Pressed:(id)sender{

    [_remarkTextView resignFirstResponder];
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

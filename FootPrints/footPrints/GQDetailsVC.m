//
//  GQDetailsVC.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/29.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQDetailsVC.h"
#import "GQUtils.h"


@interface GQDetailsVC ()<UIScrollViewDelegate>
{
    NSMutableArray *_blocks;
}

@end

@implementation GQDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [GQUtils moveViewToY: _detailsView y: self.view.frame.size.height];
}

- (void) awakeFromNib{


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setContentWithInfo:self.info];
//    self.navigationController.navigationBarHidden = YES;
    
    [UIView animateWithDuration: 0.3f animations:^{
        
        [GQUtils moveViewToY: _detailsView y: 100.0f];
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setContentWithInfo:(Infomation*) info{

    _remarkLb.text = info.remark;
    
    _remarkLb.numberOfLines = 0;
    
    UIFont *font = [UIFont systemFontOfSize:17];
    
    _remarkLb.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *fontDic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName ,nil];
    
    //    NSLog(@"self.view :%@",NSStringFromCGRect(self.frame));
    
    CGSize size = [_remarkLb.text boundingRectWithSize:CGSizeMake(242, MAXFLOAT)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:fontDic context:nil].size;
    
    _remarkLb.frame = CGRectMake(_remarkLb.frame.origin.x, _remarkLb.frame.origin.y, _remarkLb.frame.size.width, size.height);
    
    // 设置时间
    NSString *time = [info.date substringWithRange:NSMakeRange(0, 11)];
    _dateLb.text = [NSString stringWithFormat:@"时间: %@",time];
    
    // 设置图片
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(264 * [info.photoArray count],0);
    
    for (int i=0; i<[info.photoArray count]; i++) {
        UIImageView *detailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(264 * i, 0, 264, 384)];
        detailImageView.image = [info.photoArray objectAtIndex:i];
        detailImageView.userInteractionEnabled = NO;
        [_scrollView addSubview:detailImageView];
    }

}


#pragma mark - Button Events

- (IBAction)closeBtn_Pressed:(id)sender {
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    id obj = [_blocks lastObject];
    ((void (^)())obj)();
}

-(void)dismissWelcomeAlertViewBlock:(void (^)())block {
    _blocks = [NSMutableArray arrayWithObjects:block, nil];
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

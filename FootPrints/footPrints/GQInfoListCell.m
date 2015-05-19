//
//  GQInfoListCell.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/20.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQInfoListCell.h"


@implementation GQInfoListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setContentWithInfomation:(Infomation*)info{

    // 设置详情信息
    
    _remarkLb.text = info.remark;
    
    _remarkLb.numberOfLines = 0;
    
    UIFont *font = [UIFont systemFontOfSize:17];
    
    _remarkLb.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *fontDic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName ,nil];
    
//    NSLog(@"self.view :%@",NSStringFromCGRect(self.frame));
    
    CGSize size = [_remarkLb.text boundingRectWithSize:CGSizeMake(304, MAXFLOAT)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:fontDic context:nil].size;
    
    _remarkLb.frame = CGRectMake(_remarkLb.frame.origin.x, _remarkLb.frame.origin.y, _remarkLb.frame.size.width, size.height);
    

    // 设置时间
    NSString *time = [info.date substringWithRange:NSMakeRange(0, 11)];
    _timeLb.text = [NSString stringWithFormat:@"时间: %@",time];
    
    // 设置imageView
    CGFloat heightForImageHolderView = 100;
    if ([info.photoArray count] > 2) {
        heightForImageHolderView = 205;
    }
    _imageHolderView.frame = CGRectMake(_imageHolderView.frame.origin.x, _imageHolderView.frame.origin.y, 205, heightForImageHolderView);
    
    for (int i=200; i<204; i++) {
        UIImageView *view = (UIImageView*)[_imageHolderView viewWithTag:i];
        view.image = nil;
    }
    
    for (int i=200; i<[info.photoArray count]+200; i++) {
        UIImageView *view = (UIImageView*)[_imageHolderView viewWithTag:i];
        view.image = [info.photoArray objectAtIndex:(i - 200)];
    }
}

@end

//
//  GQInfoListCell.h
//  footPrints
//
//  Created by jhonny.copper on 15/5/20.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Infomation.h"

@interface GQInfoListCell : UITableViewCell
{

    __weak IBOutlet UILabel *_remarkLb;
    __weak IBOutlet UILabel *_timeLb;
    __weak IBOutlet UIView *_imageHolderView;
}

- (void) setContentWithInfomation:(Infomation*)info;
- (CGFloat) heightForCell;

@end

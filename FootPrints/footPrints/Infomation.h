//
//  Infomation.h
//  footPrints
//
//  Created by jhonny.copper on 15/5/19.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Infomation : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) id photoArray;

@end

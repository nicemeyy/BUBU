//
//  BBScrollerCell.h
//  BUBU
//
//  Created by 董志盟 on 2018/10/8.
//  Copyright © 2018年 DZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBScrollerCell : UITableViewCell

@property (copy, nonatomic) void(^cellClickBlock)(NSInteger);

@end

NS_ASSUME_NONNULL_END

//
//  BBMovieDetialCell.m
//  BUBU
//
//  Created by 董志盟 on 2018/10/8.
//  Copyright © 2018年 DZM. All rights reserved.
//

#import "BBMovieDetialCell.h"

@implementation BBMovieDetialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.detalLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

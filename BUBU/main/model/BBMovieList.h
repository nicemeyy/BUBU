//
//  BBMovieList.h
//  BUBU
//
//  Created by 董志盟 on 2018/10/8.
//  Copyright © 2018年 DZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBMovieList : NSObject

+ (NSArray *)titArr;
+ (NSArray *)detailArr;
+ (NSArray *)imageArr;

+ (NSArray *)scrollerTitArr;
+ (NSArray *)scrollerDetailArr;

@end

NS_ASSUME_NONNULL_END

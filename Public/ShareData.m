//
//  XXShareData.m
//  National
//
//  Created by AnWu on 15/2/10.
//  Copyright (c) 2015年 anwu. All rights reserved.
//

#import "ShareData.h"

@implementation ShareData

static ShareData *shareData;
+(ShareData *)shareInstance; {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareData = [[ShareData alloc] init];
    });
    return shareData;
}



@end

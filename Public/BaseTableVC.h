//
//  BaseTableVC.h
//  Lease
//
//  Created by user on 16/8/16.
//  Copyright © 2016年 anwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHeader.h"

@interface BaseTableVC : UITableViewController

@property (nonatomic, strong) id lastParams;
@property (nonatomic, strong) BlockBack backBlock;

/**
 *  其他页面引用当前页面的调用
 *
 *  @param sender 传入参数
 *  @param block   回调
 */
- (void)content:(id)sender backBlock:(BlockBack)block;

@end

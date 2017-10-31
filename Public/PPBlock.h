//
//  ChainsBlock.h
//  Chains
//
//  Created by user on 16/8/3.
//  Copyright © 2016年 anwu. All rights reserved.
//

#ifndef PPBlock_h
#define PPBlock_h
#import "BaseHeader.h"

typedef void(^BlockBack)(id sender);

typedef void(^BlockIndex)(NSInteger index);
typedef void(^BlockCell)(NSIndexPath *indexPath, id content);
typedef void(^BlockVoid)();
typedef void(^BlockButton)(UIButton *button);
typedef void(^BlockText)(NSString *text);

#endif /* ChainsBlock_h */

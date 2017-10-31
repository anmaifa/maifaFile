//
//  BaseVC.m
//  Chains
//
//  Created by user on 16/7/10.
//  Copyright © 2016年 anwu. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC() {
}

@end

@implementation BaseVC

#pragma mark +++++++++++++++++++ start life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self createInitView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BaseVC *vc = segue.destinationViewController;
    [vc content:sender backBlock:^(id sender) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -- end life cycle


#pragma mark +++++++++++++++++++ start custom action
- (void)createUI {
}

- (void)createData {
    [self requestIntent];
}

- (void)requestIntent {
}

- (void)createInitView {
    self.view.backgroundColor = K_BACKGROUND_COLOR;
    ;
    if (self.navigationController.viewControllers[0] != self) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 40, 30);
        [backButton setImage:[UIImage imageNamed:@"gg_fh"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [item setTintColor:[UIColor blueColor]];
        self.navigationItem.leftBarButtonItem = item;
    }
}

/**
 *  其他页面引用当前页面的调用
 *
 *  @param content 传入参数
 *  @param block   回调
 */
- (void)content:(id)sender backBlock:(BlockBack)block {
    self.lastParams = sender;
    self.backBlock = block;
}

#pragma mark -- end custom action
- (void)back:(UIButton *)sender
{
    if (self.backBlock) {
        self.backBlock(@NO);
    }
//    if (self.navigationController.view.superview == [UIApplication sharedApplication].keyWindow) {
//        CGRect frame = self.navigationController.view.frame;
//        frame.origin.x = frame.size.width;
//        [UIView animateWithDuration:0.4 animations:^{
//            self.navigationController.view.frame = frame;
//        } completion:^(BOOL finished) {
//            [self.navigationController.view removeFromSuperview];
//        }];
//    }
//    else
    if (self.navigationController.childViewControllers.firstObject == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark +++++++++++++++++++ start view action

#pragma mark -- end view action





#pragma mark +++++++++++++++++++ start delegate

#pragma mark -- end delegate






@end












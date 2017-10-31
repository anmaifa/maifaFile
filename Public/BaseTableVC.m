//
//  BaseTableVC.m
//  Lease
//
//  Created by user on 16/8/16.
//  Copyright © 2016年 anwu. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC ()

@end

@implementation BaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BaseVC *vc = segue.destinationViewController;
    [vc content:sender backBlock:^(id sender) {
    }];
}

- (void)viewDidLayoutSubviews {
    [self createInitView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createInitView {
    self.view.backgroundColor = K_BACKGROUND_COLOR;
    
    if (self.navigationController.viewControllers[0] != self) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 40, 30);
        [backButton setImage:[UIImage imageNamed:@"gg_fh"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [item setTintColor:[UIColor blueColor]];
        self.navigationItem.backBarButtonItem = item;
    }
}

/**
 *  其他页面引用当前页面的调用
 *
 *  @param content 传入参数
 *  @param block   回调
 */
- (void)content:(id)sender backBlock:(BackBlock)block {
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

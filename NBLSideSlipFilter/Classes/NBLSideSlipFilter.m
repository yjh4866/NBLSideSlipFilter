//
//  NBLSideSlipFilter.m
//  testNavTab
//
//  Created by 杨建红 on 2019/9/9.
//  Copyright © 2019 杨建红. All rights reserved.
//

#import "NBLSideSlipFilter.h"
#import "NBLSSFViewController.h"

@interface NBLSideSlipFilter ()
@property (nonatomic, assign) BOOL showing;
@property (nonatomic, strong) NBLSSFViewController *ssfVC;
@end

@implementation NBLSideSlipFilter

+ (instancetype)sharedInstance
{
    static NBLSideSlipFilter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NBLSideSlipFilter alloc] init];
    });
    return sharedInstance;
}

- (void)reloadData
{
    self.ssfVC.dataList = self.dataList;
    [self.ssfVC.collectionView reloadData];
}

- (void)showIn:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.showing) {
        [self closeAnimated:NO];
    }
    // 加载筛选器视图并显示
    NSBundle *bundle = [NSBundle bundleForClass:NBLSideSlipFilter.class];
    self.ssfVC = [[NBLSSFViewController alloc] initWithNibName:@"NBLSideSlipFilter.bundle/NBLSSFViewController" bundle:bundle];
    self.ssfVC.dataList = self.dataList;
    self.ssfVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [viewController addChildViewController:self.ssfVC];
    [viewController.view addSubview:self.ssfVC.view];
    self.showing = YES;
    // 添加约束
    self.ssfVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:viewController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.ssfVC.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:viewController.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.ssfVC.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:viewController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.ssfVC.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:viewController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.ssfVC.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[left, right, top, bottom]];
    //
    CGSize sizeVC = viewController.view.bounds.size;
    void (^animations)(void) = ^{
        self.ssfVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
        self.ssfVC.constraintLeftMargin.constant = 0.2f*sizeVC.width;
        [self.ssfVC.view layoutIfNeeded];
    };
    self.ssfVC.constraintLeftMargin.constant = sizeVC.width;
    if (animated) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3f animations:animations];
        });
    } else {
        animations();
    }
}

- (void)closeAnimated:(BOOL)animated
{
    void (^animations)(void) = ^{
        self.ssfVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        CGSize sizeVC = self.ssfVC.view.bounds.size;
        self.ssfVC.constraintLeftMargin.constant = sizeVC.width;
        [self.ssfVC.view layoutIfNeeded];
    };
    void (^completion)(BOOL) = ^(BOOL finished){
        [self.ssfVC removeFromParentViewController];
        [self.ssfVC.view removeFromSuperview];
        self.ssfVC = nil;
        self.showing = NO;
    };
    if (animated) {
        [UIView animateWithDuration:0.3f animations:animations completion:completion];
    } else {
        animations();
        completion(YES);
    }
}

@end

//
//  NBLSideSlipFilter.h
//  testNavTab
//
//  Created by 杨建红 on 2019/9/9.
//  Copyright © 2019 杨建红. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBLSSFGroup.h"

NS_ASSUME_NONNULL_BEGIN

@class UIViewController;

@interface NBLSideSlipFilter : NSObject

@property (nonatomic, readonly) BOOL showing;
@property (nonatomic, strong) NSArray<id<NBLSSFGroup>> *dataList;

@property (nonatomic, copy) void(^blockClickClose)(void);
@property (nonatomic, copy) void(^blockClickOK)(void);

+ (instancetype)sharedInstance;

- (void)reloadData;

- (void)showIn:(UIViewController *)viewController animated:(BOOL)animated;

- (void)closeAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

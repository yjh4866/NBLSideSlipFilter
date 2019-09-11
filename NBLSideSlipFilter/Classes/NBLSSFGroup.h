//
//  NBLSSFGroup.h
//  testNavTab
//
//  Created by 杨建红 on 2019/9/9.
//  Copyright © 2019 杨建红. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBLSSFItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NBLSSFGroup <NSObject>

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) BOOL showIcon;
@property (nonatomic, readonly) BOOL onlySingleSelection;
@property (nonatomic, readonly) NSArray<id<NBLSSFItem>> *itemList;

@end

@interface NBLSSFGroup : NSObject <NBLSSFGroup>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL showIcon;
@property (nonatomic, assign) BOOL onlySingleSelection;
@property (nonatomic, strong) NSArray<id<NBLSSFItem>> *itemList;

@end

NS_ASSUME_NONNULL_END

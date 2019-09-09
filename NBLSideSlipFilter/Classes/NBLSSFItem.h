//
//  NBLSSFItem.h
//  testNavTab
//
//  Created by 杨建红 on 2019/9/9.
//  Copyright © 2019 杨建红. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NBLSSFItem <NSObject>

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *iconUrl;

@end

@interface NBLSSFItem : NSObject <NBLSSFItem>

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *iconUrl;

@end

NS_ASSUME_NONNULL_END

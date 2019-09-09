//
//  NBLSSFViewController.h
//  testNavTab
//
//  Created by 杨建红 on 2019/9/9.
//  Copyright © 2019 杨建红. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NBLSSFGroup;

@interface NBLSSFViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLeftMargin;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray<id<NBLSSFGroup>> *dataList;

@end

NS_ASSUME_NONNULL_END

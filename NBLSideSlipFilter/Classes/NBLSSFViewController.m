//
//  NBLSSFViewController.m
//  testNavTab
//
//  Created by 杨建红 on 2019/9/9.
//  Copyright © 2019 杨建红. All rights reserved.
//

#import "NBLSSFViewController.h"
#import "NBLSideSlipFilter.h"
#import "NBLSSFGroup.h"
#import "NBLSSFHeaderView.h"
#import "NBLSSFCell.h"

@interface NBLSSFViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@end

@implementation NBLSSFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //
    NSBundle *bundle = [NSBundle bundleForClass:NBLSideSlipFilter.class];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NBLSideSlipFilter.bundle/NBLSSFHeaderView" bundle:bundle] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NBLSSFHeaderView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NBLSideSlipFilter.bundle/NBLSSFCell" bundle:bundle] forCellWithReuseIdentifier:@"NBLSSFCell"];
}


#pragma mark - Events

- (IBAction)clickBG:(id)sender
{
    [[NBLSideSlipFilter sharedInstance] closeAnimated:YES];
}
- (IBAction)clickClose:(id)sender
{
    BOOL close = YES;
    if ([NBLSideSlipFilter sharedInstance].blockClickClose) {
        close = [NBLSideSlipFilter sharedInstance].blockClickClose();
    }
    if (close) {
        [[NBLSideSlipFilter sharedInstance] closeAnimated:YES];
    }
}
- (IBAction)clickOK:(id)sender
{
    BOOL close = YES;
    if ([NBLSideSlipFilter sharedInstance].blockClickOK) {
        NSMutableString *mstrParameter = [NSMutableString string];
        // 遍历分组
        for (id<NBLSSFGroup> group in self.dataList) {
            if (group.key.length > 0) {
                // 拼接分组参数
                NSString *parameterString = @"";
                for (id<NBLSSFItem> item in group.itemList) {
                    if (item.itemId.length > 0) {
                        if (item.selected) {
                            parameterString = [parameterString stringByAppendingFormat:@"%@,", item.itemId];
                        }
                    }
                }
                // 删除多余的逗号
                if (parameterString.length > 0) {
                    parameterString = [parameterString substringToIndex:parameterString.length-1];
                }
                [mstrParameter appendFormat:@"&%@=%@", group.key, parameterString];
            }
        }
        // 删除多余的“&”符号
        if (mstrParameter.length > 0) {
            [mstrParameter deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        close = [NBLSideSlipFilter sharedInstance].blockClickOK(mstrParameter);
    }
    if (close) {
        [[NBLSideSlipFilter sharedInstance] closeAnimated:YES];
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // 各分组至少有一个选中项
    for (id<NBLSSFGroup> group in self.dataList) {
        // 检查该分组是否存在选中项
        BOOL existSel = NO;
        for (id<NBLSSFItem> item in group.itemList) {
            if (item.selected) {
                existSel = YES;
                break;
            }
        }
        // 该分组不存在选中项，且存在可选项，则默认选中第一项
        if (!existSel && group.itemList.count > 0) {
            group.itemList[0].selected = YES;
        }
    }
    return self.dataList.count;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NBLSSFHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NBLSSFHeaderView" forIndexPath:indexPath];
        id<NBLSSFGroup> group = self.dataList[indexPath.section];
        headerView.labelTitle.text = group.title;
        return headerView;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id<NBLSSFGroup> group = self.dataList[section];
    return group.itemList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NBLSSFCell *ssfCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NBLSSFCell" forIndexPath:indexPath];
    ssfCell.ssfItem = self.dataList[indexPath.section].itemList[indexPath.row];
    return ssfCell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NBLSSFCell *ssfCell = (NBLSSFCell *)[collectionView cellForItemAtIndexPath:indexPath];
    // 分组只能单选
    id<NBLSSFGroup> group = self.dataList[indexPath.section];
    if (group.onlySingleSelection) {
        // 已经选择该Cell则不必处理
        if (ssfCell.ssfItem.selected) {
            return;
        }
        ssfCell.ssfItem.selected = YES;
        // 其他Cell改为未选中
        for (id<NBLSSFItem> item in group.itemList) {
            if (item != ssfCell.ssfItem) {
                item.selected = NO;
            }
        }
        // 刷新该分组
        [collectionView reloadData];
    }
    // 分组可多选
    else {
        ssfCell.ssfItem.selected = !ssfCell.ssfItem.selected;
        ssfCell.ssfItem = ssfCell.ssfItem;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<NBLSSFGroup> group = self.dataList[indexPath.section];
    static const CGFloat minCellWidth = 60;
    int column = (collectionView.bounds.size.width-10)/(10+minCellWidth);
    CGFloat cellWidth = (int)floor(collectionView.bounds.size.width-10)/column - 10;
    return CGSizeMake(cellWidth, group.showIcon?72:27);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, 40);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

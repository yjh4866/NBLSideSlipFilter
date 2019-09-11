//
//  NBLViewController.m
//  NBLSideSlipFilter
//
//  Created by 杨建红 on 09/09/2019.
//  Copyright (c) 2019 杨建红. All rights reserved.
//

#import "NBLViewController.h"
#import <NBLSideSlipFilter/NBLSideSlipFilter.h>

@interface NBLViewController ()

@end

@implementation NBLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickFilter:(id)sender
{
    if ([NBLSideSlipFilter sharedInstance].showing) {
        [[NBLSideSlipFilter sharedInstance] closeAnimated:YES];
    } else {
        //
        NBLSSFItem *item00 = [[NBLSSFItem alloc] init];
        item00.title = @"太原市";
        item00.selected = YES;
        NBLSSFItem *item01 = [[NBLSSFItem alloc] init];
        item01.title = @"大同市";
        NBLSSFGroup *group0 = [[NBLSSFGroup alloc] init];
        group0.title = @"星级";
        group0.itemList = @[item00, item01];
        //
        NBLSSFItem *item10 = [[NBLSSFItem alloc] init];
        item10.iconUrl = @"http://192.168.1.177/icon/1.png";
        item10.title = @"山";
        NBLSSFItem *item11 = [[NBLSSFItem alloc] init];
        item11.iconUrl = @"http://192.168.1.177/icon/2.png";
        item11.title = @"博物馆";
        NBLSSFGroup *group1 = [[NBLSSFGroup alloc] init];
        group1.title = @"分类";
        group1.showIcon = YES;
        group1.onlySingleSelection = YES;
        group1.itemList = @[item10, item11];
        //
        [NBLSideSlipFilter sharedInstance].dataList = @[group0, group1];
        [[NBLSideSlipFilter sharedInstance] showIn:self animated:YES];
    }
}

@end

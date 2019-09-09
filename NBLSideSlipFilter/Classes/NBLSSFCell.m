//
//  NBLSSFCell.m
//  testNavTab
//
//  Created by 杨建红 on 2019/9/9.
//  Copyright © 2019 杨建红. All rights reserved.
//

#import "NBLSSFCell.h"
#import <SDWebImage/SDWebImage.h>

@interface NBLSSFCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@end

@implementation NBLSSFCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // KVO
        [self addObserver:self forKeyPath:@"ssfItem"
                  options:NSKeyValueObservingOptionNew context:nil];
        //
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"ssfItem"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"ssfItem"]) {
        if (self.ssfItem.selected) {
            self.layer.borderColor = [UIColor orangeColor].CGColor;
        } else {
            self.layer.borderColor = [UIColor blackColor].CGColor;
        }
        [self.imageViewIcon sd_setImageWithURL:[NSURL URLWithString:self.ssfItem.iconUrl]];
        self.labelName.text = self.ssfItem.title;
    }
}

- (void)tapCell:(UITapGestureRecognizer *)tap
{
    self.ssfItem.selected = !self.ssfItem.selected;
    self.ssfItem = self.ssfItem;
}

@end

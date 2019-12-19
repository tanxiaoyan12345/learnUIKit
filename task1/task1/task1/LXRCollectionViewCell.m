//
//  LXRCollectionViewCell.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/17.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "LXRCollectionViewCell.h"
@interface LXRCollectionViewCell()

@end


@implementation LXRCollectionViewCell
-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.myImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        self.myImgView.layer.cornerRadius = CGRectGetWidth(self.myImgView.bounds)/2.f;
        self.myImgView.clipsToBounds = YES;
        [self.contentView addSubview:self.myImgView];
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 70, 40)];
        [self.contentView addSubview:self.myLabel];
    }
    return self;
}
@end

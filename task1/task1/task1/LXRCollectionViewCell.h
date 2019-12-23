//
//  LXRCollectionViewCell.h
//  task1
//
//  Created by tanxiaoyan on 2019/12/17.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXRCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) UILabel * myLabel;
@property (strong,nonatomic) UIImageView * myImgView;

/**
 MARK:@ydhz 每次提交commit之前养成自己review一遍的习惯，删除测试代码和无用变量，最好也不要提交自己debug lgog相关代码
 */
@property (strong,nonatomic) UIButton * flag;

@end

NS_ASSUME_NONNULL_END

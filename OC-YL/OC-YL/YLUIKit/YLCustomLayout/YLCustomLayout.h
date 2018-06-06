//
//  YLCustomLayout.h
//  YHCustomLayoutExample
//
//  Created by cy on 2018/6/6.
//  Copyright © 2018年 cmapu. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const YLCollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const YLCollectionElementKindSectionFooter;
@class YLCustomLayout;
typedef NS_ENUM(NSInteger,YLCustomLayoutType) {
    YLCustomLayoutTypeWaterFlow, /// 流水布局
};
@protocol YLCustomLayoutDelegate<UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)collectionViewLayout numberOfColumnsInSection:(NSInteger)section;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)layout insetForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)layout horizontalSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)collectionViewLayout verticalSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)layout heightForHeaderInSection:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)layout heightForFooterInSection:(NSInteger)section;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(YLCustomLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;
@end
@interface YLCustomLayout : UICollectionViewLayout
/// 列数 默认3
@property (assign, nonatomic) NSInteger numberOfColumns;
/// cell 水平间距 默认10
@property (assign, nonatomic) CGFloat horizontalSpacing;
/// 垂直间距 默认10
@property (assign, nonatomic) CGFloat verticalSpacing;
/// 头视图的高度 初始值为0
@property (assign, nonatomic) CGFloat headerReferenceHeight;
/// 尾视图的高度 初始值为0
@property (assign, nonatomic) CGFloat footerReferenceHeight;
/// section 偏移 默认偏移为UIEdgeInsetsZero
@property (nonatomic) UIEdgeInsets sectionInset;
/// cell尺寸
@property (nonatomic) CGSize itemSize;

- (instancetype)initWithType:(YLCustomLayoutType)type;
@end

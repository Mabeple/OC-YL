# 常用分类
[![Build Status](https://travis-ci.org/michaelliao/openweixin.svg?branch=master)](https://travis-ci.org/Mabeple/OC-YL)
## Foundation
> NSString
> > * NSString+YLHash 
> > * NSString+YLDrawing
> > * NSString+YLURLCode

## UIKit
> UILabel
> > * UILabel+YLContentInsets

# 封装UIKit
## YHWaterFlowLayout(流水布局)
#### 暂不支持横向
 * numberOfColumns 瀑布流列数
 * horizontalSpacing cell水平间距
 * verticalSpacing cell纵向间距
 * headerReferenceHeight 头视图的高度
 * footerReferenceHeight 尾视图的高度
 * sectionInset 每个section的偏移

##### 必须实现:
```
//返回每个高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YHWaterFlowLayout *)layout heightForCellAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;	     
```	    
##### 选择实现方法
```
//返回头部视图高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YHWaterFlowLayout*)layout heightForHeaderInSection:(NSInteger)section;
//返回尾部视图高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YHWaterFlowLayout*)layout heightForFooterInSection:(NSInteger)section;
```
* 如果设置headerReferenceHeight则每个section高度都为headerReferenceHeight
* 选择实现方法会覆盖headerReferenceHeight的高度
//
//  YQLabelSelect.h
//  PicaDo
//
//  Created by YunQue on 2017/8/3.
//  Copyright © 2017年 Codery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYLabelsSelect : UIView

/**
 高度自适应不需要指定高度,只需要指定x,y,width
 @param origin 标签控件的x,y坐标
 @param width 标签控件的宽度
 @return 标签控件实例
 */
-(instancetype)initWith:(CGPoint)origin width:(CGFloat)width;

/**
 初始化数据源
 */
@property(nonatomic,strong)NSArray<UIView *> *dataSource;

/**
 实时获取展示的标签元素(增删之后)
 */
@property(nonatomic,strong,readonly)NSArray *currentShowLabels;

/**
 点击获取元素所在currentLabelsArr中的位置
 */
@property(nonatomic,copy)void(^selected)(id selectedObject,NSInteger index);


/**
 最小的列间距
 */
@property(nonatomic,assign)CGFloat minColumnSpace;

/**
 最小的行间距
 */
@property(nonatomic,assign)CGFloat minRowSpace;

/**
 标签展示区域距离控件上,下,左,右距离
 */
@property(nonatomic,assign)UIEdgeInsets minMarginSpace;


/**
 增加的标签

 @param addArr 增加的标签数组
 */
-(void)addLabels:(NSArray<UIView *>*) addArr;

/**
 删除的标签

 @param deleteArr 删除的标签数组
 */
-(void)deleteLabels:(NSArray<UIView *>*)deleteArr;

/**
 主动设置标签数组中的某一项为选中

 @param index 选中的标签索引
 */
-(void)setSelectedLabel:(NSUInteger)index;

@end

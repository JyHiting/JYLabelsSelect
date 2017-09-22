//
//  YQLabelSelect.m
//  PicaDo
//
//  Created by YunQue on 2017/8/3.
//  Copyright © 2017年 Codery. All rights reserved.
//

#import "JYLabelsSelect.h"


#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface JYLabelsSelect()

@property(nonatomic,strong)NSMutableArray *labelsArr;
@property(nonatomic,assign)CGFloat ColumnSpace;
@property(nonatomic,assign)CGFloat RowSpace;
@property(nonatomic,assign)UIEdgeInsets MarginSpace;

@end

@implementation JYLabelsSelect

-(instancetype)initWith:(CGPoint)origin width:(CGFloat)width{

    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, width, 0)]) {
        
        _labelsArr = [NSMutableArray array];
        _ColumnSpace = 10;
        _RowSpace = 10;
        _MarginSpace = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}


-(void)reRefreshLabelsWith:(CGRect)rect{

    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    WeakSelf(weakSelf);
    CGFloat selfWidth = rect.size.width;
    __block CGFloat rowElementX = _MarginSpace.left;
    __block CGFloat rowElementY = _MarginSpace.top;
    //每次记录新的一行的所有标签元素
    NSMutableArray *rowElementArr = [NSMutableArray array];
    __block UIView *previousObj = nil;
    [_labelsArr enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.tag = idx + 1000;
        obj.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(elementSelect:)];
        [obj addGestureRecognizer:tapClick];
        
        if ((rowElementX + obj.bounds.size.width + _MarginSpace.right) > selfWidth) {
            
            
            //换行之前均等布局上一行行元素
            __block CGFloat rowElementTotalWidth = 0;
            __block CGFloat rowMaxObjHeight = 0;
            [rowElementArr enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                rowElementTotalWidth += obj.bounds.size.width;
                if (rowMaxObjHeight <= obj.bounds.size.height) {
                    rowMaxObjHeight = obj.bounds.size.height;
                }
            }];
            CGFloat newColumnSpace = (selfWidth - _MarginSpace.left - _MarginSpace.right - rowElementTotalWidth) / ([rowElementArr count] - 1);
            [rowElementArr enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx != 0) {
                    
                    obj.frame = CGRectMake(previousObj.frame.origin.x + previousObj.bounds.size.width + newColumnSpace, rowElementY,obj.bounds.size.width, obj.bounds.size.height);
                }
                previousObj = obj;

                if (idx == ([rowElementArr count] - 1)) {
                    rowElementY += rowMaxObjHeight + _RowSpace;
                    rowElementX = _MarginSpace.left;
                }
            }];

            [rowElementArr removeAllObjects];

            //换行(每行第一个元素)
            if (obj.bounds.size.width >= (selfWidth - _MarginSpace.left - _MarginSpace.right)) {
                obj.frame = CGRectMake(rowElementX, rowElementY, selfWidth - rowElementX - _MarginSpace.right, obj.bounds.size.height);
                rowElementY += obj.bounds.size.height + _RowSpace;
                rowElementX = _MarginSpace.left;
            }else{
            
                obj.frame = CGRectMake(rowElementX, rowElementY, obj.bounds.size.width, obj.bounds.size.height);
                rowElementX = rowElementX + obj.bounds.size.width + _ColumnSpace;
                [rowElementArr addObject:obj];
            }
            
        }else{
        
            obj.frame = CGRectMake(rowElementX, rowElementY, obj.bounds.size.width, obj.bounds.size.height);
            rowElementX += obj.bounds.size.width + _ColumnSpace;
            [rowElementArr addObject:obj];

        }
        [UIView animateWithDuration:0.3 animations:^{
            
            obj.alpha = 1;
        }];
        previousObj = obj;
        [weakSelf addSubview:obj];
        if (idx == ([self.labelsArr count] - 1)) {
            __block CGFloat rowMaxObjHeight = 0;
            [rowElementArr enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (rowMaxObjHeight <= obj.bounds.size.height) {
                    rowMaxObjHeight = obj.bounds.size.height;
                }
            }];
            weakSelf.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rowElementY + rowMaxObjHeight + _MarginSpace.bottom);
            previousObj = nil;
        }
    }];

}

-(void)setMinRowSpace:(CGFloat)minRowSpace{

    _RowSpace = minRowSpace;
    if ([_labelsArr count] != 0) {
      [self reRefreshLabelsWith:self.frame];
    }
}

-(void)setMinColumnSpace:(CGFloat)minColumnSpace{

    _ColumnSpace = minColumnSpace;
    if ([_labelsArr count] != 0) {
        [self reRefreshLabelsWith:self.frame];
    }
}

-(void)setMinMarginSpace:(UIEdgeInsets)minMarginSpace{

    _MarginSpace = minMarginSpace;
    if ([_labelsArr count] != 0) {
        [self reRefreshLabelsWith:self.frame];
    }
}

-(void)setDataSource:(NSArray *)dataSource{
    
    if ([dataSource count] != 0) {
        
        [_labelsArr addObjectsFromArray:dataSource];
        [self reRefreshLabelsWith:self.frame];
    }
}

-(NSArray *)currentShowLabels{

    return _labelsArr;
}

-(void)addLabels:(NSArray<UIView *>*)addArr{
    
    if ([addArr count] != 0) {
        [addArr enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.alpha = 0;
        }];
        [_labelsArr addObjectsFromArray:addArr];
        [self reRefreshLabelsWith:self.frame];
    }
}


-(void)deleteLabels:(NSArray<UIView *>*)deleteArr{
    
    if ([deleteArr count] != 0) {
      
        WeakSelf(weakSelf);
        NSInteger currentArrCount = [self.labelsArr count];
        [deleteArr enumerateObjectsUsingBlock:^(UIView * _Nonnull deleteObj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [weakSelf.labelsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (deleteObj == obj) {
                    
                    [weakSelf.labelsArr removeObject:obj];
                }
            }];
        }];
        
        if (currentArrCount != [self.labelsArr count]) {
            
            [self reRefreshLabelsWith:self.frame];
        }
    }
}


-(void)elementSelect:(UITapGestureRecognizer*)gesture{

    if (self.selected) {
        
        self.selected(gesture.view, gesture.view.tag - 1000);
    }
}

-(void)setSelectedLabel:(NSUInteger)index{
    
    if ([self.currentShowLabels count] != 0) {
        if (index <= ([self.currentShowLabels count] - 1)) {
            if (self.selected) {
                self.selected([self.currentShowLabels objectAtIndex:index],index);
            }
        }
    }
}

@end

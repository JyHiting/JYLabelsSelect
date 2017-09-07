//
//  ViewController.m
//  JYLabelsSelect
//
//  Created by YunQue on 2017/9/6.
//  Copyright © 2017年 YunQue. All rights reserved.
//

#import "ViewController.h"

#import "JYLabelsSelect.h"
#import "UILabel+SizeToFit.h"

@interface ViewController ()

@property(nonatomic,strong)JYLabelsSelect *labelSelect;
@property(nonatomic,strong)NSMutableArray *menuArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"iOS",@"小明",@"工资低",@"加班累",@"这个标签太长太长这个标签太长太长这个标签太长太长这个标签太长太长",@"小明不高兴了要转行",@"生活的乐趣",@"没有",@"iOS",@"小明",@"工资低",@"加班累",@"心里也很浮躁",@"小明不高兴了要转行",@"生活的乐趣",@"没有", nil];
    
    _menuArr = [NSMutableArray array];
    for (int index = 0; index < [titleArr count]; index ++ ) {
        
        UILabel *menuLabel = [UILabel new];
        menuLabel.backgroundColor = [UIColor brownColor];
        menuLabel.text = titleArr[index];
        menuLabel.font = [UIFont systemFontOfSize:15];
        CGFloat width = [menuLabel widthOfSizeToFit];
        menuLabel.frame = CGRectMake(0, 0, width, 30 + index * 5);
        [_menuArr addObject:menuLabel];
    }
    
    _labelSelect = [[JYLabelsSelect alloc] initWith:CGPointMake(0, 60) width:self.view.bounds.size.width];
    _labelSelect.dataSource = _menuArr;
    _labelSelect.minRowSpace = 5;
    _labelSelect.minMarginSpace = UIEdgeInsetsMake(5, 5, 5, 5);
    _labelSelect.selected = ^(id selectedObject, NSInteger index) {
       
        NSLog(@"_______%@",selectedObject);
    };
    _labelSelect.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_labelSelect];
    
    
    UIButton *addBt = [UIButton buttonWithType:UIButtonTypeCustom];
    addBt.backgroundColor = [UIColor grayColor];
    addBt.frame = CGRectMake(0, 10, 60, 30);
    [addBt addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [addBt setTitle:@"add" forState:UIControlStateNormal];
    [self.view addSubview:addBt];
    
    UIButton *deleteBt = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBt.backgroundColor = [UIColor grayColor];
    deleteBt.frame = CGRectMake(200, 10, 60, 30);
    [deleteBt addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [deleteBt setTitle:@"delete" forState:UIControlStateNormal];
    [self.view addSubview:deleteBt];

}

-(void)addClick{

    UILabel *newLabel = [UILabel new];
    newLabel.backgroundColor = [UIColor brownColor];
    newLabel.text = @"newAdd";
    newLabel.font = [UIFont systemFontOfSize:15];
    CGFloat width = [newLabel widthOfSizeToFit];
    newLabel.frame = CGRectMake(0, 0, width,30 + arc4random() % 60);
    [_labelSelect addLabels:@[newLabel]];
    NSLog(@"________%@",_labelSelect.currentShowLabels);
}

-(void)deleteClick{

    [_labelSelect deleteLabels:@[[_menuArr lastObject]]];
    [_menuArr removeLastObject];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

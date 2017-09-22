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
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"iOS",@"小明",@"工资低",@"加班累",@"标签太长",@"小明不高兴了",@"生活的乐趣",@"没有",@"iOS",@"小明",@"工资低",@"加班累",@"心里也很浮躁",@"小明不高兴了",@"生活的乐趣",@"没有", nil];
    
    _menuArr = [NSMutableArray array];
    for (int index = 0; index < [titleArr count]; index ++ ) {
        
        //只要是继承自UIView的类初始化长宽之后放到dataSource里即可
        UILabel *menuLabel = [UILabel new];
        menuLabel.textAlignment = NSTextAlignmentCenter;
        menuLabel.backgroundColor = [UIColor brownColor];
        menuLabel.text = titleArr[index];
        menuLabel.font = [UIFont systemFontOfSize:13];
        CGFloat width = [menuLabel widthOfSizeToFit];
        menuLabel.frame = CGRectMake(0, 0, width + 15 + 15, 30);
        menuLabel.layer.cornerRadius = 5.0;
        menuLabel.clipsToBounds = YES;
        [_menuArr addObject:menuLabel];
    }
    
    _labelSelect = [[JYLabelsSelect alloc] initWith:CGPointMake(0, 100) width:self.view.bounds.size.width];
    _labelSelect.dataSource = _menuArr;
    _labelSelect.minRowSpace = 5;
    _labelSelect.minMarginSpace = UIEdgeInsetsMake(5, 5, 5, 5);
    _labelSelect.selected = ^(UILabel *selectedObject, NSInteger index) {
        CAKeyframeAnimation *animaion = [CAKeyframeAnimation animation];
        animaion.keyPath = @"transform.rotation";
        animaion.values = @[@(-10 / 180.0 * M_PI),@(10 /180.0 * M_PI),@(-10/ 180.0 * M_PI)];
        animaion.removedOnCompletion = NO;
        animaion.fillMode = kCAFillModeForwards;
        animaion.duration = 0.3;
        animaion.repeatCount = MAXFLOAT;
        [selectedObject.layer addAnimation:animaion forKey:nil];
    };
    _labelSelect.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_labelSelect];
    
    
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int index = 0; index < [titleArr count]; index ++ ) {
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
        [image setImage:[UIImage imageNamed:@"fire"]];
        [imageArr addObject:image];
    }
    JYLabelsSelect *imageLabelSelect = [[JYLabelsSelect alloc] initWith:CGPointMake(0, _labelSelect.frame.origin.y + _labelSelect.frame.size.height + 20) width:self.view.bounds.size.width];
    imageLabelSelect.dataSource = imageArr;
    imageLabelSelect.minRowSpace = 5;
    imageLabelSelect.minMarginSpace = UIEdgeInsetsMake(5, 5, 5, 5);
    imageLabelSelect.selected = ^(id selectedObject, NSInteger index) {
        
        NSLog(@"_______%@",selectedObject);
    };
    imageLabelSelect.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imageLabelSelect];
    
    
    
    
    UIButton *addBt = [UIButton buttonWithType:UIButtonTypeCustom];
    addBt.backgroundColor = [UIColor grayColor];
    addBt.frame = CGRectMake(0, 50, 60, 30);
    [addBt addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [addBt setTitle:@"add" forState:UIControlStateNormal];
    [self.view addSubview:addBt];
    
    UIButton *deleteBt = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBt.backgroundColor = [UIColor grayColor];
    deleteBt.frame = CGRectMake(200, 50, 60, 30);
    [deleteBt addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [deleteBt setTitle:@"delete" forState:UIControlStateNormal];
    [self.view addSubview:deleteBt];
    
    UIButton *selectClickBt = [UIButton buttonWithType:UIButtonTypeCustom];
    selectClickBt.backgroundColor = [UIColor grayColor];
    selectClickBt.frame = CGRectMake(self.view.bounds.size.width/2 - 80, imageLabelSelect.frame.origin.y + imageLabelSelect.bounds.size.height + 10, 160, 30);
    [selectClickBt addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [selectClickBt setTitle:@"主动选择第5个" forState:UIControlStateNormal];
    [self.view addSubview:selectClickBt];
}

-(void)selectClick{
    
    [_labelSelect setSelectedLabel:5];
}

-(void)addClick{
    
    UILabel *menuLabel = [UILabel new];
    menuLabel.textAlignment = NSTextAlignmentCenter;
    menuLabel.backgroundColor = [UIColor brownColor];
    menuLabel.text = [NSString stringWithFormat:@"new%d",arc4random() % 60];
    menuLabel.font = [UIFont systemFontOfSize:13];
    CGFloat width = [menuLabel widthOfSizeToFit];
    menuLabel.frame = CGRectMake(0, 0, width + 15 + 15, 30);
    menuLabel.layer.cornerRadius = 5.0;
    menuLabel.clipsToBounds = YES;
    [_labelSelect addLabels:@[menuLabel]];
    NSLog(@"________%@",_labelSelect.currentShowLabels);
}

-(void)deleteClick{

    if ([_labelSelect.currentShowLabels count] != 0) {
        [_labelSelect deleteLabels:@[[_labelSelect.currentShowLabels lastObject]]];

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

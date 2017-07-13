//
//  CAGradientLayerCtrl.m
//  GradientColor
//
//  Created by LOLITA on 2017/7/13.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "CAGradientLayerCtrl.h"

#define getRandomNumberFromAtoB(A,B) (int)(A+(arc4random()%(B-A+1)))

@interface CAGradientLayerCtrl ()

{
    CAGradientLayer *gradientLayer;
}

@end

@implementation CAGradientLayerCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if ([self.title containsString:@"矩形"]) {
        [self drawGradientLayer];
    }
    else if ([self.title containsString:@"不规则"]){
        [self drawGradientLayer];
        [self drawMaskLayer];
    }
}



// !!!: 绘制渐变层
-(void)drawGradientLayer{
    
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
//    gradientLayer.locations = @[@0.0, @0.2, @0.5];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [self.view.layer addSublayer:gradientLayer];

}


// !!!: 添加遮罩
-(void)drawMaskLayer{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSInteger num = 50;
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width/num;
    for (int i=0; i<=num; i++) {
        if (i) {
            [path addLineToPoint:CGPointMake(i*itemWidth, getRandomNumberFromAtoB(100, 200))];
        }
        else{
            [path moveToPoint:CGPointMake(i*itemWidth, getRandomNumberFromAtoB(100, 200))];
        }
    }
    [path addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, 300)];
    [path addLineToPoint:CGPointMake(0, 300)];
    [path closePath];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    
    // 设置mask
    gradientLayer.mask = maskLayer;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

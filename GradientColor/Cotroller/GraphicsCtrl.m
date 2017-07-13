//
//  GraphicsCtrl.m
//  GradientColor
//
//  Created by LOLITA on 2017/7/13.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "GraphicsCtrl.h"

@interface GraphicsCtrl ()

@end

@implementation GraphicsCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if ([self.title containsString:@"线性"]) {
        // 绘制线性渐变
        [self drawLinearGradient];
    }
    else if ([self.title containsString:@"径向"]){
        // 绘制径向渐变
        [self drawRadialGradient];
    }
    
    
    
}


// !!!: 绘制线性渐变
-(void)drawLinearGradient{
    
    // 创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 100);
    CGPathAddLineToPoint(path, NULL, [UIScreen mainScreen].bounds.size.width, 150);
    CGPathAddLineToPoint(path, NULL, [UIScreen mainScreen].bounds.size.width, 400);
    CGPathAddLineToPoint(path, NULL, 0, 350);
    CGPathCloseSubpath(path);
 
    
    // 绘制渐变层
    {
        NSArray *colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
        //创建CGContextRef
        UIGraphicsBeginImageContext(self.view.bounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        CGFloat locations[] = { 0.0, 1.0 }; // 颜色位置设置,要跟颜色数量相等，否则无效
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, NULL);
        
        //起止点设置
        CGRect pathRect = CGPathGetBoundingBox(path);
        CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
        CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
        
        CGContextSaveGState(context);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
        CGContextRestoreGState(context);
        
        // 需要手动释放
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorSpace);
    }
    
    // 需要手动释放
    CGPathRelease(path);
    // 从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self.view addSubview:imgView];
}




// !!!: 绘制径向渐变
-(void)drawRadialGradient{
    // 创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 100);
    CGPathAddLineToPoint(path, NULL, [UIScreen mainScreen].bounds.size.width, 100);
    CGPathAddLineToPoint(path, NULL, [UIScreen mainScreen].bounds.size.width, 400);
    CGPathAddLineToPoint(path, NULL, 0, 400);
    CGPathCloseSubpath(path);
    
    // 绘制渐变层
    {
        NSArray *colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
        //创建CGContextRef
        UIGraphicsBeginImageContext(self.view.bounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, NULL);
        
        CGRect pathRect = CGPathGetBoundingBox(path);
        CGPoint center = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
        CGFloat radius = MAX(pathRect.size.width / 2.0, pathRect.size.height / 2.0) * sqrt(2);
        
        
        CGContextSaveGState(context);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, kCGGradientDrawsBeforeStartLocation);
        CGContextRestoreGState(context);
        
        // 需要手动释放
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorSpace);
    }
    
    
    // 需要手动释放
    CGPathRelease(path);
    // 从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self.view addSubview:imgView];
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

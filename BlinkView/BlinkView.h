//
//  BlinkView.h
//  BlinkView
//
//  Created by qq on 2017/5/4.
//  Copyright © 2017年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE
@interface BlinkView : UIView{
    CALayer* imageLayer;
    CALayer* altImageLayer;
    
    CATextLayer* textLayer;
    
    CADisplayLink *displayLink;
    double lastTime;// 最后一帧动画时间
    
}

@property(strong,nonatomic)UIImage* image;
@property(strong,nonatomic)UIImage* altImage;
@property(assign,nonatomic)CGRect imageRect;// 图标所在位置及大小
@property(assign,nonatomic)CGFloat gapWidth;// 图文之间的间隔
@property(assign,nonatomic)CGFloat fontSize;
@property(copy,nonatomic)NSString* text;
@property(strong,nonatomic)UIColor* textColor;
@property(strong,nonatomic)UIColor* altTextColor;
@property(assign,nonatomic)BOOL stopped;
@property(assign,nonatomic)IBInspectable double updateInterval;// 更新动画间隔时间

-(void)animating;
-(void)stopAnimating;

@end

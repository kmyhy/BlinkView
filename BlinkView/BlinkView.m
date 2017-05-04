//
//  BlinkView.m
//  BlinkView
//
//  Created by qq on 2017/5/4.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "BlinkView.h"

@implementation BlinkView


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}

-(void)setup{
    self.image = [UIImage imageNamed:@"recsmall_nor"];
    self.altImage = [UIImage imageNamed:@"recsmall_pre"];
    
    self.text = @"Rec";
    
    self.updateInterval = 0.2;
    self.gapWidth= 6;
    self.imageRect= CGRectMake(0,4,12, 12);

    self.fontSize = 16;
    
    self.textColor= [UIColor colorWithRed:0xfa/255.0 green:0x50/255.0 blue:0x42/255.0 alpha:1];
    
    self.altTextColor = [UIColor colorWithRed:0xff/255.0 green:0xe5/255.0 blue:0xe3/255.0 alpha:1];
    
    imageLayer = [CALayer layer];
    imageLayer.frame= _imageRect;
    
    imageLayer.contents = (id)self.image.CGImage;
    
    _stopped = YES;
    self.backgroundColor = [UIColor clearColor];
    
    altImageLayer = [CALayer layer];
    altImageLayer.frame= imageLayer.frame;
    altImageLayer.contents = (id)self.altImage.CGImage;
    
    // 不要在初始化方法里添加 subLayers,而应当在 layoutSubviews 方法中添加
    [self.layer addSublayer:altImageLayer];
    [self.layer addSublayer:imageLayer];// imageLayer 添加在 altImageLayer 上层以便遮住它
    
    textLayer = [CATextLayer layer];
    textLayer.font = (__bridge CFTypeRef _Nullable)([UIFont systemFontOfSize: self.fontSize]);
    textLayer.fontSize = self.fontSize;
    CGSize size= [self titleTextSize];
    
    textLayer.frame = CGRectMake(CGRectGetMaxX(_imageRect)+_gapWidth, 0, size.width, size.height);
    textLayer.string = _text;
    
    textLayer.alignmentMode = kCAAlignmentCenter;
    
    textLayer.foregroundColor = self.textColor.CGColor;
    
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.layer addSublayer:textLayer];
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(blink:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [displayLink setPaused:YES];
}

-(CGSize)titleTextSize{
    
    NSString* title = self.text;
    
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:self.fontSize], NSParagraphStyleAttributeName: textStyle};
    
    CGSize titleSize = [title boundingRectWithSize: CGSizeMake(self.frame.size.width-CGRectGetMaxX(_imageRect)-_gapWidth, self.frame.size.height)  options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size;
    
    return titleSize;
}
// CADisplayLink
-(void)blink:(CADisplayLink *)sender{
    
    if(_stopped==NO){ // stopped == YES 表示停止倒计时，不执行以下代码
        // 正在倒计时，按每秒更新
        double now = CACurrentMediaTime();
        double deltaTime = now - lastTime;
        
        if(deltaTime >= _updateInterval){// 达到指定时间间隔
            lastTime = now;
            
            imageLayer.hidden = !imageLayer.hidden;
            
            UIColor* color = imageLayer.hidden? self.altTextColor : self.textColor;
            
            textLayer.foregroundColor = color.CGColor;
        }
    }else{
        [displayLink invalidate];
    }
}

-(void)animating{
    if(_stopped == YES){
        [displayLink setPaused:NO];
        
        _stopped = NO;
        [self setNeedsDisplay];
    }
}
-(void)stopAnimating{
    if(_stopped == NO){
        [displayLink setPaused:YES];
        
        imageLayer.hidden = YES;
        textLayer.foregroundColor = self.altTextColor.CGColor;
        _stopped = YES;
    }
}
@end

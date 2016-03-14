//
//  HBTurnPlate.m
//  0605转盘
//
//  Created by 黄宾宾 on 6/5/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "HBTurnPlate.h"
#import "HBWheelBtn.h"
@interface HBTurnPlate()
@property (weak, nonatomic) IBOutlet UIImageView *rotateWheel;
@property (nonatomic,weak) UIButton *selectedBtn;
@property (nonatomic,weak) CADisplayLink *link;

- (IBAction)startChoose;

@end

@implementation HBTurnPlate

+(instancetype)wheel{
    return [[[NSBundle mainBundle] loadNibNamed:@"HBTurnPlate" owner:self options:nil]lastObject];
}

/**
 *  在这个方法中取得的属性才是有值的
 */
-(void)awakeFromNib{
    self.rotateWheel.userInteractionEnabled = YES;
    
    //加载要裁剪的星座名称图
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *bigImageSelected = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    CGFloat smallW = bigImage.size.width /12 * [UIScreen mainScreen].scale;
    CGFloat smallH = bigImage.size.height * [UIScreen mainScreen].scale;
    // 添加12个按钮
    for (int index = 0; index <12; index++) {
        HBWheelBtn *btn = [HBWheelBtn buttonWithType:UIButtonTypeCustom];
        
        //从大图中裁剪出对应星座的图片
        
        CGRect smallRect = CGRectMake(index * smallW,0, smallW, smallH);
        
        CGImageRef smallImage = CGImageCreateWithImageInRect(bigImage.CGImage, smallRect);
        
        [btn setImage:[UIImage imageWithCGImage:smallImage] forState:UIControlStateNormal];
        
        CGImageRef smallImageSelected = CGImageCreateWithImageInRect(bigImageSelected.CGImage, smallRect);
        
        [btn setImage:[UIImage imageWithCGImage:smallImageSelected] forState:UIControlStateSelected];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        
        //btn.backgroundColor = [UIColor blackColor];
        
        btn.bounds = CGRectMake(0, 0, 68, 143);
        
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        
        btn.layer.position = CGPointMake(self.rotateWheel.frame.size.width * 0.5, self.rotateWheel.frame.size.height * 0.5);
        
        CGFloat angle = (30 *index)/180.0 * M_PI;
        
        btn.transform = CGAffineTransformMakeRotation(angle);
        
        //监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];

        [self.rotateWheel addSubview:btn];
   }
}

/**
 *  监听按钮的点击
 */
-(void)btnClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    
    btn.selected = YES;
    
    self.selectedBtn = btn;
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    for (UIButton *btn in self.rotateWheel.subviews) {
//        btn.layer.position = CGPointMake(self.rotateWheel.frame.size.width * 0.5, self.rotateWheel.frame.size.height * 0.5);
//    }
//    
//}
/**
 *  开始不停旋转
 */
-(void)startRotating{
    //核心动画不能修改image的属性，所以不能用，而且程序进入后台之后核心动画就会停下来
//    CABasicAnimation *anim = [CABasicAnimation animation];
//    
//    anim.keyPath = @"transform.rotation";
//    
//    anim.toValue = @(2*M_PI);
//    
//    anim.duration = 4;
//    
//    anim.repeatCount = MAXFLOAT;
//    
//    [self.rotateWheel.layer addAnimation:anim forKey:nil];
    
    //sixty times per minute
    if (self.link) {
        return;
    }
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotate)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

-(void)rotate{
    
    self.rotateWheel.transform = CGAffineTransformRotate(self.rotateWheel.transform, M_PI*0.003);
    
}

-(void)stopRotating{
    [self.link invalidate];
    self.link = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)startChoose {
    [self stopRotating];
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"transform.rotation";
    
    anim.toValue = @(2 * M_PI *3);
    
    anim.duration = 3;
    
    anim.delegate = self;
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.rotateWheel.layer addAnimation:anim forKey:nil];
    
    self.userInteractionEnabled = NO;
    

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    self.userInteractionEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startRotating];
    });
}
@end
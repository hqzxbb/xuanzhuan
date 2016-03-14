//
//  HBWheelBtn.m
//  0605转盘
//
//  Created by 黄宾宾 on 6/7/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "HBWheelBtn.h"

@implementation HBWheelBtn

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = 40;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width - imageW)*0.5;
    CGFloat imageY = 25;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{ 
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

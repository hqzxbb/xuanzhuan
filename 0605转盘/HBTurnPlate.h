//
//  HBTurnPlate.h
//  0605转盘
//
//  Created by 黄宾宾 on 6/5/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBTurnPlate : UIView
+(instancetype)wheel;
-(void)startRotating;
-(void)stopRotating;
@end

//
//  ViewController.m
//  0605转盘
//
//  Created by 黄宾宾 on 6/5/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "ViewController.h"
#import "HBTurnPlate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HBTurnPlate *wheel = [HBTurnPlate wheel];
    
    wheel.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    
    [wheel startRotating];
    
    [self.view addSubview:wheel];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

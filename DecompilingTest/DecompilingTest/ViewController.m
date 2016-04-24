//
//  ViewController.m
//  DecompilingTest
//
//  Created by Jim on 16/4/24.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)testClassDump
{
    NSLog(@"hello Buddy");
}

- (void)testHideClassDump
{
    NSLog(@"I guess u can't find me");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

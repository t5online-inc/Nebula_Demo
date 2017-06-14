//
//  ViewController.m
//  NebulaDemo
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "ViewController.h"

#define URL @"http://www.t5online.com:9080/nebula/test/index.html"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [[self webView] loadRequest:request];
    
}


@end

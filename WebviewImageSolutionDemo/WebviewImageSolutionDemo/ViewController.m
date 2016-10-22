//
//  ViewController.m
//  WebviewImageSolutionDemo
//
//  Created by Jim on 16/7/1.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSURLConnection *connection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://kuailejim.com"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doRefreshButton:(id)sender {
    [self.webview reload];
    NSCondition *condition = [[NSCondition alloc] init];
    
    NSMutableArray *products = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [condition lock];
            if ([products count] == 0) {
                NSLog(@"wait for product");
                [condition wait];
            }
            [products removeObjectAtIndex:0];
            NSLog(@"custome a product");
            [condition unlock];
        }
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [condition lock];
            [products addObject:[[NSObject alloc] init]];
            NSLog(@"produce a product,总量:%zi",products.count);
            [condition signal];
            [condition unlock];
            sleep(1);
        }
        
    });
}
- (IBAction)doLoadImageButton:(id)sender {
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://kuailejim.com/images/background-cover.jpg"]];
    __weak ViewController *wSelf = self;
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://kuailejim.com/images/background-cover.jpg"]];
    NSURLSession * defaultSession = [NSURLSession sharedSession];
    NSURLSessionTask * task= [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            wSelf.imageView.image = [UIImage imageWithData:data];
        });
    }];
    //开始任务
    [task resume];
}

@end

//
//  ViewController.m
//  mmap_test
//
//  Created by andysheng on 2020/4/9.
//  Copyright © 2020 andysheng. All rights reserved.
//

#import "ViewController.h"
#import <sys/mman.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    off_t size = 100 * 1024 * 1024;
    
    NSString *mmapFile = [NSHomeDirectory() stringByAppendingPathComponent:@"voice.pcm"];
    
    
    
    int fp = open(mmapFile.UTF8String, O_RDWR | O_CREAT | O_TRUNC, 0644);
    if (ftruncate(fp, size)) {
        NSLog(@"truncate error");
    }
    
    short *ptr= mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fp, 0);
    for (int i = 0; i < size / 2; ++i) {
        ptr[i] = i;
    }
    
    int cnt = 0;
    for (int i = 0; i < size / 2; ++i) {
        cnt += ptr[i];
    }
    NSLog(@"%ld", cnt);
}


@end

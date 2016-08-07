//
//  ViewController.m
//  JWCode
//
//  Created by zjiawei666 on 16/8/7.
//  Copyright © 2016年 zjiawei666. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray<NSURL *> *importURLs;
@property (nonatomic, strong) NSURL *exportURL;

@end

@implementation ViewController

- (IBAction)importTouch:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.allowsMultipleSelection = YES;
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
        if (result > 0) {
            self.importURLs = panel.URLs;
            NSLog(@"%@", self.importURLs);
        }
    }];
}

- (IBAction)exportTouch:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.canChooseDirectories = YES;
    panel.canChooseFiles = NO;
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
        if (result == 1) {
            self.exportURL = panel.URL;
            NSLog(@"%@", self.exportURL);
        }
    }];
}

@end

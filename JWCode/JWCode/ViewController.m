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

- (void)codeWithContentsOfURL:(NSURL *)url {
    NSMutableString *mHCode = [NSMutableString string];
    NSMutableString *mMCode = [NSMutableString string];
    NSMutableString *vHCode = [NSMutableString string];
    NSMutableString *vMCode = [NSMutableString string];
    NSMutableString *cHCode = [NSMutableString string];
    NSMutableString *cMCode = [NSMutableString string];
    
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfURL:url];
    NSString *file = [config[@"file"] capitalizedString];
    NSString *mFile = [file stringByAppendingString:@"Model"];
    NSString *vFile = [file stringByAppendingString:@"TableViewCell"];
    NSString *cFile = [file stringByAppendingString:@"ViewController"];
    
    NSString *mHFile = [mFile stringByAppendingString:@".h"];
    NSString *mMFile = [mFile stringByAppendingString:@".m"];
    NSString *vHFile = [vFile stringByAppendingString:@".h"];
    NSString *vMFile = [vFile stringByAppendingString:@".m"];
    NSString *cHFile = [cFile stringByAppendingString:@".h"];
    NSString *cMFile = [cFile stringByAppendingString:@".m"];
    
    NSURL *mHURL = [self.exportURL URLByAppendingPathComponent:mHFile];
    NSURL *mMURL = [self.exportURL URLByAppendingPathComponent:mMFile];
    NSURL *vHURL = [self.exportURL URLByAppendingPathComponent:vHFile];
    NSURL *vMURL = [self.exportURL URLByAppendingPathComponent:vMFile];
    NSURL *cHURL = [self.exportURL URLByAppendingPathComponent:cHFile];
    NSURL *cMURL = [self.exportURL URLByAppendingPathComponent:cMFile];
    
    [mHCode writeToURL:mHURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [mMCode writeToURL:mMURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [vHCode writeToURL:vHURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [vMCode writeToURL:vMURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [cHCode writeToURL:cHURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [cMCode writeToURL:cMURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (IBAction)importTouch:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.allowsMultipleSelection = YES;
    panel.allowedFileTypes = @[@"plist"];
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
            for (NSURL *url in self.importURLs) {
                [self codeWithContentsOfURL:url];
            }
        }
    }];
}

@end

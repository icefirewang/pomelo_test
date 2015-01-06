//
//  AppDelegate.m
//  PomeloTest
//
//  Created by wangjian on 15/1/6.
//  Copyright (c) 2015年 Jiayu. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *tf_userId;

@property (weak) IBOutlet NSTextField *tf_toUserId;
@property (weak) IBOutlet NSTextField *tf_input;

@property (weak) IBOutlet NSButton *btn_connect;
@property (weak) IBOutlet NSButton *btn_log;

@property (weak) IBOutlet NSTextField *tf_port;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application

}


-(IBAction)onConnect:(id)sender
{
    [[PomeloManager sharedPomeloManager] connect];
}

-(IBAction)onLog:(id)sender
{
    NSString *tx = [self.tf_userId stringValue];
    [[PomeloManager sharedPomeloManager] loginWithUser:tx password:@"111111" reqFinish:^(NSInteger status, NSDictionary *content) {
        
    }];
}

-(IBAction)onConnectOnPort:(id)sender
{
    NSString *port = [self.tf_port stringValue];
    [[PomeloManager sharedPomeloManager] connectOnPort:port];
}

-(IBAction)onSend:(id)sender
{
    NSString *toSendUId = [self.tf_toUserId stringValue];
    NSString *content = [self.tf_input stringValue];
    long long toUid = toSendUId.longLongValue;
    [[PomeloManager sharedPomeloManager] sendMessage:@{@"test":@"test content",@"content":content} toUId:toUid finished:^(NSInteger status, NSDictionary *content) {
        
    }];
}

-(IBAction)onDisconnect:(id)sender
{
    [[PomeloManager sharedPomeloManager] disConnect];
}


@end

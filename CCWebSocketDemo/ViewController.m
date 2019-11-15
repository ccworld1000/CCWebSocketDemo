//
//  ViewController.m
//  CCWebSocketDemo
//
//  Created by CC on 2019/11/15.
//  Copyright © 2019 CC (deng you hua | cworld1000@gmail.com). All rights reserved.
//

#import "ViewController.h"
#import <SocketRocket/SocketRocket.h>

@interface ViewController ()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *ws;

@end

@implementation ViewController

- (SRWebSocket *)ws {
    if (!_ws) {
        NSURL *url = [NSURL URLWithString:@"ws://localhost:8888"];
        _ws = [[SRWebSocket alloc] initWithURL: url];
        _ws.delegate = self;
    }
    
    return _ws;
}

- (void) connectServer {
    _ws = nil;
    [self.ws open];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self connectServer];
}

- (void) openTest: (NSUInteger) times {
    NSLog(@"openTest");
    for (NSUInteger i = 0; i < times; i++) {
        NSString *string = [NSString stringWithFormat:@"CC Test %@ times", @(i + 1)];
        [self.ws send:string];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"didReceiveMessage: %@", message);
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    [self openTest:6];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [self connectServer];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [self connectServer];
}

- (void)dealloc {
    _ws = nil;
}

@end

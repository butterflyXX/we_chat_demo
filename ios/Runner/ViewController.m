//
//  ViewController.m
//  Runner
//
//  Created by 刘晓晨 on 2024/4/16.
//

#import "ViewController.h"

@interface ViewController ()<FlutterStreamHandler>

@property(nonatomic, copy) FlutterEventSink eventsSink;

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    FlutterEventChannel *channel = [FlutterEventChannel eventChannelWithName:@"event" binaryMessenger:self.binaryMessenger];
    [channel setStreamHandler:self];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
}

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    self.eventsSink = events;
    return nil;
}

- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments { 
    return nil;
}

-(void)keyboardAction:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSValue *keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
    _eventsSink(@{
        @"name":@"KeyboardWillShow",
        @"value":@{
            @"keyboardHeight":@(keyboardFrame.size.height),
            @"duration":[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey],
        },
    });
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

//
//  InterfaceController.m
//  PeeBody WatchKit Extension
//
//  Created by Anthony Michael Fennell on 6/25/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceButton *startStopButton;
@property (weak, nonatomic) IBOutlet WKInterfaceTimer *timer;
@property (nonatomic) BOOL  timerStopped;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.timerStopped = YES;
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)startStopButtonTapped {
    
    if (self.timerStopped) {
        [self.timer start];
        self.timerStopped = NO;
        [self.startStopButton setTitle:@"Stop"];
    } else {
        [self.timer stop];
        self.timerStopped = YES;
        [self.startStopButton setTitle:@"Start"];
    }
}
@end




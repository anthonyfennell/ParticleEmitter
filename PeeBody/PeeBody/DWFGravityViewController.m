//
//  DWFGravityViewController.m
//  PeeBody
//
//  Created by Anthony Michael Fennell on 7/28/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "DWFGravityViewController.h"
#import "DWFParticleGravityView.h"
#import <CoreMotion/CoreMotion.h>

@interface DWFGravityViewController ()

@property (nonatomic, strong) NSOperationQueue *deviceQueue;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet DWFParticleGravityView *fireView;

@end

@implementation DWFGravityViewController

- (IBAction)unwindMultipleParticleViewController:(UIStoryboardSegue *)unwindSegue
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.deviceQueue = [[NSOperationQueue alloc] init];
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 5.0 / 60.0;
    
    // UIDevice *device = [UIDevice currentDevice];
    
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical
                                                            toQueue:self.deviceQueue
                                                        withHandler:^(CMDeviceMotion *motion, NSError *error)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.fireView setZAccel:motion.gravity.z * -150];
                    [self.fireView setXAccel:motion.gravity.y * -150];
                    [self.fireView setYAccel:motion.gravity.x * -150];
                });
        }];
    }];
}

//iOS6+
- (BOOL)shouldAutorotate {
    return NO;
}

//iOS6+
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

@end

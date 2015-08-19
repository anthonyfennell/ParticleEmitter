//
//  DWFMultipleParticleViewController.m
//  PeeBody
//
//  Created by Anthony Michael Fennell on 8/3/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "DWFMultipleParticleViewController.h"
#import "DWFParticleView.h"
#import "UIView+Position.h"

@interface DWFMultipleParticleViewController ()

@property (strong, nonatomic) IBOutlet DWFParticleView *bottomView;
@property (weak, nonatomic) IBOutlet DWFParticleView *middleView;
@property (weak, nonatomic) IBOutlet DWFParticleView *topView;

@end

@implementation DWFMultipleParticleViewController {
    DWFParticleView *particleView1;
    DWFParticleView *particleView2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    float halfHeight = self.view.frame.size.height / 2.0;
//    
//    particleView1 = [[DWFParticleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, halfHeight)];
//    particleView2 = [[DWFParticleView alloc] initWithFrame:CGRectMake(0, halfHeight, self.view.frame.size.width, halfHeight)];
//    
//    [self.view addSubview:particleView1];
//    [self.view addSubview:particleView2];
//
//    [particleView1 showFire];
//    [particleView2 showFire];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UITouch *bottomTouch = [[UITouch alloc] init];
    UITouch *topTouch = [[UITouch alloc] init];
    bottomTouch.view.frame = touch.view.frame;
    bottomTouch.view.frameY = touch.view.frameY + 35;
    
    topTouch.view.frame = touch.view.frame;
    topTouch.view.frameY = touch.view.frameY - 35;
    
    
    [self.bottomView setEmitterPositionFromTouch:bottomTouch];
    [self.middleView setEmitterPositionFromTouch:touch];
    [self.topView setEmitterPositionFromTouch:topTouch];
    //[self.fireView setIsEmitting:YES];
    //[self.fireView burnDownLine];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.fireView setIsEmitting:NO];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // [self.fireView setIsEmitting:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UITouch *bottomTouch = [[UITouch alloc] init];
    UITouch *topTouch = [[UITouch alloc] init];
    bottomTouch.view.frame = touch.view.frame;
    bottomTouch.view.frameY = touch.view.frameY + 35;
    
    topTouch.view.frame = touch.view.frame;
    topTouch.view.frameY = touch.view.frameY - 35;
    
    
    [self.bottomView setEmitterPositionFromTouch:bottomTouch];
    [self.middleView setEmitterPositionFromTouch:touch];
    [self.topView setEmitterPositionFromTouch:topTouch];}

@end

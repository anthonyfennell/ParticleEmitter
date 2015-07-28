//
//  DWFParticleGravityView.m
//  PeeBody
//
//  Created by Anthony Michael Fennell on 7/28/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "DWFParticleGravityView.h"

@implementation DWFParticleGravityView
{
    CAEmitterLayer *fireEmitter;
}

- (void)awakeFromNib
{
    // set ref to the layer
    fireEmitter = (CAEmitterLayer*)self.layer;
    
    //configure the emitter layer
    fireEmitter.emitterPosition = CGPointMake(200, 200);
    // Specifies the center of the particle shape along the z-axis
    fireEmitter.emitterZPosition = 0;
    // Emitter shapes: Point, Line, Rectangle, Cuboid, Circle, Sphere
    fireEmitter.emitterShape = kCAEmitterLayerPoint;
    fireEmitter.emitterSize = CGSizeMake(50.0f, 50.0f);
    // Defines how the particle cells are rendered into the layer
    // Points, Outline, Surface, Volume
    fireEmitter.renderMode = kCAEmitterLayerVolume;
    // Emitter modes: Points, Outline, Surface, Volume
    fireEmitter.emitterMode = kCAEmitterLayerAdditive;
    // Defines whether the layer flattens the particles into its pane.
    fireEmitter.preservesDepth = YES;
    
    CAEmitterCell *fire = [CAEmitterCell emitterCell];
    fire.birthRate = 250;
    fire.lifetime = 3;
    fire.lifetimeRange = 0.5;
    fire.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fire.contents = (id)[[UIImage imageNamed:@"particlesFire1"] CGImage];
    fire.velocity = 26;
    fire.velocityRange = 10;
    fire.emissionRange = M_PI;
    fire.scaleSpeed = 0.3;
    fire.spin = 0.2;
    fire.redRange = 0.5;
    fire.blueRange = 0.15;
    fire.greenRange = 0.2;
    fire.redSpeed = 0.2;
    
    [fire setName:@"fire"];
    fireEmitter.emitterCells = @[fire];
}

- (void)setXAccel:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.xAcceleration"];
}

- (void)setZAccel:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.zAcceleration"];
}

- (void)setYAccel:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.yAcceleration"];
}

@end













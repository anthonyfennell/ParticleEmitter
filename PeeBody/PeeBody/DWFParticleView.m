//
//  DWFParticleView.m
//  PeeBody
//
//  Created by Anthony Michael Fennell on 7/27/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "DWFParticleView.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>

@implementation DWFParticleView
{
    CAEmitterLayer *fireEmitter;
    NSNumber *fireworkVelocity;
    NSNumber *fireworkRange;
    NSNumber *fireworkVelocityRange;
    NSNumber *fireworkGravity;
    BOOL showFire;
    float fireBirthRate;
    float rocketBirthRate;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    showFire = YES;
    fireBirthRate = 0;
    rocketBirthRate = 1;
    fireworkGravity = [NSNumber numberWithInt:80];
    fireworkVelocityRange = [NSNumber numberWithInt:20];
    fireworkVelocity = [NSNumber numberWithInt:130];
    fireworkRange = [NSNumber numberWithInt:8];
    
    
    // set ref to the layer
    fireEmitter = (CAEmitterLayer*)self.layer;
    
    //configure the emitter layer
    fireEmitter.emitterPosition = CGPointMake(50, 100);
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
    fire.lifetime = 2.0;
    fire.lifetimeRange = 0.5;
    fire.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fire.contents = (id)[[UIImage imageNamed:@"particlesFire1"] CGImage];
    fire.velocity = 26;
    //fire.velocityRange = 20;
    fire.yAcceleration = 2;
    fire.emissionRange = M_PI_2;
    fire.scaleSpeed = 0.3;
    fire.spin = 0.5;
    fire.redRange = 0.5;
    fire.blueRange = 0.15;
    fire.greenRange = 0.2;
    fire.redSpeed = 0.5;
    
    [fire setName:@"fire"];
    
    CAEmitterCell *fire2 = [CAEmitterCell emitterCell];
    fire2.birthRate = 250;
    fire2.lifetime = 0.2;
    fire2.lifetimeRange = 0.75;
    fire2.color = [[UIColor colorWithRed:238/255.0 green:232/255.0 blue:154/255.0 alpha:0.1] CGColor];
    fire2.contents = (id)[[UIImage imageNamed:@"particlesFire1"] CGImage];
    fire2.velocity = 10;
    fire2.velocityRange = 5;
    fire2.yAcceleration = 2;
    fire2.emissionRange = M_PI_2;
    fire2.scaleSpeed = 0.3;
    fire2.spin = 0.5;
    
    [fire2 setName:@"fire2"];
    
    
    
    
    UIColor *redColor = [UIColor redColor];
    
    //Invisible particle representing the rocket before the explosion
    CAEmitterCell *rocket = [CAEmitterCell emitterCell];
    rocket.emissionLongitude = M_PI / 2;
    rocket.emissionLatitude = 0;
    rocket.lifetime = 1.6;
    rocket.birthRate = 0;
    rocket.velocity = 400;
    rocket.velocityRange = 100;
    rocket.yAcceleration = -250;
    rocket.emissionRange = M_PI / 4;
    //color = CGColorCreateGenericRGB(0.5, 0.5, 0.5, 0.5);
    //rocket.color = color;
    //CGColorRelease(color);
    rocket.color = redColor.CGColor;
    rocket.redRange = 0.5;
    rocket.greenRange = 0.5;
    rocket.blueRange = 0.5;
    
    //Name the cell so that it can be animated later using keypath
    [rocket setName:@"rocket"];
    
    //Flare particles emitted from the rocket as it flys
    CAEmitterCell *flare = [CAEmitterCell emitterCell];
    //flare.contents = img;
    flare.emissionLongitude = (4 * M_PI) / 2;
    flare.scale = 0.4;
    flare.velocity = 100;
    flare.birthRate = 45;
    flare.lifetime = 1.5;
    flare.yAcceleration = -350;
    flare.emissionRange = M_PI / 7;
    flare.alphaSpeed = -0.7;
    flare.scaleSpeed = -0.1;
    flare.scaleRange = 0.1;
    flare.beginTime = 0.01;
    flare.duration = 0.7;
    flare.color = redColor.CGColor;
    
    //The particles that make up the explosion
    CAEmitterCell *firework = [CAEmitterCell emitterCell];
    firework.contents = (id)[[UIImage imageNamed:@"particlesFire1"] CGImage];
    firework.birthRate = 200;
    firework.scale = 0.6;
    firework.velocity = 130;
    firework.lifetime = 2;
    firework.alphaSpeed = -0.2;
    firework.yAcceleration = -80;
    firework.beginTime = 1.5;
    firework.duration = 0.1;
    firework.emissionRange = 2 * M_PI;
    firework.scaleSpeed = -0.1;
    firework.spin = 2;
    firework.color = redColor.CGColor;
    
    //Name the cell so that it can be animated later using keypath
    [firework setName:@"firework"];
    
    //preSpark is an invisible particle used to later emit the spark
    CAEmitterCell *preSpark = [CAEmitterCell emitterCell];
    preSpark.birthRate = 80;
    preSpark.velocity = firework.velocity * 0.70;
    preSpark.lifetime = 1.7;
    preSpark.yAcceleration = firework.yAcceleration * 0.85;
    preSpark.beginTime = firework.beginTime - 0.2;
    preSpark.emissionRange = firework.emissionRange;
    preSpark.greenSpeed = 100;
    preSpark.blueSpeed = 100;
    preSpark.redSpeed = 100;
    preSpark.color = redColor.CGColor;
    
    //Name the cell so that it can be animated later using keypath
    [preSpark setName:@"preSpark"];
    
    //The 'sparkle' at the end of a firework
    CAEmitterCell *spark = [CAEmitterCell emitterCell];
    //spark.contents = img;
    spark.lifetime = 0.05;
    spark.yAcceleration = -250;
    spark.beginTime = 0.8;
    spark.scale = 0.4;
    spark.birthRate = 10;

    
    
    preSpark.emitterCells = @[spark];
    rocket.emitterCells = @[flare, firework, preSpark];
    
    
    //add the cell to the layer and we're done
    fireEmitter.emitterCells = @[fire, fire2, rocket];
}

+ (Class)layerClass
{
    //configure the UIView to have emitter layer
    return [CAEmitterLayer class];
}



#pragma mark - Public methods

- (void)setEmitterPositionFromTouch:(UITouch *)t
{
    //change the emitter's position
    fireEmitter.emitterPosition = [t locationInView:self];
}

- (void)burnDownLine
{
    int x = self.frame.size.width / 2.0;
    CABasicAnimation *ba = [CABasicAnimation animationWithKeyPath:@"emitterPosition"];
    ba.fromValue = [NSValue valueWithCGPoint:CGPointMake(x, 0)];
    ba.toValue = [NSValue valueWithCGPoint:CGPointMake(x, self.frame.size.height - 50)];
    ba.duration = 3;
    ba.beginTime = CACurrentMediaTime();
    [fireEmitter addAnimation:ba forKey:nil];
    
    
    CABasicAnimation *ba2 = [CABasicAnimation animationWithKeyPath:@"emitterPosition2"];
    ba2.fromValue = [NSValue valueWithCGPoint:CGPointMake(x, self.frame.size.height - 50)];
    ba2.toValue = [NSValue valueWithCGPoint:CGPointMake(x, 0)];
    ba2.duration = 3;
    ba2.beginTime = CACurrentMediaTime() + 3;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObject:ba];
    group.duration = 6;
    
    
    [fireEmitter addAnimation:group forKey:nil];
}

- (void)showFire
{
    showFire = YES;
    [fireEmitter setValue:[NSNumber numberWithFloat:0]
                   forKeyPath:@"emitterCells.rocket.birthRate"];
    [fireEmitter setValue:[NSNumber numberWithFloat:fireBirthRate]
                   forKeyPath:@"emitterCells.fire.birthRate"];
    [fireEmitter setValue:[NSNumber numberWithFloat:fireBirthRate]
               forKeyPath:@"emitterCells.fire2.birthRate"];
}

- (void)hideFire
{
    showFire = NO;
    [fireEmitter setValue:[NSNumber numberWithFloat:0]
               forKeyPath:@"emitterCells.fire.birthRate"];
    [fireEmitter setValue:[NSNumber numberWithFloat:0]
               forKeyPath:@"emitterCells.fire2.birthRate"];
    [fireEmitter setValue:[NSNumber numberWithFloat:rocketBirthRate]
               forKeyPath:@"emitterCells.rocket.birthRate"];
}

- (void)setIsEmitting:(BOOL)isEmitting
{
    // turn on/off the emitting of particles
    //[fireEmitter setValue:[NSNumber numberWithInt:isEmitting?200:0] forKeyPath:@"emitterCells.fire.birthRate"];
    //[fireEmitter setValue:[NSNumber numberWithInt:isEmitting?100:0] forKeyPath:@"emitterCells.fire2.birthRate"];
//    [fireEmitter setValue:[NSNumber numberWithInt:isEmitting?200:0] forKeyPath:@"emitterCells.firework.birthRate"];
//
//    
//    [fireEmitter setValue:[NSNumber numberWithFloat:[fireworkRange floatValue] * M_PI / 4]
//          forKeyPath:@"emitterCells.firework.emissionRange"];
//    
//    [fireEmitter setValue:[NSNumber numberWithFloat:[fireworkVelocity floatValue]]
//          forKeyPath:@"emitterCells.firework.velocity"];
//    
//    [fireEmitter setValue:[NSNumber numberWithFloat:[fireworkVelocityRange floatValue]]
//          forKeyPath:@"emitterCells.firework.velocityRange"];
//    
//    [fireEmitter setValue:[NSNumber numberWithFloat:(-1 * [fireworkGravity floatValue])]
//          forKeyPath:@"emitterCells.firework.yAcceleration"];
}

- (void)setSpin:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
            forKeyPath:@"emitterCells.fire.spin"];

}

- (void)setYAccel:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.yAcceleration"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire2.yAcceleration"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * 1]
                forKeyPath:@"emitterCells.rocket.yAcceleration"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * 0.85]
                forKeyPath:@"emitterCells.rocket.emitterCells.preSpark.yAcceleration"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * 1]
                forKeyPath:@"emitterCells.rocket.emitterCells.firework.yAcceleration"];
}

- (void)setEmissionRange:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v * M_PI_4]
               forKeyPath:@"emitterCells.fire.emissionRange"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * M_PI_4 * 0.7]
               forKeyPath:@"emitterCells.fire2.emissionRange"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * M_PI_4]
               forKeyPath:@"emitterCells.rocket.emitterCells.firework.emissionRange"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * M_PI_4]
               forKeyPath:@"emitterCells.rocket.emitterCells.preSpark.emissionRange"];
}

- (void)setVelocity:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.velocity"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * 0.7]
               forKeyPath:@"emitterCells.fire2.velocity"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.rocket.velocity"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.rocket.emitterCells.firework.velocity"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * 0.7]
               forKeyPath:@"emitterCells.rocket.emitterCells.preSpark.velocity"];
}

- (void)setBirthRate:(float)v
{
    fireBirthRate = v;
    if (showFire) {
        [fireEmitter setValue:[NSNumber numberWithFloat:v]
                   forKeyPath:@"emitterCells.fire.birthRate"];
        [fireEmitter setValue:[NSNumber numberWithFloat:v * 0.7]
                   forKeyPath:@"emitterCells.fire2.birthRate"];
    }
}

- (void)setScaleSpeed:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.scaleSpeed"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire2.scaleSpeed"];
}

- (void)setLifetime:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.lifetime"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * 0.3]
               forKeyPath:@"emitterCells.fire2.lifetime"];
}

- (void)setVelocityRange:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.velocityRange"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * 0.3]
               forKeyPath:@"emitterCells.fire2.velocityRange"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.rocket.velocityRange"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.rocket.emitterCells.firework.velocityRange"];
}

- (void)setScale:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.scale"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire2.scale"];
}

- (void)setLifetimeRange:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.lifetimeRange"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v * 0.25]
               forKeyPath:@"emitterCells.fire2.lifetimeRange"];
}

- (void)setXAccel:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.xAcceleration"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire2.xAcceleration"];
}

- (void)setZAccel:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire.zAcceleration"];
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:@"emitterCells.fire2.zAcceleration"];
}





- (void)setEmitterMode:(DWFMode)mode
{
    switch (mode) {
        case DWFModePoints:
            fireEmitter.emitterMode = kCAEmitterLayerPoints;
            break;
        case DWFModeOutline:
            fireEmitter.emitterMode = kCAEmitterLayerOutline;
            break;
        case DWFModeSurface:
            fireEmitter.emitterMode = kCAEmitterLayerSurface;
            break;
        case DWFModeVolume:
            fireEmitter.emitterMode = kCAEmitterLayerVolume;
            break;
        default:
            break;
    }
}

- (void)setRenderMode:(DWFRenderMode)mode
{
    switch (mode) {
        case DWFRenderModeUndordered:
            [fireEmitter setRenderMode:kCAEmitterLayerUnordered];
            break;
        case DWFRenderModeOldestFirst:
            [fireEmitter setRenderMode:kCAEmitterLayerOldestFirst];
            break;
        case DWFRenderModeOldestLast:
            [fireEmitter setRenderMode:kCAEmitterLayerOldestLast];
            break;
        case DWFRenderModeBackToFront:
            [fireEmitter setRenderMode:kCAEmitterLayerBackToFront];
            break;
        case DWFRenderModeAdditive:
            [fireEmitter setRenderMode:kCAEmitterLayerAdditive];
            break;
        default:
            break;
    }
}

- (void)setShape:(DWFShape)shape
{
    switch (shape) {
        case DWFShapePoint:
            [fireEmitter setEmitterShape:kCAEmitterLayerPoint];
            break;
        case DWFShapeLine:
            [fireEmitter setEmitterShape:kCAEmitterLayerLine];
            break;
        case DWFShapeRectangle:
            [fireEmitter setEmitterShape:kCAEmitterLayerRectangle];
            break;
        case DWFShapeCuboid:
            [fireEmitter setEmitterShape:kCAEmitterLayerCuboid];
            break;
        case DWFShapeCircle:
            [fireEmitter setEmitterShape:kCAEmitterLayerCircle];
            break;
        case DWFShapeSphere:
            [fireEmitter setEmitterShape:kCAEmitterLayerSphere];
            break;
        default:
            break;
    }
}

@end


//fire2.birthRate = 0;
//fire2.lifetime = 5.0;
//fire2.lifetimeRange = 0.5;
//fire2.color = [[UIColor colorWithRed:228/255.0 green:237/255.0 blue:47/255.0 alpha:1.0] CGColor];
//fire2.contents = (id)[[UIImage imageNamed:@"particlesFire1"] CGImage];
//fire2.velocity = 10;
//fire2.velocityRange = 10;
//fire2.yAcceleration = 2;
//fire2.emissionRange = M_PI_2;
//fire2.scaleSpeed = 0.3;
//fire2.spin = 0.5;



























//
//  DWFViewController.m
//  PeeBody
//
//  Created by Anthony Michael Fennell on 7/27/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "DWFViewController.h"

@interface DWFViewController ()

@property (weak, nonatomic) IBOutlet UISlider *spinSlider;
@property (weak, nonatomic) IBOutlet UISlider *yAccelSlider;
@property (weak, nonatomic) IBOutlet UISlider *emissionSlider;
@property (weak, nonatomic) IBOutlet UISlider *velocitySlider;
@property (weak, nonatomic) IBOutlet UISlider *birthRateSlider;
@property (weak, nonatomic) IBOutlet UISlider *scaleSpeedSlider;
@property (weak, nonatomic) IBOutlet UISlider *lifetimeSlider;
@property (weak, nonatomic) IBOutlet UISlider *velocityRangeSlider;
@property (weak, nonatomic) IBOutlet UISlider *scaleSlider;
@property (weak, nonatomic) IBOutlet UISlider *lifetimeRangeSlider;
@property (weak, nonatomic) IBOutlet UISlider *xAccelSlider;
@property (weak, nonatomic) IBOutlet UISlider *zAccelSlider;

@end

@implementation DWFViewController

- (IBAction)unwindGravityViewController:(UIStoryboardSegue *)unwindSegue
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    float height = self.spinSlider.frame.size.height;
    float width = self.spinSlider.frame.size.width;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"Spin"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.spinSlider addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"y Acceleration"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.yAccelSlider addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"emission Range * pi/4"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.emissionSlider addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"velocity"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.velocitySlider addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"birth rate"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.birthRateSlider addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"scaleSpeed"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.scaleSpeedSlider addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"lifetime"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.lifetimeSlider addSubview:label];

    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"velocity Range"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.velocityRangeSlider addSubview:label];

    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"scale"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.scaleSlider addSubview:label];

    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"lifetime range"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.lifetimeRangeSlider addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"x Acceleration"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.xAccelSlider addSubview:label];

    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height / 2.0)];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"z Acceleration"
                                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]}];
    [self.zAccelSlider addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setSliderValuesFromEmitterCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.fireView setEmitterPositionFromTouch:[touches anyObject]];
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
    [self.fireView setEmitterPositionFromTouch:[touches anyObject]];
}

- (IBAction)slidersMoved:(id)sender
{
    UISlider *slider = sender;
    if (slider == self.spinSlider) {
        [self.fireView setSpin:self.spinSlider.value];
    } else if (slider == self.yAccelSlider) {
        [self.fireView setYAccel:self.yAccelSlider.value];
    } else if (slider == self.emissionSlider) {
        [self.fireView setEmissionRange:self.emissionSlider.value];
    } else if (slider == self.velocitySlider) {
        [self.fireView setVelocity:self.velocitySlider.value];
    } else if (slider == self.birthRateSlider) {
        [self.fireView setBirthRate:self.birthRateSlider.value];
    } else if (slider == self.scaleSpeedSlider) {
        [self.fireView setScaleSpeed:self.scaleSpeedSlider.value];
    } else if (slider == self.lifetimeSlider) {
        [self.fireView setLifetime:self.lifetimeSlider.value];
    } else if (slider == self.velocityRangeSlider) {
        [self.fireView setVelocityRange:self.velocityRangeSlider.value];
    } else if (slider == self.scaleSlider) {
        [self.fireView setScale:self.scaleSlider.value];
    } else if (slider == self.lifetimeRangeSlider) {
        [self.fireView setLifetimeRange:self.lifetimeRangeSlider.value];
    } else if (slider == self.zAccelSlider) {
        [self.fireView setZAccel:self.zAccelSlider.value];
    } else if (slider == self.xAccelSlider) {
        [self.fireView setXAccel:self.xAccelSlider.value];
    }
    
}


- (IBAction)segmentedControlTapped:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    if (control.selectedSegmentIndex == 0) {
        [self.fireView selectEmitterCell:EmitCellSmoke];
    } else if (control.selectedSegmentIndex == 1) {
        [self.fireView selectEmitterCell:EmitCellTwo];
    } else if (control.selectedSegmentIndex == 2) {
        [self.fireView selectEmitterCell:EmitCellThree];
    } else {
        [self.fireView selectEmitterCell:EmitCellFour];
    }
    [self setSliderValuesFromEmitterCell];
}

- (IBAction)emitterModeChanged:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            [self.fireView setEmitterMode:DWFModePoints];
            break;
        case 1:
            [self.fireView setEmitterMode:DWFModeOutline];
            break;
        case 2:
            [self.fireView setEmitterMode:DWFModeSurface];
            break;
        case 3:
            [self.fireView setEmitterMode:DWFModeVolume];
            break;
        default:
            break;
    }
}

- (IBAction)renderModeChanged:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            [self.fireView setRenderMode:DWFRenderModeUndordered];
            break;
        case 1:
            [self.fireView setRenderMode:DWFRenderModeOldestFirst];
            break;
        case 2:
            [self.fireView setRenderMode:DWFRenderModeOldestLast];
            break;
        case 3:
            [self.fireView setRenderMode:DWFRenderModeBackToFront];
            break;
        case 4:
            [self.fireView setRenderMode:DWFRenderModeAdditive];
            break;
        default:
            break;
    }
}


- (IBAction)shapeChanged:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            [self.fireView setShape:DWFShapePoint];
            break;
        case 1:
            [self.fireView setShape:DWFShapeLine];
            break;
        case 2:
            [self.fireView setShape:DWFShapeRectangle];
            break;
        case 3:
            [self.fireView setShape:DWFShapeCuboid];
            break;
        case 4:
            [self.fireView setShape:DWFShapeCircle];
            break;
        case 5:
            [self.fireView setShape:DWFShapeSphere];
            break;
        default:
            break;
    }
}


#pragma mark - Cell Values

- (void)setSliderValuesFromEmitterCell
{
    CAEmitterCell *cell = self.fireView.selectedCell;
    self.spinSlider.value           = cell.spin;
    self.yAccelSlider.value         = cell.yAcceleration;
    self.emissionSlider.value       = cell.emissionRange / M_PI_4;
    self.velocitySlider.value       = cell.velocity;
    self.birthRateSlider.value      = cell.birthRate;
    self.scaleSpeedSlider.value     = cell.scaleSpeed;
    self.lifetimeSlider.value       = cell.lifetime;
    self.velocityRangeSlider.value  = cell.velocityRange;
    self.scaleSlider.value          = cell.scale;
    self.lifetimeRangeSlider.value  = cell.lifetimeRange;
    self.xAccelSlider.value         = cell.xAcceleration;
    self.zAccelSlider.value         = cell.zAcceleration;
}



@end













//@property (weak, nonatomic) IBOutlet UISlider *spinSlider;
//@property (weak, nonatomic) IBOutlet UISlider *yAccelSlider;
//@property (weak, nonatomic) IBOutlet UISlider *emissionSlider;
//@property (weak, nonatomic) IBOutlet UISlider *velocitySlider;
//@property (weak, nonatomic) IBOutlet UISlider *birthRateSlider;
//@property (weak, nonatomic) IBOutlet UISlider *scaleSpeedSlider;
//@property (weak, nonatomic) IBOutlet UISlider *lifetimeSlider;
//@property (weak, nonatomic) IBOutlet UISlider *velocityRangeSlider;
//@property (weak, nonatomic) IBOutlet UISlider *scaleSlider;
//@property (weak, nonatomic) IBOutlet UISlider *lifetimeRangeSlider;
//@property (weak, nonatomic) IBOutlet UISlider *xAccelSlider;
//@property (weak, nonatomic) IBOutlet UISlider *zAccelSlider;

















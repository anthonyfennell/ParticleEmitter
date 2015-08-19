//
//  AFViewController.m
//  PeeBody
//
//  Created by Anthony Michael Fennell on 6/1/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "AFViewController.h"
#import "UIViewController+StatusBar.h"
#import "OSTabBar.h"
#import "OSTabBarController.h"
#import "OSTrayViewController.h"
#import "Prefix.pch"

@interface AFViewController ()

@property (weak, nonatomic) IBOutlet UILabel *aLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AFViewController {
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addStatusBarBackground];
    self.aLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Apple and a pear", nil)];
    
    
//    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshTextLabel) userInfo:nil repeats:YES];
//    [timer fire];
}

- (void)viewWillDisappear:(BOOL)animated {
    [timer invalidate];
}


- (void)refreshTextLabel {
    //self.aLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Apple and a pear", nil)];
    self.aLabel.text = NSLocalizedStringFromTableInBundle(@"Apple and a pear", nil, currentLanguageBundle, @"");
    self.imageView.image = [UIImage imageNamed:@"speakerIcon1.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        return YES;
//    }
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        /* iPad device */
        return UIInterfaceOrientationMaskLandscape;
    }else{
        /* iPhone device */
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (IBAction)showtabBarButtonTapped:(id)sender {
    
    OSTabBarController *tabBarController = [[OSTabBarController alloc] init];
    OSTabBar *tabBar = tabBarController.tabBar;
    
    tabBar.tabBarHeight = 120;
    tabBar.tintColor = [UIColor brownColor];
    tabBar.barTintColor = [UIColor yellowColor];
    tabBar.itemSpacing = 60;
    tabBar.itemWidth = 80;
    
    UIViewController *viewA = [[UIViewController alloc] init];
    viewA.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Article" image:[UIImage imageNamed:@"articleIcon1.png"] tag:0];
    [viewA.view setBackgroundColor:[UIColor redColor]];
    
    
    UIViewController *viewB = [[UIViewController alloc] init];
    viewB.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Magazine" image:[UIImage imageNamed:@"magazineIcon1.png"] tag:1];
    [viewB.view setBackgroundColor:[UIColor brownColor]];
    
    UIViewController *viewC = [[UIViewController alloc] init];
    viewC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Video" image:[UIImage imageNamed:@"videoIcon1.png"] tag:2];
    [viewC.view setBackgroundColor:[UIColor blackColor]];
    
    tabBarController.viewControllers = @[viewA, viewB, viewC];
    
    [self.navigationController presentViewController:tabBarController animated:YES completion:nil];
    
}


- (IBAction)showTrayButtonTapped:(id)sender {
    
    UIViewController *contentVC = [[UIViewController alloc] init];
    contentVC.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *menuVC = [[UIViewController alloc] init];
    menuVC.view.backgroundColor = [UIColor redColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.backgroundColor = [UIColor blackColor];
    [contentVC.view addSubview:view];
    
    OSTrayViewController *trayVC = [[OSTrayViewController alloc] initWithTraySide:OSTrayViewTopSide];
    trayVC.shouldResizeContentView = YES;
    trayVC.shouldDisplayButton = YES;
    trayVC.menuWidth = [UIScreen mainScreen].bounds.size.width;
    trayVC.menuHeight = 300;
    trayVC.menuY = 0;
    trayVC.contentViewController = contentVC;
    trayVC.menuViewController = menuVC;
    
    UIView *button = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    button.backgroundColor = [UIColor greenColor];
    
    trayVC.buttonView = button;
    
    [self presentViewController:trayVC animated:YES completion:nil];
}


- (IBAction)languageChanged:(UISegmentedControl *)sender
{
    NSString *currentLanguage = @"en";
    if (sender.selectedSegmentIndex == 1) {
        currentLanguage = @"es";
    }

    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:currentLanguage, nil] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self refreshTextLabel];
}



@end


































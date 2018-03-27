//
//  ViewController.m
//  RXDeviceManagerDemo
//
//  Created by Ron on 3/27/18.
//  Copyright © 2018 RX. All rights reserved.
//

#import "ViewController.h"
#import "RXDeviceManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *deviceInfoLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableString *deviceInfo = [NSMutableString stringWithFormat:@"Device: %@\n", [RXDeviceManager deviceName]];
    [deviceInfo appendFormat:@"iPhone X ? %@\n", [RXDeviceManager iPhoneX]? @"YES" : @"NO"];
    [deviceInfo appendFormat:@"Screen size: %@\n", NSStringFromCGSize([RXDeviceManager screenSize])];
    [self.deviceInfoLabel setText:deviceInfo];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

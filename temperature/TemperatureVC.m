//
//  TemperatureVC.m
//  temperature
//
//  Created by Timothy Lee on 10/12/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TemperatureVC.h"

@interface TemperatureVC ()

@property (weak, nonatomic) IBOutlet UITextField *fahrenheitTextField;
@property (weak, nonatomic) IBOutlet UITextField *celsiusTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMarginConstraint;

@end

@implementation TemperatureVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fahrenheitTextField.delegate = self;
    self.celsiusTextField.delegate = self;
    
    [self.fahrenheitTextField becomeFirstResponder];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.topMarginConstraint.constant = 40;
    } else {
        self.topMarginConstraint.constant = 10;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.view action:@selector(endEditing:)];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([text isEqualToString:@""]) {
        self.fahrenheitTextField.text = @"";
        self.celsiusTextField.text = @"";
    } else if (textField == self.fahrenheitTextField) {
        float fahrenheit = [text floatValue];
        float celsius = (fahrenheit - 32) * 5.0 / 9;
        self.celsiusTextField.text = [NSString stringWithFormat:@"%d", (int)round(celsius)];
    } else {
        float celsius = [text floatValue];
        float fahrenheit = (celsius * 9.0) / 5 + 32;
        self.fahrenheitTextField.text = [NSString stringWithFormat:@"%d", (int)round(fahrenheit)];
    }
    
    return YES;
}

@end

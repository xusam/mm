//
//  BaseViewController.m
//  MiuGril
//
//  Created by sam on 13-5-30.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize asimanager=_asimanager;
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
      self.view.backgroundColor=[UIColor colorWithRed:243.0/255.0f green:243.0/255.0f blue:243.0/255.0f alpha:1];
    self.asimanager=[[ASIManager alloc] initWithDelegate:self];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

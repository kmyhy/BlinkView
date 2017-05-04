//
//  ViewController.m
//  BlinkView
//
//  Created by qq on 2017/5/4.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "ViewController.h"
#import "BlinkView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet BlinkView *blinkView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action:(id)sender {
    if(_blinkView.stopped){
        [_blinkView animating];
    }else{
        [_blinkView stopAnimating];
    }
}

@end

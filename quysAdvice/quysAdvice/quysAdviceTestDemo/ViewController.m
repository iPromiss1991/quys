//
//  ViewController.m
//  AdviceTest
//
//  Created by quys on 2019/12/6.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "ViewController.h"
#import <quysAdvice/QuysAdviceManager.h>
#import <quysAdvice/QuysAdSplash.h>
#import <Masonry/Masonry.h>
#import "QuysViewController.h"

#import <objc/runtime.h>

@interface ViewController ()<QuysAdSplashDelegate>
@property (nonatomic,strong) QuysAdSplashService *service;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    QuysAdSplashService *service = [[QuysAdSplashService alloc ]initWithID:@"quystest-cp" key:@"quystest-cp" cGrect:CGRectMake(0, 100, 300, 100) eventDelegate:self parentView:self.view];
    [service loadAdViewNow];
    self.service = service;
  

    // Do any additional setup after loading the view.
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
}
-(void)quys_requestStart
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)quys_requestSuccess
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self.service showAdView];


}
-(void)quys_requestFial:(NSError *)error
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
-(void)quys_interstitialOnExposure
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
-(void)quys_interstitialOnClick:(CGPoint)cpClick
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self presentViewController:[QuysViewController new] animated:YES completion:nil];

}
-(void)quys_interstitialOnAdClose
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
@end

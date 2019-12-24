//
//  QuysPictureViewController.m
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysPictureViewController.h"

@interface QuysPictureViewController ()
@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) NSString *picUrl;

@end

@implementation QuysPictureViewController

- (instancetype)initWithUrl:(NSString*)picUrl
{
    if (self == [super init])
    {
        self.picUrl = picUrl;
    }return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    QuysNavigationController *nav= (QuysNavigationController*)self.navigationController;
    nav.hideNavbar = YES;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.view addSubview:imgView];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.picUrl]];
    self.imgView = imgView;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)updateViewConstraints
{
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(kNavBarHeight);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    [super updateViewConstraints];
}



- (void)clickLeftBtnRespond
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}



- (void)clickRightBtnRespond
{
    [self.navigationController popViewControllerAnimated:YES];

}


@end

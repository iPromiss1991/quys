//
//  QuysWebViewController.m
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysWebViewController.h"
#import <WebKit/WebKit.h>
@interface QuysWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong) NSString *strUrl;
@property (nonatomic,strong) NSString *strHtml;

@end

@implementation QuysWebViewController

- (instancetype)initWithUrl:(NSString *)requestUrl
{
    if (self == [super init])
    {
        [self setconfigUrl:requestUrl];
    }
    return self;
}

- (instancetype)initWithHtml:(NSString *)html
{
    if (self == [super init])
    {
        [self setconfigHtml:html];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self vhl_setNavBarBackgroundColor:[UIColor colorWithRed:(rand() % 100 * 0.01) green:(rand() % 100 * 0.01) blue:0.86 alpha:1.00]];
    [self vhl_setNavigationSwitchStyle:VHLNavigationSwitchStyleFakeNavBar];
    //[self vhl_setNavBarBackgroundImage:[UIImage imageNamed:@"millcolorGrad"]];
    //[self vhl_setNavBarBackgroundAlpha:0.f];
    [self vhl_setStatusBarHidden:YES];
    [self vhl_setNavBarShadowImageHidden:YES];
    [self vhl_setNavBarBackgroundAlpha:1.0f];
    [self vhl_setNavBarHidden:NO];
    [self setQus_navBackButtonTitle:@"存储"];
    [self vhl_setInteractivePopGestureRecognizerEnable:NO];//TODO
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    //这个类主要用来做native与JavaScript的交互管理
    WKUserContentController * wkUController = [[WKUserContentController alloc] init];
    config.userContentController = wkUController;
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight - kNavBarHeight) configuration:config];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    webView.allowsBackForwardNavigationGestures = YES;
    if (self.strUrl)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        [webView loadRequest:request];
    }else
    {
        [webView loadHTMLString:self.strHtml baseURL:nil];
    }
    self.webView = webView;
    
    webView.backgroundColor = [UIColor purpleColor];
    self.view.backgroundColor = [UIColor orangeColor];
 }

 


#pragma mark - PrivateMethod

- (void)setconfigUrl:(NSString *)requestUrl
{
    NSAssert(requestUrl != nil || requestUrl.length>0, kStringFormat(@"\n<<<输入的webURL无效%@",requestUrl));
    self.strUrl = requestUrl;
}


- (void)setconfigHtml:(NSString *)html
{
    NSAssert(html == nil || html.length<=0, kStringFormat(@"\n<<<输入的html无效%@",html));
    self.strHtml = html;
}


#pragma mark - PrivateMethod

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveBackgroundImageViewNotify object:nil];
}




@end

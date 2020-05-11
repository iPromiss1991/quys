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
    self.view.backgroundColor = [UIColor whiteColor];
    [self vhl_setNavBarBackgroundColor:[UIColor purpleColor]];
    [self vhl_setNavigationSwitchStyle:VHLNavigationSwitchStyleFakeNavBar];
    //[self vhl_setNavBarBackgroundImage:[UIImage imageNamed:@"millcolorGrad"]];
    //[self vhl_setNavBarBackgroundAlpha:0.f];
    [self vhl_setStatusBarHidden:YES];
    [self vhl_setNavBarShadowImageHidden:YES];
    [self vhl_setNavBarBackgroundAlpha:1.0f];
    [self vhl_setNavBarHidden:NO];
    [self setQus_navBackButtonColor:self.navigationController.navigationBar.tintColor ];
    [self setQus_navBackButtonTitle:@"返回"];
    [self vhl_setInteractivePopGestureRecognizerEnable:NO];
    
    
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
    webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:webView];
    self.webView = webView;
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}
//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}
// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}
// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString * redirectUrl = navigationAction.request.URL.absoluteString;
    NSLog(@"发送跳转请求：%@",redirectUrl);
//    NSURLSessionDataTask *dataTask = [[NSURLSessionDataTask alloc] init];
//    if ([redirectUrl containsString:@"itms-apps"] || [redirectUrl containsString:@"itms://"])//1、itms-appss://    2、itms-apps://
//    {
//        [dataTask redirectToAppStore:redirectUrl callBack:^(NSString * _Nonnull strAppstoreUrl) {
//
//            [self openAppWithUrl:strAppstoreUrl];
//            decisionHandler(WKNavigationActionPolicyCancel);
//        }];
//
//    }else
    {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

// 根据客户端收到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}


//    //需要响应身份验证时调用 同样在block中需要传入用户身份凭证
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
//    //用户身份信息
//    NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
//    //为 challenge 的发送方提供 credential
//    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
//    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
//}


//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}
#pragma mark - PrivateMethod

- (void)setconfigUrl:(NSString *)requestUrl
{
    //    NSAssert(requestUrl != nil || requestUrl.length > 0, kStringFormat(@"\n<<<输入的webURL无效%@",requestUrl));
    self.strUrl = requestUrl;
}


- (void)setconfigHtml:(NSString *)html
{
    //    NSAssert(html != nil || html.length > 0, kStringFormat(@"\n<<<输入的html无效%@",html));
    self.strHtml = html;
}


#pragma mark - PrivateMethod

-(void)qus_navigationItemHandleBack:(UIButton *)button
{
    [super qus_navigationItemHandleBack:button];
    
}



@end

//
//  NBWebViewHandler.h
//  NebulaCore
//
//  Created by JoAmS on 2017. 7. 31..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef enum {
    kWebViewtype_UIWebView,
    kWebViewType_WKWebView
}kWebViewType;

typedef void (^CompletionBlock)(id, NSError*);

@interface NBWebViewHandler : NSObject

@property (nonatomic, assign) kWebViewType webViewType;

- (NBWebViewHandler*)initWithWebViewType:(kWebViewType)webViewType;

// UIWebView or WKWebView
- (id)webView;

- (void)setFrame:(CGRect)frame;
- (void)setDelegate:(id)delegate;
- (void)clean;
- (void)setScrollEnabled:(BOOL)enabled;
- (void)setBounces:(BOOL)bounces;
- (void)setUserAgent:(NSString*)userAgent;

// Load
- (void)loadRequest:(NSURLRequest *)request;
- (void)loadURL:(NSString *)url;
- (void)stopLoading;

// Web history
- (void)goBack;
- (void)goForward;
- (BOOL)canGoBack;
- (BOOL)canGoForward;
- (BOOL)isLoading;

// JavaScript
- (void)stringByEvaluatingJavaScriptFromString:(NSString *)javascript completion:(CompletionBlock)completion;

// Info
- (NSString *)title;
- (NSURL *)URL;

@end

/*
 SMSLoadingView.m
 
 Copyright (c) 2010, Alex Silverman
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 3. Neither the name of Alex Silverman nor the
 names of its contributors may be used to endorse or promote products
 derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SMSLoadingView.h"
#import "SMSCoreGraphics.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation SMSLoadingView {
    UIView *_roundedView;
}

@synthesize status;

+ (id)loadingViewWithStatus:(NSString *)txt
{
    UIWindow *keyWindow = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    CGRect frame = keyWindow.bounds;
    SMSLoadingView *lv = [[SMSLoadingView alloc] initWithFrame:frame];
    lv.status = txt;
    return lv;
}

#pragma mark - Properties
- (void)setStatus:(NSString *)txt
{
	status = [txt copy];
	statusLabel.text = status;
}

#pragma mark - Actions
- (void)showOverView:(UIView *)view
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _roundedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    _roundedView.layer.cornerRadius = 8.0;
    _roundedView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    _roundedView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _roundedView.layer.borderWidth = 2.0;
    _roundedView.layer.shadowColor = [UIColor blackColor].CGColor;
    _roundedView.layer.shadowOffset = CGSizeMake(0, 10);
    _roundedView.layer.shadowOpacity = 0.5;

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
	[spinner startAnimating];
	[_roundedView addSubview:spinner];
	
	statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	statusLabel.backgroundColor = [UIColor clearColor];
	statusLabel.textColor = [UIColor whiteColor];
    statusLabel.font = [UIFont boldSystemFontOfSize:18];
	statusLabel.adjustsFontSizeToFitWidth = YES;
	statusLabel.minimumFontSize = 10;
    statusLabel.textAlignment = UITextAlignmentCenter;
	statusLabel.text = status;
	[_roundedView addSubview:statusLabel];

    if (!view) {
        /* Take a stab at the correct view to show over. */
        UIWindow *window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
        view = window.rootViewController.view;
    }
    self.frame = view.bounds;
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                             | UIViewAutoresizingFlexibleHeight);
    _roundedView.center = self.center;
    [self addSubview:_roundedView];
    [view addSubview:self];
}

- (void)dismiss
{
	[spinner stopAnimating];
    [self removeFromSuperview];
}

#pragma mark - Drawing
- (void)layoutSubviews
{
	[super layoutSubviews];

    _roundedView.center = self.center;
    
    CGRect bounds = _roundedView.bounds;
    CGFloat aThird = bounds.size.height/3.0;
    spinner.center = CGPointMake(bounds.size.width/2.0, aThird);
    statusLabel.frame = CGRectMake(20, aThird*2-5, bounds.size.width-40, 20);
}
@end

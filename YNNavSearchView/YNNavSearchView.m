//
//  YNNavSearchView.m
//  OffsetBrokenViewDemo
//
//  Created by liyangly on 2018/10/19.
//  Copyright © 2018 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface UIImage (YNColor)

+ (UIImage *)yn_imageNamed:(NSString *)name withTintColor:(UIColor *)color;

@end

@implementation UIImage (YNColor)

+ (UIImage *)yn_imageNamed:(NSString *)name withTintColor:(UIColor *)color {
    
    UIImage *img = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    [color set];
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end



#import "YNNavSearchView.h"

#ifndef DESIGN_WIDTH
#define DESIGN_WIDTH (375)
#endif

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#endif

//宽缩放
#ifndef S_X
#define S_X(x)  ((x) * SCREEN_WIDTH / DESIGN_WIDTH)
#endif

// Color
#ifndef UIColorFromHexWithAlpha
#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#endif

#ifndef UIColorFromHex
#define UIColorFromHex(hexValue)            UIColorFromHexWithAlpha(hexValue,1.0)
#endif

#ifndef UIColorFromRGBA
#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

#ifndef UIColorFromRGB
#define UIColorFromRGB(r,g,b)               UIColorFromRGBA(r,g,b,1.0)
#endif

@interface YNNavSearchView()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *searchBtn;

@end

@implementation YNNavSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    self.cancelBtn.hidden = YES;
    [self addSubview:self.cancelBtn];
    self.cancelBtn.frame = CGRectMake(0, 0, 44, 40);
    
    self.searchBtn.hidden = YES;
    [self addSubview:self.searchBtn];
    self.searchBtn.frame = CGRectMake(SCREEN_WIDTH - 80 - 15, 0, 80, 40);
    
    [self addSubview:self.searchTextField];
    self.searchTextField.frame = CGRectMake(16.5, 0, SCREEN_WIDTH - 48, 40);
}

#pragma mark - Private Method
- (void)updateNavSearch:(BOOL)isEdit {
    
    if (isEdit) {
        [UIView animateWithDuration:0.1 animations:^{
            self.cancelBtn.hidden = NO;
            self.searchTextField.frame = CGRectMake(44, 0, SCREEN_WIDTH - 15 - 44 - 80, 40);
            self.searchBtn.hidden = NO;
        }];
        [self layoutIfNeeded];
    } else {
        [self.searchTextField resignFirstResponder];
        [UIView animateWithDuration:0.1 animations:^{
            self.cancelBtn.hidden = YES;
            self.searchTextField.frame = CGRectMake(16.5, 0, SCREEN_WIDTH - 48, 40);
            self.searchBtn.hidden = YES;
        }];
        [self setNeedsLayout];
    }
}

#pragma mark - UIControl Actions
- (void)cancelSearch {
    [self updateNavSearch:NO];
}

- (void)searchButtonClick {
    if (self.searchResult) {
        self.searchResult();
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self updateNavSearch:YES];
}

#pragma mark - Getters
- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [UITextField new];
        _searchTextField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:S_X(12)];
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, S_X(12), S_X(12))];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_X(22), S_X(12))];
        [view addSubview:imgView];
        imgView.image = [UIImage yn_imageNamed:@"new_caption_search" withTintColor:UIColorFromHex(0x38393b)];
        _searchTextField.leftView = view;
        _searchTextField.placeholder = @"Search";
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.backgroundColor = [UIColor whiteColor];
        _searchTextField.delegate = self;
        _searchTextField.layer.borderColor = UIColorFromRGB(226, 226, 226).CGColor;
        _searchTextField.layer.borderWidth = 1;
    }
    return _searchTextField;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage:[UIImage yn_imageNamed:@"new_caption_nav_back" withTintColor:UIColorFromHex(0x38393b)] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setTitle:@"Search" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:UIColorFromRGB(56, 57, 59) forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

@end
